Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSF0M5N>; Thu, 27 Jun 2002 08:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSF0M5N>; Thu, 27 Jun 2002 08:57:13 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:21467 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S316836AbSF0M5M>; Thu, 27 Jun 2002 08:57:12 -0400
Message-ID: <3D1B0B95.51E13621@cisco.com>
Date: Thu, 27 Jun 2002 18:26:53 +0530
From: Manik Raina <manik@cisco.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: enums 
Content-Type: multipart/mixed;
 boundary="------------5664C73FD169A03B66EFB9AC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5664C73FD169A03B66EFB9AC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

is there a particular reason we dislike constructs as attached in the
diffs below ?
with enums, we dont have to increment MAX_NR_ZONES everytime a new one
is added .

--------------5664C73FD169A03B66EFB9AC
Content-Type: text/plain; charset=us-ascii;
 name="a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a"

diff -u -r -U 6 cmp/include/linux/mmzone.h linux-2.5.24/include/linux/mmzone.h
--- cmp/include/linux/mmzone.h	Fri Jun 21 04:23:42 2002
+++ linux-2.5.24/include/linux/mmzone.h	Thu Jun 27 18:00:25 2002
@@ -88,16 +88,21 @@
 	 * rarely used fields:
 	 */
 	char			*name;
 	unsigned long		size;
 } zone_t;
 
-#define ZONE_DMA		0
-#define ZONE_NORMAL		1
-#define ZONE_HIGHMEM		2
-#define MAX_NR_ZONES		3
+enum zone_type {
+
+     ZONE_DMA,
+     ZONE_NORMAL,
+     ZONE_HIGHMEM,		
+     MAX_NR_ZONES,	
+
+};
+
 
 /*
  * One allocation request operates on a zonelist. A zonelist
  * is a list of zones, the first one is the 'goal' of the
  * allocation, the other zones are fallback zones, in decreasing
  * priority.

--------------5664C73FD169A03B66EFB9AC--

