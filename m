Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVAASlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVAASlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 13:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVAASlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 13:41:10 -0500
Received: from rekin12.go2.pl ([193.17.41.32]:3023 "EHLO rekin12.go2.pl")
	by vger.kernel.org with ESMTP id S261161AbVAASlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 13:41:06 -0500
From: =?iso-8859-2?Q?Fryderyk_Mazurek?= <dedyk@go2.pl>
To: =?iso-8859-2?Q?Bill_Davidsen?= <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, gustavo@compunauta.com
Subject: =?iso-8859-2?Q?Re:_Problems_with_2.6.10?=
Date: Sat,  1 Jan 2005 19:41:04 +0100
Content-Type: text/plain; charset="iso-8859-2";
Content-Transfer-Encoding: 8bit
X-Mailer: o2.pl WebMail v5.27
X-Originator: 83.31.152.34
In-Reply-To: <41D5FB14.8090704@tmr.com>
References: <41D3646A.9020806@tmr.com><20041228145600.6A9FC193D36@r10.go2.pl> <20041230164546.987845674D@rekin12.go2.pl> 
	<41D5FB14.8090704@tmr.com>
Message-Id: <20050101184104.D672F56721@rekin12.go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

At last I fixed my problem! I changed source to not enable "Host
Protected Area". This means that on 2.6.10 I have 33,8GB disk, not
40GB, how on "true" 2.6.10. And now my BIOS detect my disk. But
question is, what does "true" kernel do, and why influence to BIOS?
Maybe this is kernel BUG?
Here is my diff's file. Maybe my patch is primitive, but it works.
Maybe somebody will do better patch.

My patch:
--- ./ide-disk-copy.c	2004-12-24 22:34:32.000000000 +0100
+++ ./ide-disk.c	2005-01-01 18:07:33.000000000 +0100
@@ -642,7 +642,9 @@
 			 drive->name,
 			 capacity, sectors_to_MB(capacity),
 			 set_max, sectors_to_MB(set_max));
-
+	
+	return;
+	
 	if (lba48)
 		set_max = idedisk_set_max_address_ext(drive, set_max);
 	else


I want to thank all who helped me and I wish a Happy New Year!

Fryderyk.


