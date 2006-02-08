Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWBHM2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWBHM2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWBHM2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:28:23 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:57993 "HELO farnsworth.org")
	by vger.kernel.org with SMTP id S965111AbWBHM2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:28:22 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 8 Feb 2006 05:28:21 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Olaf Hering <olh@suse.de>
Subject: [PATCH] mv643xx_eth: remove repeated includes of linux/in.h and linux/ip.h
Message-ID: <20060208122821.GA944@xyzzy.farnsworth.org>
References: <E1F6fqN-0006Ba-W6@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1F6fqN-0006Ba-W6@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dale Farnsworth <dale@farnsworth.org>

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---

These includes were added twice:
in commit 78a5e534758349fd3effc90ce1152b55368f52ee by Olaf Hering and
in commit b6298c22c5e9f698812e2520003ee178aad50c10 by Al Viro.
This patch reverts 78a5e534758349fd3effc90ce1152b55368f52ee.

They probably should have been included before linux/tcp.h in
the first place.

 drivers/net/mv643xx_eth.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6-mv643xx_enet/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.6-mv643xx_enet.orig/drivers/net/mv643xx_eth.c
+++ linux-2.6-mv643xx_enet/drivers/net/mv643xx_eth.c
@@ -37,8 +37,6 @@
 #include <linux/tcp.h>
 #include <linux/udp.h>
 #include <linux/etherdevice.h>
-#include <linux/in.h>
-#include <linux/ip.h>
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
