Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131077AbRCGNud>; Wed, 7 Mar 2001 08:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131078AbRCGNuY>; Wed, 7 Mar 2001 08:50:24 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:64477 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131077AbRCGNuM>; Wed, 7 Mar 2001 08:50:12 -0500
Message-Id: <5.0.2.1.2.20010307130210.00a25180@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 07 Mar 2001 13:49:17 +0000
To: Ben Greear <greearb@candelatech.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What
  happened ? (No
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3AA5B0F3.143E0528@candelatech.com>
In-Reply-To: <E14aGFU-0000YQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:54 07/03/01, Ben Greear wrote:
>Alan Cox wrote:
> > Its not a bug. As the system administrator you reconfigured a hard disk on
> > the fly and shit happened. The hdparm man page warnings do exist for a 
> reason.
>
>I'm not arguing it was a smart thing to do, but I would think that the
>fs/kernel/driver writers could keep really nasty and un-expected things
>from happenning.  For instance, the driver could dis-allow any new 
>(non-hdparm) writes while hdparm is doing it's test.  Or maybe the driver 
>could realize it was being told to do something that would break and just 
>not do it?

No. This would be against Linux/Unix philosphy of giving you enough rope. 
Maybe I want to break my hd? You never know. Or maybe the same commands 
work perfectly well on a different hd/controller? In general, if you don't 
understand the consequences of something you want to do, then *don't* do 
it! Or at least have a backup handy and don't complain afterwards...

>Considering this disk is my root disk, is there *any* safe way to test
>out hdparm on this disk?

Of course. Boot/change into single user mode, sync, and remount any 
readwrite mounted fs readonly. Then it should be safe to check things out 
with hdparm, at least I have done it this way for ages and never run into a 
problem even though in my early stage of hdparm experimentation I would 
cause kernel crashes more often then not... Chances are that if readonly 
works fine, so will write, so once I find the fastest settings that still 
give 100% reliability on reads I switch back to normal network multi user 
mode and try read-write. Never failed me so far but YMMV, so keep a backup...

Best regards,

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

