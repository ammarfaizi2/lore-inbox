Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131993AbRAKWvr>; Thu, 11 Jan 2001 17:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131833AbRAKWvh>; Thu, 11 Jan 2001 17:51:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60426 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130330AbRAKWvW>;
	Thu, 11 Jan 2001 17:51:22 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101112009.UAA00826@raistlin.arm.linux.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 11 Jan 2001 20:09:38 +0000 (GMT)
Cc: trond.myklebust@fys.uio.no (Trond Myklebust),
        manfred@colorfullife.com (Manfred Spraul),
        mantel@suse.de (Hubert Mantel),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010111194354.F3560@athlon.random> from "Andrea Arcangeli" at Jan 11, 2001 07:43:54 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
> This patch looks fine w.r.t. alignment but given the below seems called
> at runtime (not just at mount time) for performance and to save a dozen of bytes
> of kernel stack it would probably better to use the nfs_fh structure in
> 2.2.19pre7 for the in-kernel representation and to define a new structure for
> userspace message passing (defined as the nfs_fh in 2.2.19pre6). But at least
> now we see _why_ it broke ;)

Ok, this ties up 100% with my suggestion number (1), so I'm happy. ;)
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
