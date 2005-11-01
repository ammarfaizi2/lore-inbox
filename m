Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVKAIOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVKAIOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVKAIOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:14:10 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:57973 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964960AbVKAIOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:01 -0500
Message-ID: <436723A5.8050709@m1k.net>
Date: Tue, 01 Nov 2005 03:13:25 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 10/37] dvb: dst: ASN.1 length field Fix
Content-Type: multipart/mixed;
 boundary="------------080807080803010705040004"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080807080803010705040004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------080807080803010705040004
Content-Type: text/x-patch;
 name="2373.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2373.patch"

From: Raymond Mantchala <raymond.mantchala@streamvision.ft>

ASN.1 length field Fix

Signed-off-by: Raymond Mantchala <raymond.mantchala@streamvision.ft>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst_ca.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst_ca.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst_ca.c
@@ -328,7 +328,8 @@
 	} else {
 		word_count = length_field & 0x7f;
 		for (count = 0; count < word_count; count++) {
-			length = (length | asn_1_array[count + 1]) << 8;
+			length = length  << 8;
+			length += asn_1_array[count + 1];
 			dprintk(verbose, DST_CA_DEBUG, 1, " Length=[%04x]", length);
 		}
 	}


--------------080807080803010705040004--
