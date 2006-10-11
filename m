Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161483AbWJKVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbWJKVQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWJKVQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:16:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:15267 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161438AbWJKVI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:59 -0400
Date: Wed, 11 Oct 2006 14:08:17 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 53/67] sata_mv: fix oops
Message-ID: <20061011210817.GB16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sata_mv-fix-oops.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jeff Garzik <jeff@garzik.org>

From: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/scsi/sata_mv.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.orig/drivers/scsi/sata_mv.c
+++ linux-2.6.18/drivers/scsi/sata_mv.c
@@ -463,6 +463,7 @@ static const struct ata_port_operations 
 
 	.qc_prep		= mv_qc_prep_iie,
 	.qc_issue		= mv_qc_issue,
+	.data_xfer		= ata_mmio_data_xfer,
 
 	.eng_timeout		= mv_eng_timeout,
 

--
