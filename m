Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVCQJU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVCQJU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVCQJUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:20:25 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:42630 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S263021AbVCQJTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:19:47 -0500
Date: Thu, 17 Mar 2005 14:42:45 +0530
From: mohanlal jangir <mohanlal@samsung.com>
Subject: why CURRENT->sector is zero??
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Newbies <kernelnewbies@nl.linux.org>
Cc: rubini@gnu.org, rubini@fsfeurope.org, rubini@prosa.it, rubini@gnudd.com,
       rubini@linux.it
Message-id: <01ae01c52ad1$83e79190$3d476c6b@sisodomain.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I downloaded sbull.c (for LDD 2nd Edition) from 
http://examples.oreilly.com/linuxdrive/. After compiling and inserting 
(registering as block device), I tried to mount different file systems 
(Although there is no valid file system there; my goal is to observe value 
of req->sector in sbull_transfer function). The observations are as follows:
File System  req->sector
msdos          0
vfat              0
ext2             2
ext3             2
iso9000       72

I don't know about other file systems, but I believe the value of 
req->sector for msdos/vfat is wrong. Because when I mount a CF card having 
FAT file system on my Linux box (using USB mass storage driver), the first 
read request contains sector 0x20.
Does someone have any clue, why sbull gets this value as 0 rather then 0x20? 
Basically this means why CURRENT->sector is 0?
I am working on 2.4.18; a little old :(

Regards
Mohanlal 

