Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbULNEPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbULNEPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbULNEOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:14:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33289 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261405AbULNEKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:10:09 -0500
Date: Tue, 14 Dec 2004 05:10:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       tulip-users@lists.sourceforge.net, linux-net@vger.kernel.org
Subject: [patch] 2.6.10-rc3-mm1: fix net/tulip/xircom_tulip_cb.c warning
Message-ID: <20041214041005.GY23151@stusta.de>
References: <20041213020319.661b1ad9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213020319.661b1ad9.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 02:03:19AM -0800, Andrew Morton wrote:
>...
> All 794 patches:
>...
> xircom_tulip_cb-build-fix.patch
>   xircom_tulip_cb.c build fix
>...

This patch causes the following warning:

<--  snip  -->

...
  CC      drivers/net/tulip/xircom_tulip_cb.o
drivers/net/tulip/xircom_tulip_cb.c:134: warning: 'num_units' defined but not used
...

<--  snip  -->


The fis is simple:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/net/tulip/xircom_tulip_cb.c.old	2004-12-14 04:37:43.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/net/tulip/xircom_tulip_cb.c	2004-12-14 04:37:48.000000000 +0100
@@ -131,7 +131,6 @@
 module_param(rx_copybreak, int, 0);
 module_param(csr0, int, 0);
 
-static int num_units;
 module_param_array(options, int, NULL, 0);
 module_param_array(full_duplex, int, NULL, 0);
 


