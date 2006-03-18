Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWCRSpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWCRSpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 13:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWCRSpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 13:45:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45071 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750796AbWCRSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 13:45:03 -0500
Date: Sat, 18 Mar 2006 19:45:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/edac/e752x_edac.c: make sysbus_message static
Message-ID: <20060318184500.GD14608@stusta.de>
References: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 04:40:56AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm1:
>...
> +edac-use-sysbus_message-in-e752x-code.patch
>...
>  EDAC updates
>...


This patch makes the needlessly global sysbus_message static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm2-full/drivers/edac/e752x_edac.c.old	2006-03-18 17:57:13.000000000 +0100
+++ linux-2.6.16-rc6-mm2-full/drivers/edac/e752x_edac.c	2006-03-18 17:57:36.000000000 +0100
@@ -472,7 +472,7 @@
 		do_membuf_error(errors);
 }
 
-char *sysbus_message[10] = {
+static char *sysbus_message[10] = {
 	"Addr or Request Parity",
 	"Data Strobe Glitch",
 	"Addr Strobe Glitch",

