Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132859AbRALVOk>; Fri, 12 Jan 2001 16:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133088AbRALVOa>; Fri, 12 Jan 2001 16:14:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:273 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132859AbRALVOM>;
	Fri, 12 Jan 2001 16:14:12 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101122111.f0CLBhL10716@flint.arm.linux.org.uk>
Subject: Re: Subtle MM bug
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 12 Jan 2001 21:11:43 +0000 (GMT)
Cc: ralf@conectiva.com.br (Ralf Baechle), riel@nl.linux.org,
        andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
In-Reply-To: <m17l40hhtd.fsf@frodo.biederman.org> from "Eric W. Biederman" at Jan 12, 2001 09:10:54 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:
> Hmm.  I would think that increasing the logical page size in the kernel
> would be the trivial way to handle virtual aliases.  (i.e.) with a large
> enough page size you can't actually have a virtual alias.

There are types of caches out there that no matter how large the page size,
you will always have alias issues.  These are ones where the cache lines
are indexed independent of virtual address (and therefore can have funny
cache line replacement algorithms).

And yes, you guessed which processor has it. ;)

(Sorry the CC list got trimmed, elm ate some of it.  I'm sure most of the
people who where on it were on lkml anyway)
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
