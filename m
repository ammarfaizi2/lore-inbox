Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274183AbRISU4p>; Wed, 19 Sep 2001 16:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274184AbRISU4f>; Wed, 19 Sep 2001 16:56:35 -0400
Received: from viper.haque.net ([66.88.179.82]:4224 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S274183AbRISU4b>;
	Wed, 19 Sep 2001 16:56:31 -0400
Date: Wed, 19 Sep 2001 16:56:43 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Orr <markorr@intersurf.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre12 -- PPP compile problem;  tty_register_ldisc hanging
In-Reply-To: <E15jmz5-0003c8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109191655030.1087-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Alan Cox wrote:

> The tty exports are now in the drivers/char/tty* files.

I guess that it didnt get merged then because it's not there.

Here's the correct patch to be used instead of what I posted earlier...

--- linux/drivers/char/tty_io.c.orig	Wed Sep 19 15:59:09 2001
+++ linux/drivers/char/tty_io.c	Wed Sep 19 15:59:20 2001
@@ -270,6 +270,8 @@
 	return 0;
 }

+EXPORT_SYMBOL(tty_register_ldisc);
+
 /* Set the discipline of a tty line. */
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 {

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

