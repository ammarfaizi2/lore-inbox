Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUKOT54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUKOT54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUKOT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:56:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:44994 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261674AbUKOTzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:55:03 -0500
Message-ID: <4199069F.2060606@osdl.org>
Date: Mon, 15 Nov 2004 11:42:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philip.Blundell@pobox.com, tim@cyberelk.net, akpm <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] parport: fix __setup function arg.
Content-Type: multipart/mixed;
 boundary="------------020508030608090805020201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508030608090805020201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

fix function args warning:
drivers/parport/parport_pc.c:3317: warning: initialization from
incompatible pointer type

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
   drivers/parport/parport_pc.c |    2 +-
   1 files changed, 1 insertion(+), 1 deletion(-)

-- 


--------------020508030608090805020201
Content-Type: text/x-patch;
 name="parport_setup_const.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="parport_setup_const.patch"

diff -Naurp ./drivers/parport/parport_pc.c~parport_setup ./drivers/parport/parport_pc.c
--- ./drivers/parport/parport_pc.c~parport_setup	2004-11-15 09:18:58.423426672 -0800
+++ ./drivers/parport/parport_pc.c	2004-11-15 10:00:05.360395248 -0800
@@ -3154,7 +3154,7 @@ static int __init parport_parse_dma(cons
 				     PARPORT_DMA_NONE, PARPORT_DMA_NOFIFO);
 }
 
-static int __init parport_init_mode_setup(const char *str) {
+static int __init parport_init_mode_setup(char *str) {
 
 	printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
 


--------------020508030608090805020201--
