Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbSKBPTS>; Sat, 2 Nov 2002 10:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbSKBPTS>; Sat, 2 Nov 2002 10:19:18 -0500
Received: from f11.sea2.hotmail.com ([207.68.165.11]:18963 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261277AbSKBPTN>;
	Sat, 2 Nov 2002 10:19:13 -0500
X-Originating-IP: [193.153.107.137]
From: "Pedro A ARANDA" <paaguti@hotmail.com>
To: Riley@Williams.Name
Cc: Linux-Kernel@vger.kernel.org
Subject: Patch: allow booting from 21 sectors/track (1722K) floppies
Date: Sat, 02 Nov 2002 15:25:38 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F11clDyGz2stY3Uyn3p00000ebd@hotmail.com>
X-OriginalArrivalTime: 02 Nov 2002 15:25:38.0624 (UTC) FILETIME=[18FBBC00:01C28284]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this simple patch will allow booting from 21 sectors/track floppies.
With all things growing at the pace they are, making bootdisks,
rescue disks, and small distributions is getting a lot harder. With
this small patch, I've been able to boot from floppies formatted at
82 tracks, 21 sectors/track, which gives 1722K space. These nearly
300K really make a difference.

The patch was tested and generated against a 2.4.19 kernel.

Cheers,
Pedro A. Aranda Gutiérrez
paaguti@hotmail.com

--------------------------------------

--- arch/i386/boot/bootsect.S.orig     2002-11-02 16:10:06.000000000 +0100
+++ arch/i386/boot/bootsect.S  2002-11-02 16:10:06.000000000 +0100
@@ -407,7 +407,11 @@
        ret

sectors:       .word 0
-disksizes:     .byte 36, 18, 15, 9
+#
+# paaguti@hotmail.com: try 21 sectors too for fd01722 et.al.
+#   02-Nov-2002
+#
+disksizes:     .byte 36, 21, 18, 15, 9
msg1:          .byte 13, 10
                .ascii "Loading"






_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

