Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVAPA2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVAPA2F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 19:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVAPA2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 19:28:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:53896 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbVAPA16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 19:27:58 -0500
Message-ID: <41E9B353.6000805@osdl.org>
Date: Sat, 15 Jan 2005 16:20:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Henrik.Seidel@gmx.de
Subject: [PATCH] radio-typhoon: use correct module_param data type
Content-Type: multipart/mixed;
 boundary="------------060802020802060105080105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060802020802060105080105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Use correct data type for module_param:
drivers/media/radio/radio-typhoon.c:317: warning: return from 
incompatible pointer type

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  drivers/media/radio/radio-typhoon.c |    2 +-
  1 files changed, 1 insertion(+), 1 deletion(-)
---



--------------060802020802060105080105
Content-Type: text/x-patch;
 name="radio_typhoon_modprm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radio_typhoon_modprm.patch"


diff -Naurp ./drivers/media/radio/radio-typhoon.c~rad_typh_modprm ./drivers/media/radio/radio-typhoon.c
--- ./drivers/media/radio/radio-typhoon.c~rad_typh_modprm	2005-01-10 13:28:51.000000000 -0800
+++ ./drivers/media/radio/radio-typhoon.c	2005-01-15 15:52:36.135580880 -0800
@@ -314,7 +314,7 @@ module_param(radio_nr, int, 0);
 
 #ifdef MODULE
 static unsigned long mutefreq = 0;
-module_param(mutefreq, int, 0);
+module_param(mutefreq, ulong, 0);
 MODULE_PARM_DESC(mutefreq, "Frequency used when muting the card (in kHz)");
 #endif
 

--------------060802020802060105080105--
