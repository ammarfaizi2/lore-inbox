Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRCBV2e>; Fri, 2 Mar 2001 16:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbRCBV2Y>; Fri, 2 Mar 2001 16:28:24 -0500
Received: from zeus.kernel.org ([209.10.41.242]:57288 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129511AbRCBV2O>;
	Fri, 2 Mar 2001 16:28:14 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103022105.f22L5FY16844@webber.adilger.net>
Subject: Re: apparent file corruption on 2.4.2
In-Reply-To: <3AA001DC.C11B688D@staffnet.com> from Wade Hampton at "Mar 2, 2001
 03:26:04 pm"
To: Wade Hampton <whampton@staffnet.com>
Date: Fri, 2 Mar 2001 14:05:15 -0700 (MST)
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wade Hampton writes:
> I can't move, delete, or do anything with these files.  I tried 
> chattr, touch, etc. and the only thing I can do is change the 
> access date with touch.
> 
> b--sr-s--t    1 1769209956 1852796526 116, 101 May 29  2023
>               /binold/hostname
> 
> prwxr-x--T    1 2232483836 2312881283        0 Mar  1 22:41 
>               /dev/dsp
> 
> Does anyone have any ideas.  I can live with one messed up file 
> in /binold, but I can't live with a messed up /dev/dsp.  I 
> really don't want the Microsoft solution (reload)....

You could always rename /dev to /devold, copy the rest of your
device files back, and run "mknod /dev/dsp c 14 3" to recreate
/dev/dsp.

You probably need to boot using a rescue floppy (tomsrtbt if
needed), and run debugfs to delete them.  It is strange
that you can't even delete these files.  Sometimes there is a
problem with files > 2GB in size, but there should be no
problems with block special or pipes.  What sort of errors do
you get, and is there anything in syslog?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
