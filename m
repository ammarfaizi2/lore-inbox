Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbSJ0LCG>; Sun, 27 Oct 2002 06:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbSJ0LCG>; Sun, 27 Oct 2002 06:02:06 -0500
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:11773 "EHLO
	shunka.yo.cz") by vger.kernel.org with ESMTP id <S262357AbSJ0LCF>;
	Sun, 27 Oct 2002 06:02:05 -0500
Message-ID: <002501c27da9$2524d0f0$4500a8c0@cybernet.cz>
From: "=?iso-8859-2?B?VmxhZGlt7XIgVPhlYmlja/0=?=" <guru@cimice.yo.cz>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Swap doesn't work
Date: Sun, 27 Oct 2002 12:07:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You change hostname inbetween or this is just a typo?

yes, I did ;-)

> Wow. Any of the errors above prevents swap partition from being used.
> How did you manage to see anything in /proc/swaps?
> I suggest you do:
>  swapoff /dev/hda6
>  badblocks /dev/hda6

Badblocks finds each time ONE bad block at the end of the partition no
matter where I create it or how large the partition is. Syslog shows this
message:
Oct 27 10:57:45 shunka kernel: attempt to access beyond end of device
Oct 27 10:57:45 shunka kernel: 03:06: rw=0, want=594376, limit=594373
Oct 27 10:57:45 shunka kernel: attempt to access beyond end of device
Oct 27 10:57:45 shunka kernel: 03:06: rw=0, want=594376, limit=594373

> Alternatively, you can try
>
> dd if=/dev/zero of=/dev/hda6; mkswap /dev/hda6
>

the same occurs when I try to
dd if=/dev/zero of=/dev/hda6 bs=1024 count=594373
dd: writing `/dev/hda6': Input/output error
594373+0 records in
594372+0 records out
---
Oct 27 11:40:40 shunka kernel: attempt to access beyond end of device
Oct 27 11:40:40 shunka kernel: 03:06: rw=0, want=594376, limit=594373

I've tried many times to repartition the whole disk...

> Look for "SWAP-SPACE" (old swap) or "SWAPSPACE2" (the new one).
> Just to make sure you've initialized the partition properly.
> Than turn it on: swapon /dev/hda6; tail /var/log/syslog

where should I try to find it? ("SWAP-SPACE" | "SWAPSPACE2")

> Oops, you've sent, is pretty useless without decoding. Read
> Documentation/oops-tracing.txt from the kernel source tree.

I have some problem with ksymoops - some unresolved symbols. I read about it
and problems with binutils and their libraries. I hope, I'll solve this
quick.

What means the problems I (only) once noticed about the signature?

Thanks,

Vladimir Trebicky

--
Vladimir Trebicky
guru@cimice.yo.cz

