Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318904AbSHMB5G>; Mon, 12 Aug 2002 21:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318905AbSHMB5G>; Mon, 12 Aug 2002 21:57:06 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:1765 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318904AbSHMB5F>;
	Mon, 12 Aug 2002 21:57:05 -0400
Date: Mon, 12 Aug 2002 19:00:34 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: [PATCH 2.4] : ir240_usb_fix_greg.diff
Message-ID: <20020813020034.GA21029@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	You probably saw this one comming from multiple source. If
not, there it is.
	Greg : next time, please try to compile. I don't ask any
testing, because I know you can't do that, but there is little excuses
for compilation errors. Yeah, it may add a few seconds to your kernel
compile time.

	Jean


diff -u -p linux/drivers/net/irda/irda-usb.d8.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d8.c	Mon Aug 12 18:36:29 2002
+++ linux/drivers/net/irda/irda-usb.c	Mon Aug 12 18:39:44 2002
@@ -248,7 +248,7 @@ static void irda_usb_change_speed_xbofs(
 {
 	unsigned long flags;
 	__u8 *frame;
-	struct urb *urb;
+	struct urb *purb;
 	int ret;
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), speed=%d, xbofs=%d\n",
