Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269238AbUICPuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269238AbUICPuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUICPuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:50:18 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:52648 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269066AbUICPuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:50:14 -0400
Date: Fri, 3 Sep 2004 16:49:43 +0100
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Fix warning in pc300_tty driver.
Message-ID: <20040903154943.GA23274@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <200409031518.i83FIqXK003470@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409031518.i83FIqXK003470@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 08:18:52AM -0700, John Cherry wrote:
 > drivers/net/wan/pc300_tty.c:763: warning: `new' might be used uninitialized in this function

Caused by my last patch to this file.

		Dave

Signed-off-by: Dave Jones <davej@redhat.com>

--- 1/drivers/net/wan/pc300_tty.c~	2004-09-03 16:44:30.321952576 +0100
+++ 2/drivers/net/wan/pc300_tty.c	2004-09-03 16:47:36.585636192 +0100
@@ -760,7 +760,7 @@
 	int rx_len, rx_aux; 
 	volatile unsigned char status; 
 	unsigned short first_bd = pc300chan->rx_first_bd;
-	st_cpc_rx_buf	*new;
+	st_cpc_rx_buf	*new=NULL;
 	unsigned char dsr_rx;
 
 	if (pc300dev->cpc_tty == NULL) { 
