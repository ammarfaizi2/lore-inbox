Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUHIPGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUHIPGo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUHIPDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:03:33 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:61390 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266715AbUHIOjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:39:13 -0400
Date: Mon, 9 Aug 2004 16:38:29 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091438.i79EcT4t010630@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jens Axboe <axboe@suse.de>
>> If you were true and Linux would include _and_ use DMA abstraction, then
>> we would have DMA with ide-scsi for all CD sector sizes.

>Just because we have an api for helping drivers map data for dma,
>doesn't necessarily mean that they all use it. In 2.6.8 ide-scsi will

This is the first time that you mention it and you could have avoided a lot
of mail if you did do eralier.

>use dma for all transfers. As I've already stated, I wont be fixing 2.4.
>I've also included reasons for this. You seem to think that a 'DMA
>abstraction layer' means there will be no hardware bugs, I only wish
>that was so.

DMA abstraction does not fix HW bugs, it only allows you to behave the same for 
all "DMA users" for the same HW in the kernel.

>> interfaces by using a device special file instead of including the
>> same include file in the kernel code as well as in the applicatin
>> code?

>We were talking about device addressing, right? Or are you ramblinb on
>about API stability again?

This subsection did start about the Linux include file bugs.

If you like to allow kernel interfaces to evolve, then you need to make sure
that applications are able to use them. The only known way to do this correctly 
is to make both the kernel and the application to include the same definitions.

GLIBC is completely uinrelated to ioctl interfaces and it is published in 
completely unrelated time frames..... Trying to tell users to use include files
from GLIBC for SCSI Generic is just silly.

>> YOu have only shown that you in many caes try to ignoore the truth ;-(

>I'm surprised an ego of your size can even be contained inside a
>normally sized (I'm assuming, having never met you) human body. I guess
>in your opinion, anything oozing from your brain is by definition the
>truth? That's the only way that I can see your above sentence making
>sense to you.

OK, as you just verified again that you are a frequent source of insulting
people we should close this thread.

Let us start after you managed to regret and to learn to separate a technical
discussion from personal unsulting.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
