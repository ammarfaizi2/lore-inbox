Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSLBS3K>; Mon, 2 Dec 2002 13:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbSLBS3K>; Mon, 2 Dec 2002 13:29:10 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:6016 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S264779AbSLBS24>;
	Mon, 2 Dec 2002 13:28:56 -0500
Date: Mon, 2 Dec 2002 19:36:19 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.50-current-bk and EDD
Message-ID: <20021202183619.GB9798@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,
   I'm not sure that this patch is correct, but at least I can
compile kernel now. As I have no SCSI devices in the box, I have
no idea whether this to_scsi_host() should do same thing as
to_scsi_host() in drivers/scsi does...
				Thanks,
					Petr Vandrovec
				


diff -urdN linux/arch/i386/kernel/edd.c linux/arch/i386/kernel/edd.c
--- linux/arch/i386/kernel/edd.c	2002-12-02 17:28:11.000000000 +0000
+++ linux/arch/i386/kernel/edd.c	2002-12-02 17:36:49.000000000 +0000
@@ -686,8 +686,6 @@
  * The reference counting probably isn't the best it could be.
  */
 
-#define	to_scsi_host(d)	\
-	container_of(d, struct Scsi_Host, host_driverfs_dev)
 #define children_to_dev(n) container_of(n,struct device,node)
 static struct scsi_device *
 edd_find_matching_scsi_device(struct edd_device *edev)
