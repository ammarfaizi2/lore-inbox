Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUFQJsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUFQJsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUFQJsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 05:48:38 -0400
Received: from CPE-203-51-26-230.nsw.bigpond.net.au ([203.51.26.230]:42492
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264367AbUFQJsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 05:48:36 -0400
Message-ID: <40D168EF.5050009@eyal.emu.id.au>
Date: Thu, 17 Jun 2004 19:48:31 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre6: visor.c (patch)
References: <20040616183343.GA9940@logos.cnet> <40D16710.9010105@eyal.emu.id.au>
In-Reply-To: <40D16710.9010105@eyal.emu.id.au>
Content-Type: multipart/mixed;
 boundary="------------020705040700030508080109"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020705040700030508080109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Forgot to attach this trivial patch...

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)

--------------020705040700030508080109
Content-Type: text/plain;
 name="2.4.27-pre6-visor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.27-pre6-visor.patch"

--- linux/drivers/usb/serial/visor.c.orig	Thu Jun 17 19:18:58 2004
+++ linux/drivers/usb/serial/visor.c	Thu Jun 17 19:19:34 2004
@@ -890,13 +890,12 @@
 {
 	int response;
 	unsigned char *transfer_buffer;
+	struct palm_ext_connection_info *connection_info;
 
 	dbg("%s", __FUNCTION__);
 
 	dbg("%s - Set config to 1", __FUNCTION__);
 	usb_set_configuration(serial->dev, 1);
-
-	struct palm_ext_connection_info *connection_info;
 
 	transfer_buffer = kmalloc(sizeof (*connection_info),
 					GFP_KERNEL);

--------------020705040700030508080109--
