Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRCFUd1>; Tue, 6 Mar 2001 15:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129072AbRCFUdI>; Tue, 6 Mar 2001 15:33:08 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:47910 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S129797AbRCFUcf>; Tue, 6 Mar 2001 15:32:35 -0500
From: Paul Bristow <paul@paulbristow.net>
Reply-To: paul@paulbristow.net
To: Konrad Stopsack <konrad@stopsack.de>
Subject: Re: IDE bug in 2.4.2-ac12?
Date: Tue, 6 Mar 2001 21:32:46 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01030620134000.00343@Stopsack>
In-Reply-To: <01030620134000.00343@Stopsack>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01030621324600.01403@zoltar.paulbristow.lan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 March 2001 19:13, Konrad Stopsack wrote:
> Hello guys,
>
> I hope you've read my posting "DMA problem with ZIP drive and VIA
> VT82C598MVP / VT82C586B chip" (why does anybody answer?).
> I now tried the 2.4.2-ac12 kernel including the latest VIA 82c586b driver
> (version 3.21), but the effects were almost the same:
> - just when the kernel tried to access to the hard disk during boot, DMA
> errors were occured
> - "hdparm /dev/hda" displayed 9 MB per second (and not 11 MB like without
> ZIP) - /proc/ide/via reported 16 MB transfer rate (and not 33MB like
> without ZIP drive)
> - Kernel 2.4.2-ac12 reports a "ide-floppy: hdd: I/O error, pc = 5a, key = 
> 5, asc = 24, ascq =  0" error, 2.4.2 doesn't
>
> My IDE configuration is:
> /dev/hda: Hard disk  => Primary IDE controller
> /dev/hdc CD-ROM  => Secondary IDE controller
> /dev/hdd: ZIP           => Secondary IDE controller
>
> Could you please tell me whether it's a bug or a feature?

OK.  The ZIP drive can not handle uDMA, so it's normal for the secondary 
controller to drop back.  In my opinion, the primary controller should stay 
at uDMA speed, but it is PC hardware so it is perfectly possible there is 
something cheap that locks them together.  I will bring up ac-12 and check 
the error message...

> I'm really waiting for your answer - else I might get crazy with this
> problem
>
> :-((
>
> I attached both dmesg and /proc/ide/via, and my old posting.
>
> cu Konrad

-- 
Paul Bristow
http://paulbristow.net/linux/idefloppy.html
Linux ide-floppy maintainer
