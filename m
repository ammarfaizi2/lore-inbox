Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269119AbRHWSOc>; Thu, 23 Aug 2001 14:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRHWSON>; Thu, 23 Aug 2001 14:14:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2569 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269119AbRHWSOA>; Thu, 23 Aug 2001 14:14:00 -0400
Subject: Re: releasing driver to kernel in source+binary format
To: hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)")
Date: Thu, 23 Aug 2001 19:14:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org'),
        linux-scsi@vger.kernel.org ('linux-scsi@vger.kernel.org')
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880B3E@xsj02.sjs.agilent.com> from "MEHTA,HIREN (A-SanJose,ex1)" at Aug 23, 2001 11:59:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZyzV-0004IJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
