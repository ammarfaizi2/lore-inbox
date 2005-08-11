Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVHKF1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVHKF1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVHKF1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:27:06 -0400
Received: from [202.125.86.130] ([202.125.86.130]:39627 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S1751008AbVHKF1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:27:04 -0400
Content-class: urn:content-classes:message
Subject: The Linux FAT issue on SD Cards.. maintainer support please
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Thu, 11 Aug 2005 10:57:14 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <C349E772C72290419567CFD84C26E01709FFF9@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWeNJT7DNHN9yGNTum/9M2fEZcDLQ==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <hirofumi@mail.parknet.co.jp>
Cc: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am Linux driver programmer. 

I have a FAT12 issue on my SD cards. I have got these addresses from the
fs-lists as the maintainer support mail IDs for FAT-FS.

I am using the 2.6.10 kernel, X86 like systems.

I am NOT able to mount the Camera formatted FAT12 filesystem on my linux
BOX. SD card is of size 16MB. At the same time I am able to mount the SD
cards formatted in windows & linux.

I have identified fat_fill_super() in fs/fat/inode.c file as the
function that reads the super block of as MS-DOS FS.

To debug, I have rebuilt my kernel 2.6.10 inserting some debug messages
in the FS sub-system to know what data is coming into "struct
fat_boot_sector *b" structure in fs/fat/inode.c file after sb_bread()
call.

I believe that this data in the "struct fat_boot_sector *b" should be
FAT12 information.

On the camera formatted SD that is NOT mounting I have found this
structure to be all '0' till total_sectors variable (relevant till here
on - FAT12).

Will you please verify if there & tell me if the problem is in the FAT
sub-system.

Regards,
Mukund Jampala

 

 

 


