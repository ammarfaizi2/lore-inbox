Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVCOWfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVCOWfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVCOWdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:33:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:265 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261936AbVCOWbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:31:18 -0500
Date: Tue, 15 Mar 2005 23:31:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
       davem@davemloft.net, netdev@oss.sgi.com
Subject: [2.6 patch] export dev_get_flags
Message-ID: <20050315223112.GX3189@stusta.de>
References: <200503151852.j2FIqr8t009525@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503151852.j2FIqr8t009525@clem.clem-digital.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 01:52:53PM -0500, Pete Clements wrote:

> Fyi:
>   2.6.11.3-bk1 net/ipv6/ipv6.ko missing symbol dev_get_flags

It seems this patch is required (untested).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3-full/net/core/dev.c.old	2005-03-15 20:13:52.000000000 +0100
+++ linux-2.6.11-mm3-full/net/core/dev.c	2005-03-15 20:14:32.000000000 +0100
@@ -2214,6 +2214,7 @@
 
 	return flags;
 }
+EXPORT_SYMBOL_GPL(dev_get_flags);
 
 int dev_change_flags(struct net_device *dev, unsigned flags)
 {


