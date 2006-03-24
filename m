Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422742AbWCXACZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbWCXACZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWCXACZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:02:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59920 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422742AbWCXACY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:02:24 -0500
Date: Fri, 24 Mar 2006 01:02:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: [-mm patch] drivers/char/ipmi/ipmi_si_intf.c: make a struct static
Message-ID: <20060324000223.GL22727@stusta.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm2:
>...
> +ipmi-add-generic-pci-handling.patch
>...
>  Random stuff.
>...

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-mm1-full/drivers/char/ipmi/ipmi_si_intf.c.old	2006-03-23 23:10:58.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/char/ipmi/ipmi_si_intf.c	2006-03-23 23:11:10.000000000 +0100
@@ -2167,7 +2167,7 @@
 	del_timer_sync(&smi_info->si_timer);
 }
 
-struct ipmi_default_vals
+static struct ipmi_default_vals
 {
 	int type;
 	int port;

