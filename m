Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSLFQoU>; Fri, 6 Dec 2002 11:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSLFQoD>; Fri, 6 Dec 2002 11:44:03 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3347 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264795AbSLFQmv>;
	Fri, 6 Dec 2002 11:42:51 -0500
Date: Fri, 6 Dec 2002 08:50:03 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP driver changes for 2.5.50
Message-ID: <20021206165003.GD10376@kroah.com>
References: <20021206164522.GA10376@kroah.com> <20021206164802.GB10376@kroah.com> <20021206164854.GC10376@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206164854.GC10376@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.837.4.3, 2002/12/06 10:08:34-06:00, ambx1@neo.rr.com

[PATCH] PnP gameport driver update

This trivial patch updates the gameport driver to the new id scheme.


diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	Fri Dec  6 10:38:34 2002
+++ b/drivers/input/gameport/ns558.c	Fri Dec  6 10:38:34 2002
@@ -161,7 +161,7 @@
 
 #ifdef CONFIG_PNP
 
-static struct pnp_id pnp_devids[] = {
+static struct pnp_device_id pnp_devids[] = {
 	{ .id = "@P@0001", .driver_data = 0 }, /* ALS 100 */
 	{ .id = "@P@0020", .driver_data = 0 }, /* ALS 200 */
 	{ .id = "@P@1001", .driver_data = 0 }, /* ALS 100+ */
@@ -189,7 +189,7 @@
 
 MODULE_DEVICE_TABLE(pnp, pnp_devids);
 
-static int ns558_pnp_probe(struct pnp_dev *dev, const struct pnp_id *cid, const struct pnp_id *did)
+static int ns558_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
 	int ioport, iolen;
 	struct ns558 *port;
