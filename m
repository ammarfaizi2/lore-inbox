Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVBUO7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVBUO7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVBUO66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:58:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45324 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261989AbVBUOsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:48:31 -0500
Date: Mon, 21 Feb 2005 15:48:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rl@hellgate.ch, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/via-rhine.c: make a variable static const
Message-ID: <20050221144826.GF3187@stusta.de>
References: <20050219084433.GU4337@stusta.de> <4216FD14.5070506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4216FD14.5070506@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 03:47:16AM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
>...
> >-int mmio_verify_registers[] = {
> >+static int mmio_verify_registers[] = {
> > 	RxConfig, TxConfig, IntrEnable, ConfigA, ConfigB, ConfigC, ConfigD,
> > 	0
> 
> static const


Updated patch below.


<--  snip  -->


This patch makes a needlessly global variable static const.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/net/via-rhine.c.old	2005-02-16 18:56:59.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/via-rhine.c	2005-02-16 18:57:05.000000000 +0100
@@ -390,7 +390,7 @@
 
 #ifdef USE_MMIO
 /* Registers we check that mmio and reg are the same. */
-int mmio_verify_registers[] = {
+static const int mmio_verify_registers[] = {
 	RxConfig, TxConfig, IntrEnable, ConfigA, ConfigB, ConfigC, ConfigD,
 	0
 };



