Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVC2Hdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVC2Hdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVC2H3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:29:23 -0500
Received: from smartmx-04.inode.at ([213.229.60.36]:29860 "EHLO
	smartmx-04.inode.at") by vger.kernel.org with ESMTP id S262547AbVC2HUa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:20:30 -0500
Subject: Re: INITRAMFS: junk in compressed archive
From: Bernhard Schauer <linux-kernel-list@acousta.at>
Reply-To: schauer@acousta.at
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <d24rad$378$1@terminus.zytor.com>
References: <1111679972.5628.10.camel@FC3-bernhard-1.acousta.local>
	 <1111762170.7238.3.camel@FC3-bernhard-1.acousta.local>
	 <d24rad$378$1@terminus.zytor.com>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 08:20:51 +0200
Message-Id: <1112077252.6427.21.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel + compressed initramfs + uncompressed initramfs must fit in memory at
> the same time.

But that could not be the problem:
 
          initramfs   packed:  6,4 MByte
                    unpacked: 14,7 MByte
          kernel    unpacked:  2,2 MByte
         --------------------------------
                              23,3 MByte

128 MByte RAM on the PC (?) - the kernel tells that the RAM is
available.

An other interesting thing is that the "checking if image is
initramfs... it isn't (junk in compressed archive)" message disappeared
after using smaller initramfs (using the same method to compress
the .cpio.gz file!). 


Maybe my boot procedure is a problem(?):
I've to remote-boot DOS via RPL, load Novell Client for DOS, copy Linux
+ initramfs to ramdisk and call loadlin (version 1.6c) to start Linux.

Could there something remain in memory? The size of memory available to
the PC should still be enough to hold both systems and also the DOS -
Ramdisk in memory. 


Other Question: is (could) DOS-Ramdisk (be) available to Kernel? Maybe
as MTD?

regards

Bernhard Schauer

