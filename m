Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbULEMxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbULEMxw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 07:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULEMxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 07:53:52 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:51613 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261298AbULEMxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 07:53:49 -0500
Date: Sun, 5 Dec 2004 07:53:37 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Ron Murray <rjmx@rjmx.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] CS461x gameport code isn't being included in build
In-Reply-To: <41B237C6.9030404@rjmx.net>
Message-ID: <Pine.LNX.4.61.0412050628300.31025@linaeum.absolutedigital.net>
References: <41B237C6.9030404@rjmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2004, Ron Murray wrote:

>    I've found a typo in drivers/input/gameport/Makefile in kernel
> 2.6.9 which effectively prevents the CS461x gameport code from
> being included. Here's the diff:

Good catch Ron (I thought I noticed that this wasn't being built), but 
your patch appears to have been whitespace damaged.

Vojtech, here's one that should apply cleanly.

thanks,

-- Cal

> Signed-off-by: Ron Murray <rjmx@rjmx.net>

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.6.10-rc3/drivers/input/gameport/Makefile	2004-10-18 17:53:06.000000000 -0400
+++ linux-2.6.10-rc3-1/drivers/input/gameport/Makefile	2004-12-05 06:26:15.000000000 -0500
@@ -5,7 +5,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_GAMEPORT)		+= gameport.o
-obj-$(CONFIG_GAMEPORT_CS461X)	+= cs461x.o
+obj-$(CONFIG_GAMEPORT_CS461x)	+= cs461x.o
 obj-$(CONFIG_GAMEPORT_EMU10K1)	+= emu10k1-gp.o
 obj-$(CONFIG_GAMEPORT_FM801)	+= fm801-gp.o
 obj-$(CONFIG_GAMEPORT_L4)	+= lightning.o
