Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311119AbSCMTqL>; Wed, 13 Mar 2002 14:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311128AbSCMTqD>; Wed, 13 Mar 2002 14:46:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11782 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311119AbSCMTpn>; Wed, 13 Mar 2002 14:45:43 -0500
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet w
To: Deanna_Bonds@adaptec.com (Bonds, Deanna)
Date: Wed, 13 Mar 2002 20:00:43 +0000 (GMT)
Cc: adam@yggdrasil.com ('Adam J. Richter'), linux-kernel@vger.kernel.org
In-Reply-To: <F8D30FF32B23D61198B9009027D61DB32FC217@otcexc01.otc.adaptec.com> from "Bonds, Deanna" at Mar 13, 2002 02:23:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lEvT-0007I8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This code is very similar to the i2o subsystem, yet it is not the same.
> When I get free of my current project I will work on updating this module
> (unless someone beats me to it).

I'm doing the main i2o code. The main i2o code has lots of problems on non
32bit little endian systems and won't work on 2.5 without a major rework. I'm
doing that work in 2.4 since with 2.4 I at least know that when it dies it
was probably my fault. Until 2.4 is sorted please don't bother with the i2o/*
directory.

The dpt is seperate because it speaks a slightly odd dialect of i2o and the
native driver works nicely. The same is also true for the i2o code hiding
in the Red Creek vpn driver. 

Alan
