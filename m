Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132223AbRAaQw7>; Wed, 31 Jan 2001 11:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbRAaQws>; Wed, 31 Jan 2001 11:52:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47880 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132223AbRAaQwl>; Wed, 31 Jan 2001 11:52:41 -0500
Subject: Re: Oops accessing file on 2048 bytes/sector vfat MO in 2.4.0
To: sm@voyager.ping.de (Stefan Meyknecht)
Date: Wed, 31 Jan 2001 16:53:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010126214058.A400@voyager.ping.de> from "Stefan Meyknecht" at Jan 26, 2001 09:40:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O0W0-0002fz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I receive a Kernel oops while copying a file from MO-drive (vfat) with
> 2048 bytes sector size. There is no problen with ext2 formatted MOs.
> 
> I think it happens because the function pointer cfv_file_read of the
> struct cvf_format is initialized with null.
> 
> This oops is 100% reproducable with the kernels: 2.4.0, 2.4.1-pre3,
> 2.4.1-pre7 and 2.4.0-ac11 (probably all >= 2.4.0).

Yep. You'll also see crashes and other problems if you mix 2K and 512 byte
formatted M/O disks in the drive.

Right now its a bad idea to use M/O devices with 2.4 kernels
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
