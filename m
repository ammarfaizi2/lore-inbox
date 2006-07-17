Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWGQQnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWGQQnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWGQQmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:42:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:31931 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750977AbWGQQcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:48 -0400
Date: Mon, 17 Jul 2006 09:27:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/45] v4l/dvb: stradis: dont export MODULE_DEVICE_TABLE
Message-ID: <20060717162730.GU4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="v4l-dvb-stradis-dont-export-module_device_table.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew de Quincey <adq_dvb@lidskialf.net>

This patch prevents the stradis driver from breaking all
other saa7146 devices by removing the autodetection based
on PCI subsystem ID 0000:0000 (no eeprom).  Users that
want to use the stradis driver will have to manually
insert the module, or specify it in modprobe.conf

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/video/stradis.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.17.3.orig/drivers/media/video/stradis.c
+++ linux-2.6.17.3/drivers/media/video/stradis.c
@@ -2180,7 +2180,6 @@ static struct pci_device_id stradis_pci_
 	{ 0 }
 };
 
-MODULE_DEVICE_TABLE(pci, stradis_pci_tbl);
 
 static struct pci_driver stradis_driver = {
 	.name = "stradis",

--
