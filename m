Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUBBSUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUBBSUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:20:00 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:5713 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265684AbUBBST7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:19:59 -0500
Date: Mon, 2 Feb 2004 19:19:58 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 1/42]
Message-ID: <20040202181958.GA6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ac97_plugin_ad1980.c:92: warning: initialization from incompatible pointer type

Fixed. Use correct prototype for ad1980_remove.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/sound/ac97_plugin_ad1980.c linux-2.4/drivers/sound/ac97_plugin_ad1980.c
--- linux-2.4-vanilla/drivers/sound/ac97_plugin_ad1980.c	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/sound/ac97_plugin_ad1980.c	Sat Jan 31 15:57:43 2004
@@ -45,7 +45,7 @@
  *	use of the codec after the probe function.
  */
  
-static void ad1980_remove(struct ac97_codec *codec)
+static void ad1980_remove(struct ac97_codec *codec, struct ac97_driver *driver)
 {
 	/* Nothing to do in the simple example */
 }

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Collect some stars to shine for you
And start today 'cause there's only a few
A sign of times my friend
