Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272126AbRHVVOm>; Wed, 22 Aug 2001 17:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272123AbRHVVOd>; Wed, 22 Aug 2001 17:14:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272121AbRHVVOY>; Wed, 22 Aug 2001 17:14:24 -0400
Subject: Re: Oops after mounting ext3 on 2.4.8-ac9
To: clubneon@hereintown.net (Chris Meadors)
Date: Wed, 22 Aug 2001 22:16:36 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.31.0108221537100.3959-100000@rc.priv.hereintown.net> from "Chris Meadors" at Aug 22, 2001 03:40:24 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZfMa-0002Il-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > USB problem.  Looks like dev->bus has a wild value in new_dev_inode().
> > >From a quick scan I don't see any changes in ac8->ac9 which could cause
> > this.  Please, work back through kernel versions until it goes away and
> > let us know.
> 
> Sure enough, I mount /proc and /proc/bus/usb after the last disc
> partition.
> 
> Yep, the oops persisted in 2.4.8-ac8, but went away as I went back to
> -ac7.

ac8 has further superblock updates, I wonder if those are what ticklets it.

Can you try 2.4.8ac7 with the 2.4.8ac8 drivers/usb and include/linux/usb* 
changes ?

If Im right it wont oops
