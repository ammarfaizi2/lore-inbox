Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSEUS3a>; Tue, 21 May 2002 14:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSEUS33>; Tue, 21 May 2002 14:29:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56326 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315415AbSEUS30>; Tue, 21 May 2002 14:29:26 -0400
Subject: Re: [PATCH] 2.5.17 IDE 65
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 21 May 2002 19:49:30 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.44.0205211041460.2634-100000@home.transmeta.com> from "Linus Torvalds" at May 21, 2002 10:56:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AEhO-0008Nr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Absolutely not. Even if Maxtor were to do a 2kB-sector disk, that only
> means that the md layer would have to make a 2kB-sector md device.
> 
> We have the support for all of this already, as many (most?) SCSI CD-ROM's
> are 2kB-only.

We also support M/O disks. Ext2 fs with a block size >= the block size of
the media works well. 512byte FATfs needs loop. I've been using 2K media
on and off for a long time. Our design limit is page size.

It all works fine in 2.2 and 2.4
