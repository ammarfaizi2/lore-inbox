Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWAPMJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWAPMJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWAPMJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:09:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45244 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750734AbWAPMJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:09:01 -0500
Date: Mon, 16 Jan 2006 13:08:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: lkml <linux-kernel@vger.kernel.org>, jgarzik <jgarzik@pobox.com>,
       jejb <james.bottomley@steeleye.com>
Subject: Re: [PATCH/RFC] SATA in its own config menu
In-Reply-To: <20060115135728.7b13996d.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0601161307590.7465@yvahk01.tjqt.qr>
References: <20060115135728.7b13996d.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Put SATA into its own menu.  Reason:  using SCSI is an
>implementation detail that users need not know about.
>
>Enabling SATA selects SCSI since SATA uses SCSI as a function
>library supplier.  It also enables BLK_DEV_SD since that is
>what SATA drives look like in Linux.

Good idea.

>--- /dev/null
>+++ linux-2615-g10/drivers/scsi/Kconfig.sata
>@@ -0,0 +1,142 @@
>+menu "Serial ATA (SATA) device support"
>+
>+config SCSI_SATA
>+	tristate "Serial ATA (SATA) support"
>+	select SCSI
>+	select BLK_DEV_SD
>+	help
>+	  This driver family supports Serial ATA host controllers
>+	  and devices.
>+
>+	  If unsure, say N.

I'd prefer

menuconfig SCSI_SATA
    tristate "Serial ATA (SATA) suport"
    select SCSI...



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
