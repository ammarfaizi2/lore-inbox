Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269967AbRHWSnP>; Thu, 23 Aug 2001 14:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269963AbRHWSnF>; Thu, 23 Aug 2001 14:43:05 -0400
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:31461 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S269962AbRHWSmv>; Thu, 23 Aug 2001 14:42:51 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880B3F@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: RE: releasing driver to kernel in source+binary format
Date: Thu, 23 Aug 2001 12:43:05 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, Qlogic also has their firmware released in binary format.

Any comment on that ?

-hiren

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Thursday, August 23, 2001 11:14 AM
To: hiren_mehta@agilent.com
Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
Subject: Re: releasing driver to kernel in source+binary format


> HBAs and make it part of the kernel source tree. Because of IP 
> related issues, we can only release one part of the sources with 
> GPL. We want to release the other part in the binary format (.o)
> as a library which needs to be linked with the first part.
> If somebody can advise me on how to go about this, I would
> appreciate it. 

Very simple. You can't link GPL and proprietary code together. You may be
able to make your code a non free module distributed by yourselves if you
can satisfy your lawyers that it is a seperate work. Take that one up with
your lawyers. Also remember that the kernel code is GPL, so if you based
your driver on existing GPL code (eg by copying an existing scsi drivers
code as a basis) you will also have to sort that issue out too.

> I went through the "SubmittingDrivers" file
> which does not talk about this kind of special cases.

Thats becase Linux is free software. We don't merge binary only drivers, and
only maintain source level compatibility between different compiles of the
kernel.

The whole Linux concept is geared around free software, that means source
code, source level compatibility, the ability for people to recompile and
for sane debugging because we have all the sources.

Alan
