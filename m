Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAYMXt>; Thu, 25 Jan 2001 07:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRAYMXj>; Thu, 25 Jan 2001 07:23:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23822 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129511AbRAYMXa>;
	Thu, 25 Jan 2001 07:23:30 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101251149.f0PBnB206123@flint.arm.linux.org.uk>
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
To: tim@parrswood.manchester.sch.uk (Tim Fletcher)
Date: Thu, 25 Jan 2001 11:49:10 +0000 (GMT)
Cc: phillips@innominate.de (Daniel Phillips),
        Shawn.Starr@Home.net (Shawn Starr), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101241803290.30141-100000@pine.parrswood.manchester.sch.uk> from "Tim Fletcher" at Jan 24, 2001 06:05:02 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Fletcher writes:
> What ever a none privilaged user space apps does witness:
> 
> root@localhost# dd if=/dev/random of=/dev/mem

If you can do that as a non-priviledged user, then you've got bigger
security problems than that.

/dev/mem should NOT be read/writable by anyone other than root.  Its
permissions should be no more than 600.
--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
