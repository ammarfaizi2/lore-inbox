Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135310AbRDRUWq>; Wed, 18 Apr 2001 16:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135314AbRDRUWh>; Wed, 18 Apr 2001 16:22:37 -0400
Received: from [62.81.160.68] ([62.81.160.68]:18076 "EHLO smtp2.alehop.com")
	by vger.kernel.org with ESMTP id <S135306AbRDRUW1>;
	Wed, 18 Apr 2001 16:22:27 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Manuel Ignacio Monge Garcia <ignaciomonge@navegalia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ATA 100 & VIA and linux-2.4.3ac8
Date: Wed, 18 Apr 2001 22:21:53 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <01041820505300.01783@localhost.localdomain> <3ADDE820.2050103@texoma.net>
In-Reply-To: <3ADDE820.2050103@texoma.net>
MIME-Version: 1.0
Message-Id: <01041822215300.01341@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mié 18 Abr 2001 15:16, escribiste:
> I don't know about other possible problems with the kernel, but you must
> use an 80 wire IDE cable for UDMA66/100 to work.
>
> > -----------------------Primary IDE-------Secondary IDE------
> > Cable Type:                   40w                 40w


        Strange thing. With previous version of kernel (2.4.1 I think), I 
haven't  got this problem. May be a bios detection problem?

Extract from /usr/src/linux/drivers/ide/via82cxxx..c:

*
*   PIO 0-5, MWDMA 0-2, SWDMA 0-2 and UDMA 0-5
*
* (this includes UDMA33, 66 and 100) modes. UDMA66 and higher modes are
* autoenabled only in case the BIOS has detected a 80 wire cable. To ignore
* the BIOS data and assume the cable is present, use 'ide0=ata66' or
* 'ide1=ata66' on the kernel command line.
*

I've tried with ide0=ata100, but this options doesn't work.
