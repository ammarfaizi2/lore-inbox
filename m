Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTBRET4>; Mon, 17 Feb 2003 23:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTBRET4>; Mon, 17 Feb 2003 23:19:56 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:53369
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S267583AbTBRETy>; Mon, 17 Feb 2003 23:19:54 -0500
Message-ID: <3E51B6A6.5000603@rogers.com>
Date: Mon, 17 Feb 2003 23:29:26 -0500
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert NE driver from Jeff Muizelaar (10/13)
References: <20030217182451.GA31474@neo.rr.com> <3E517226.4070405@pobox.com>
In-Reply-To: <3E517226.4070405@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------000600010903010803000802"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Mon, 17 Feb 2003 23:29:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000600010903010803000802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> Looks ok at quick glance.  I'll give it another look and a test 
> compile, and then [most likely] merge it...

Here is another patch that can go on top of the last one. All it does is 
add new PnP ids.
I am not certain about the first three but they look sane enough.
The last one is a card I have and is what I did my testing on so I know 
it works.

-Jeff


--------------000600010903010803000802
Content-Type: text/plain;
 name="ne-patch.3b"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ne-patch.3b"

--- linux-2.5.59/drivers/net/ne.c	2003-01-26 14:25:28.000000000 -0500
+++ linux-2.5.59-patched/drivers/net/ne.c	2003-01-26 14:25:02.000000000 -0500
@@ -81,8 +81,16 @@
 	{.id = "AXE2011", .driver_data = 0},
 	/* NN NE2000 */
 	{.id = "EDI0216", .driver_data = 0},
+	/* Novell/Anthem NE1000 */
+	{.id = "PNP80d3", .driver_data = 0},
+	/* Novell/Anthem NE2000 */
+	{.id = "PNP80d4", .driver_data = 0},
+	/* NE1000 Compatible */
+	{.id = "PNP80d5", .driver_data = 0},
 	/* NE2000 Compatible */
 	{.id = "PNP80d6", .driver_data = 0},
+	/* National Semiconductor AT/LANTIC EtherNODE 16-AT3 */
+	{.id = "PNP8160", .driver_data = 0},
 };
 
 MODULE_DEVICE_TABLE(pnp, ne_pnp_table);

--------------000600010903010803000802--

