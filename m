Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136131AbRAWGb5>; Tue, 23 Jan 2001 01:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136149AbRAWGbs>; Tue, 23 Jan 2001 01:31:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62725 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S136131AbRAWGbh>;
	Tue, 23 Jan 2001 01:31:37 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101222155.f0MLtNe01781@flint.arm.linux.org.uk>
Subject: Re: PATCH: "Pass module parameters" to built-in drivers
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 22 Jan 2001 21:55:23 +0000 (GMT)
Cc: Werner.Almesberger@epfl.ch (Werner Almesberger),
        david_luyer@pacific.net.au (David Luyer), alan@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <5766.980181036@ocs3.ocs-net> from "Keith Owens" at Jan 23, 2001 03:30:36 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> It is part of my total Makefile rewrite for 2.5.  A clean
> implementation of module parameters mapping to setup code requires the
> mapping of a source file to the module it is linked into.  That
> information is difficult to extract with the current Makefile system,
> my rewrite makes it easy.

Hmm, don't we already have all that __setup() stuff laying around?  Ok,
it might not be built into the .o for modules, but it could be.  Could
we not do something along the lines of:

1. User passes parameters on the kernel command line.
2. modprobe reads the kernel command line and sorts out those that
   correspond to the __setup() stuff in the module being loaded.
3. modprobe combines in any extra settings from /etc/modules.conf

IIRC, this would satisfy the original posters intentions, presumably
without too much hastle?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
