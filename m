Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTFSXwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTFSXwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:52:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5335 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262013AbTFSXv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:51:59 -0400
Date: Fri, 20 Jun 2003 02:05:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] remove two unused variables from baycom_epp.c
Message-ID: <20030620000555.GH29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes two unused variables from 
drivers/net/hamradio/baycom_epp.c .

Please apply
Adrian


--- linux-2.5.72-mm2/drivers/net/hamradio/baycom_epp.c.old	2003-06-20 02:02:11.000000000 +0200
+++ linux-2.5.72-mm2/drivers/net/hamradio/baycom_epp.c	2003-06-20 02:02:51.000000000 +0200
@@ -376,7 +376,6 @@
 	char portarg[16];
         char *argv[] = { eppconfig_path, "-s", "-p", portarg, "-m", modearg,
 			 NULL };
-        int ret;
 
 	/* set up arguments */
 	sprintf(modearg, "%sclk,%smodem,fclk=%d,bps=%d,divider=%d%s,extstat",
@@ -1164,7 +1163,6 @@
 static int baycom_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct baycom_state *bc;
-	struct baycom_ioctl bi;
 	struct hdlcdrv_ioctl hi;
 
 	baycom_paranoia_check(dev, "baycom_ioctl", -EINVAL);
