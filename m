Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSK3WmR>; Sat, 30 Nov 2002 17:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSK3WmR>; Sat, 30 Nov 2002 17:42:17 -0500
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:27917 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S261238AbSK3WmQ>;
	Sat, 30 Nov 2002 17:42:16 -0500
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: scx200_gpio.c doesn't compile in 2.5.50
References: <20021128013527.GU21307@fs.tum.de>
From: Christer Weinigel <wingel@nano-system.com>
Organization: Nano Computer Systems AB
Date: 30 Nov 2002 23:49:39 +0100
In-Reply-To: <20021128013527.GU21307@fs.tum.de>
Message-ID: <87of86hdvg.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> writes:

> Compilation of drivers/char/scx200_gpio.c fails in 2.5.50 with the error
> messages below.

Thanks for the report.  Patch follows.

Alan, do you want small fixes like these or should I send them to
someone else?

  /Christer

diff -ur linux-2.5.50/drivers/char/scx200_gpio.c.orig linux-2.5.50/drivers/char/scx200_gpio.c
--- linux-2.5.50/drivers/char/scx200_gpio.c.orig	Wed Nov 27 23:35:47 2002
+++ linux-2.5.50/drivers/char/scx200_gpio.c	Sat Nov 30 23:46:43 2002
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/fs.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
