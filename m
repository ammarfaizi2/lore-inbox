Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWFWBp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWFWBp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWFWBp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:45:29 -0400
Received: from wehq.winbond.com.tw ([202.39.229.15]:59042 "EHLO
	wehq.winbond.com.tw") by vger.kernel.org with ESMTP id S932762AbWFWBp2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:45:28 -0400
thread-index: AcaWZnzYk09t4O32SXKtESO0ChdNWQ==
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.326
Content-Class: urn:content-classes:message
Message-ID: <449B4719.7080302@winbond.com>
Date: Fri, 23 Jun 2006 09:42:49 +0800
From: "dezheng shen" <dzshen@winbond.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Pierre Ossman" <drzeus-list@drzeus.cx>,
       "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "PI14 SJIN" <SJin@winbond.com>,
       "PI14 WMWU" <WMWu@Winbond.com.tw>,
       "PI14 DZSHEN" <DZShen@Winbond.com.tw>
Subject: [Winbond] MS/MS Pro driver for Winbond 528 PCI reader for public review
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 23 Jun 2006 01:42:52.0735 (UTC) FILETIME=[579C9CF0:01C69666]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all:
   Eventually, we found a place to place our sources for public review.

   Files are located in

http://zeniv.linux.org.uk/~winbond/

and they have been tested on Intel/AMD single/dual processors and Redhat 
9/Fedora 5 and Redhat workstation 4. We ran a stress test on multiple 
platforms overnight to read/write/format MS/MSPro cards via Winbond 528 
readers.

   Our customers, motherboard manufactures like ASUS, purchase Winbond 
528 then mount their motherboards. Winbond 528 itself provides many 
reader functions like MS/MSPro/SM/xD/SD/MMC and Winbond also vendors 
many other different chips for various buses. For example, Winbond 518 
is for LPC bus and 488 is for embedded hooked up to data bus directly. 
Our team is to derive a simple and unified architecture so that we don't 
have to write redudant codes for each chip, like 518/528/528DA and 488. 
Another example is, wbtable.c and wbtable.h are also used on xD/SM drivers.

   Someone might wonder why we use SCSI subsystem to implement those 
device drivers? When we are assigned this job in 2004, the previous 
engineer has been working on this device driver for over a year and 
he/she was using SCSI subsystem and we don't know why and we simply 
follow her/his trace to deliver this driver to our customers as soon as 
we can. Also, when we plug similar USB flash memory readers, it shows 
sda/sdb so that we took the same approach as SCSI devices.

   Don't hesitate to ask if you have any questions.

best regards,

dz


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
