Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSGNPLO>; Sun, 14 Jul 2002 11:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSGNPLN>; Sun, 14 Jul 2002 11:11:13 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:37798 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316887AbSGNPLL>; Sun, 14 Jul 2002 11:11:11 -0400
Date: Sun, 14 Jul 2002 17:12:28 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141512.g6EFCSIZ019177@burner.fokus.gmd.de>
To: alan@lxorguk.ukuu.org.uk, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From alan@lxorguk.ukuu.org.uk Sun Jul 14 16:18:38 2002

>On Sun, 2002-07-14 at 15:07, Joerg Schilling wrote:
>> >From alan@lxorguk.ukuu.org.uk Fri Jul 12 22:22:45 2002

>> >There are lots that fudge around and pretend scsi is the block layer
>> >when it is not. That sort of misses the point and slows down high end
>> >raid cards.
>> 
>> It seems that you miss to understand the needed underlying driver structures.
>> SCSI is not a block layer, it is a generic transport.

>It is not generic - its handling of sophisticated I/O stuff is non

The fact that you don't know st does not make this statement true.

>existant. SCSI gave rise to a convenient command set for low end devices
>thats since been applied (with endless problems due to its use) to
>things like fibrechannel.

The endless problems are problems caused by e.g. a bad transport implementation
in Linux. Your "fibrechannel" words leads to another problem in Linux.
usb_storage is a module that seems to suffer from a correct implementation
if concurrent driver tasks. If usb_storage steps over the 'memory stick'
interface on a Sony VAIO, it hangs itself for 10 minutes and is unable
to recognise any other drive during this time period. If you like to use
a USB CD writer on a VAIO, you need to unplug it and let the OS settle
down after the boot until you are able to reconnect the writer. If you like
to use the USB floppy the same problems ossur. This leads to the fact 
that you cannot boot from a USB floppy: once the kernel is up, it cannot
mount the root disk because the driver is hung from the memory stick adaptor.

>Of course if you'd actually bothered to read the code (as I told you to
>go do a while back) you might understand the 2.5 direction with the
>block I/O layers. Using scsi command sets as a driver abstraction is a
>nonsense, its incomplete, inefficient and too full of messy rules that
>its not reasonable to inflict on hardware that doesn't care (eg recovery
>from tagged command sequences on an error from the drive). 2.5 has a
>much much saner abstraction thank you.

Well, I _did_ read the code a while ago and I did even write a patch for
the sg.c driver that helped to fix a lot of problems. But instead of using
this driver in the official kernel, _you_ preferred a sg.c hack made by a 
OS novice that mainly did address some DMA specifics that should not occur
at all in sg.c in a cleanly layered kernel.

I had a concept on how to go to a more usable interface in the future.

Do you really believe that I will ever start again to put effort in a
Linux kernel module unless you did previously proove that you are willing
and able to run a tecnically based discusion? 


Look at this discussion: you sit on a high horse and behave as if you had 
serious kernel experiences and do not even need to react on my statements
in a senseful way. From looking at your statements it rather looks as if
you are missing the needed experience. You do not really believe that this
is the right way to treat someone with 20 year of kernel experience
on different places of the kernel and on different OS implementations, do you?

If you don't like to look like a 'I know everything but I don't have to proove'
troll, it would help a lot to have a serious discussion where you would start
to use arguments instead of just telling people no more than 'I know better'.

Give yourself a hitch and admit that you are the person who is responsible
that I believe that it is useless to try to help in Linux kernel development.

If this discussion stays as it currently looks like, it does not make sense
for me to try to find a better solution. Let me call it this way: this thread
was just another proof that it is not possible to have a technical based 
solution with the Linux folks. It seems t be just a waste of time :-(

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
