Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSILPDg>; Thu, 12 Sep 2002 11:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSILPDg>; Thu, 12 Sep 2002 11:03:36 -0400
Received: from [212.18.235.100] ([212.18.235.100]:21665 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S316289AbSILPDf>; Thu, 12 Sep 2002 11:03:35 -0400
From: kernel@street-vision.com
Message-Id: <200209121507.g8CF7cY07728@tench.street-vision.com>
Subject: Re: AMD 760MPX DMA lockup
To: kas@informatics.muni.cz (Jan Kasprzak)
Date: Thu, 12 Sep 2002 15:07:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020912161258.A9056@fi.muni.cz> from "Jan Kasprzak" at Sep 12, 2002 04:12:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 	Hello, kernel hackers,
> 
> my dual athlon box is unstable in some situations. I can consistently
> lock it up by running the following code:
> 
> fd = open("/dev/hda3", O_RDWR);
> for (i=0; i<1024*1024; i++) {
> 	read(fd, buffer, 8192);
> 	lseek(fd, -8192, SEEK_CUR);
> 	write(fd, buffer, 8192);
> }
> 
> It locks up in a minute or so (solid lock up, it does not react even
> to a NumLock key or console switching). It can surely be a HW problem
> (this is a new box), but how to tell whether this is the case?
> 
> The mainboard is MSI K7D Master, AMD 760MPX chipset, 460W power supply,
> 1GB RAM.
> 
> The box survived whole night of memtest86 and the whole night of three kernel
> compiles running in parallel in an infinite loop.
> 
> This problem is on many recent kernels (tried 2.4.18-11 from RedHat "null",
> 2.4.20-pre5-ac1, 2.4.20-pre5-ac5, 2.4.20-pre6). It does not matter whether
> I compile the kernel SMP or UP, with or without CONFIG_HIGHMEM.

Well I have run this several times on my MPX, and it is fine.

This is 2.4.20-pre1, dual AMD 2000MP, only difference is it is the Tyan
version of the MPX, not the MSI. 

Justin
