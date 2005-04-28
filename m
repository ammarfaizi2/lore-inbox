Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVD1LnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVD1LnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVD1LnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:43:19 -0400
Received: from pcsmail.patni.com ([203.124.139.197]:52896 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP id S262063AbVD1LnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:43:11 -0400
Message-ID: <002001c54be7$0661abc0$5e91a8c0@patni.com>
Reply-To: "lk" <linux_kernel@patni.com>
From: "lk" <linux_kernel@patni.com>
To: "Iwan Sanders" <iwan.sanders@tuxproject.info>,
       <linux-kernel@vger.kernel.org>
References: <4270A7F3.3020707@tuxproject.info>
Subject: Re: File and partition sizes
Date: Thu, 28 Apr 2005 04:40:06 -0700
Organization: Patni
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the table which shows the size limits depending upon the files system...

___________________________________________________________
File System     File Size [Byte]   File System Size [Byte]
____________________________________________________________
Ext2 or Ext3 (1 kB block size)   2^34 (16 GB)   2^41 (2 TB)
Ext2 or Ext3 (2 kB block size)   2^38 (256 GB)   2^43 (8 TB)
Ext2 or Ext3 (4 kB block size)   2^41 (2 TB)   2^44 (16 TB)
Ext2 or Ext3 (8 kB block size)   2^46 (64 TB)   2^45 (32 TB)
ReiserFS 3.5     2^32 (4 GB)   2^44 (16 TB)
ReiserFS 3.6 (under Linux 2.4)    2^60 (1 EB)   2^44 (16 TB)
XFS      2^63 (8 EB)   2^63 (8 EB)
JFS (512 Bytes block size)   2^63 (8 EB)   2^49 (512 TB)
JFS (4 kB block size)    2^63 (8 EB)   2^52 (4 PB)
NFSv2 (client side)    2^31 (2 GB)   2^63 (8 EB)
NFSv3 (client side)    2^63 (8 EB)   2^63 (8 EB)
____________________________________________________________

apart from this the following kernel limits exist:

On 32-bit systems with Kernel 2.4.x: The size of a file and a block device
is limited to 2 TiB. By using LVM several block devices can be combined
enabling the handling of larger file systems.

64-bit systems: The sizes of a filesytem and of a file are limited by 2^63
(8 EiB). But there might be hardware driver limits that do not allow to
access such large devices.

Kernel 2.6: For both 32-bit systems with option CONFIG_LBD set and for
64-bit systems: The size of a file system is limited to 2^73 (far too much
for today). On 32-bit systems (without CONFIG_LBD set) the size of a file is
limited to 2 TiB. Note that not all filesystems and hardware drivers might
handle such large filesystems.



regards

lk

----- Original Message ----- 
From: "Iwan Sanders" <iwan.sanders@tuxproject.info>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, April 28, 2005 2:08 AM
Subject: File and partition sizes


> Hi,
>
> I am examining the large file support in Linux. A couple of questions
> remained unanswered that's why I thought to
> ask the experts ;-)
>
> I was wondering what the current size limitation of a partition is and
> what kernel versions will allow files larger then
> 4 GB and why they do that.
>
> Regards,
>
> Iwan Sanders
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


