Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263249AbUJ2AYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263249AbUJ2AYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbUJ2AYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:24:43 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32518 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263203AbUJ2AUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:20:34 -0400
Date: Fri, 29 Oct 2004 02:20:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/3c505.c: remove unused functions
Message-ID: <20041029002002.GN29142@stusta.de>
References: <20041028225802.GT3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028225802.GT3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes two unused functions from drivers/net/3c505.c


diffstat output:
 drivers/net/3c505.c |   10 ----------
 1 files changed, 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/net/3c505.c.old	2004-10-28 23:22:50.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/net/3c505.c	2004-10-28 23:23:08.000000000 +0200
@@ -228,16 +228,6 @@
 	outb(val, base_addr + PORT_COMMAND);
 }
 
-static inline unsigned int inw_data(unsigned int base_addr)
-{
-	return inw(base_addr + PORT_DATA);
-}
-
-static inline void outw_data(unsigned int val, unsigned int base_addr)
-{
-	outw(val, base_addr + PORT_DATA);
-}
-
 static inline unsigned int backlog_next(unsigned int n)
 {
 	return (n + 1) % BACKLOG_SIZE;
