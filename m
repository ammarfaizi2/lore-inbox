Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSFJM2t>; Mon, 10 Jun 2002 08:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSFJM2s>; Mon, 10 Jun 2002 08:28:48 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:46363 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312973AbSFJM2p>; Mon, 10 Jun 2002 08:28:45 -0400
Message-Id: <5.1.0.14.2.20020610133039.00ae8440@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 10 Jun 2002 13:32:24 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 "I can't get no compilation"
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D048B4C.7080107@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:19 10/06/02, Martin Dalecki wrote:
>The subject says it all...
>
>Contrary to other proposed patches I realized that there is
>no such thing as vmalloc_dma.

Perhaps you ought to look in mm/vmalloc.c which contains:

void * vmalloc_dma (unsigned long size)
{
         return __vmalloc(size, GFP_KERNEL|GFP_DMA, PAGE_KERNEL);
}

Or are you going to tell me that is a figment of my imagination?

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

