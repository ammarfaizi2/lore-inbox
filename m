Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbUCHEP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 23:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUCHEP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 23:15:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:1469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbUCHEOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 23:14:20 -0500
Date: Sun, 7 Mar 2004 20:04:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: ambx1@neo.rr.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] pnp/system.c: 2 functions not __init
Message-Id: <20040307200409.0619935b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Please apply to 2.6.4-rc2.

--
~Randy


// Linux 2.6.4-rc2
// These 2 functions shouldn't be __init for general PNP use.

diffstat:=
 drivers/pnp/system.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naurp ./drivers/pnp/system.c~pnp_init ./drivers/pnp/system.c
--- ./drivers/pnp/system.c~pnp_init	2004-02-17 19:59:59.000000000 -0800
+++ ./drivers/pnp/system.c	2004-03-07 15:14:30.000000000 -0800
@@ -21,7 +21,7 @@ static const struct pnp_device_id pnp_de
 	{	"",			0	}
 };
 
-static void __init reserve_ioport_range(char *pnpid, int start, int end)
+static void reserve_ioport_range(char *pnpid, int start, int end)
 {
 	struct resource *res;
 	char *regionid;
@@ -49,7 +49,7 @@ static void __init reserve_ioport_range(
 	return;
 }
 
-static void __init reserve_resources_of_dev( struct pnp_dev *dev )
+static void reserve_resources_of_dev( struct pnp_dev *dev )
 {
 	int i;
 
