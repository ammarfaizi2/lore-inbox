Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271658AbRIGJop>; Fri, 7 Sep 2001 05:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271660AbRIGJof>; Fri, 7 Sep 2001 05:44:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36101 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271658AbRIGJoW>; Fri, 7 Sep 2001 05:44:22 -0400
Subject: Re: replaying reiserfs journal and bad blocks (was: Re[3]: Basic
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 7 Sep 2001 10:48:15 +0100 (BST)
Cc: nerijus@users.sourceforge.net (Nerijus Baliunas),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3B987D2A.41C975B3@namesys.com> from "Hans Reiser" at Sep 07, 2001 11:54:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fIFE-0001JF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hdd: dma_intr: error=0x40 { UncorrectableError }, LBAsect=84415, sector=36216

Thats the drive deciding it cant read the block. 

> My guess is turn off UDMA, I think we have a www.namesys.com/faq.html entry on
> that which you can read and see if my memory of the typical symptoms of flaky
> udma are correct.  Commenting on the cause of flaky udma I will leave to others
> familiar with your mob's interaction with Linux, except to say that one should> always check cables at a time like this.

You'd expect CRC errors then. It looks like the 2.2 log replay code worked
but the 2.4 log replay code failed on the error, or the layers below it in
the IDE got stuck.
