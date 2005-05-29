Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVE2S4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVE2S4u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVE2S4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:56:50 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:51614 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261309AbVE2S4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:56:05 -0400
Date: Sun, 29 May 2005 14:55:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata fixes
Message-ID: <20050529185548.GA7513@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'misc-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
	[might need to use master.kernel.org, if pulling within next 15
	minutes.  kernel.org robots, you know...]

to obtain the following changes:



 drivers/scsi/ahci.c         |    3 +++
 drivers/scsi/ata_piix.c     |    2 ++
 drivers/scsi/libata-core.c  |   15 +++++++++++----
 drivers/scsi/libata.h       |    2 +-
 drivers/scsi/sata_nv.c      |    2 ++
 drivers/scsi/sata_promise.c |    1 +
 drivers/scsi/sata_qstor.c   |    2 ++
 drivers/scsi/sata_sil.c     |    1 +
 drivers/scsi/sata_sis.c     |    1 +
 drivers/scsi/sata_svw.c     |    1 +
 drivers/scsi/sata_sx4.c     |    2 ++
 drivers/scsi/sata_uli.c     |    1 +
 drivers/scsi/sata_via.c     |    1 +
 drivers/scsi/sata_vsc.c     |    2 ++
 include/linux/libata.h      |    1 +
 15 files changed, 32 insertions(+), 5 deletions(-)


commit 7238cfb3342078ad6d1dd06c7b567da428672476
tree cc71a055700bb8c66fcbf74aae1a0122fb5f2433
parent d582c4ea307873503a68d6d7ab72ee8599e032a9
author Jeff Garzik <jgarzik@pobox.com> Sun, 29 May 2005 22:48:20 -0400
committer Jeff Garzik <jgarzik@pobox.com> Sun, 29 May 2005 22:48:20 -0400

libata: bump version

--------------------------
commit d582c4ea307873503a68d6d7ab72ee8599e032a9
tree 30b5ea37ba5803fe25815d14ee248be309975cb5
parent 87507cfdd2cde397c9da8f6e7ec23b2b47ec53d6
parent aa8f0dc6c3dbf1cf3ff58f3e945c981be134814d
author <jgarzik@pretzel.yyz.us> Sun, 29 May 2005 22:24:57 -0400
committer Jeff Garzik <jgarzik@pobox.com> Sun, 29 May 2005 22:24:57 -0400

Automatic merge of /spare/repo/netdev-2.6 branch use-after-unmap

--------------------------
commit 87507cfdd2cde397c9da8f6e7ec23b2b47ec53d6
tree b1b8e9dee213345c4a4a9523923fbd90dc43e8e0
parent 7003c05d77593f567e9940e68a944d846228fd7a
author domen@coderock.org <domen@coderock.org> Fri, 08 Apr 2005 09:53:06 +0200
committer Jeff Garzik <jgarzik@pobox.com> Sat, 28 May 2005 07:59:16 -0400

[PATCH] drivers/scsi/ahci: add #include req'd for the DMA_{64,32}BIT_MASK constants

The previous patch did not compile cleanly on all architectures so
here's a fixed one which #includes <linux/dma-mapping.h>.

Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask()
This patch includes dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

diff -puN drivers/scsi/ahci.c~dma_mask-drivers_scsi_ahci drivers/scsi/ahci.c

--------------------------
commit 7003c05d77593f567e9940e68a944d846228fd7a
tree 096a5e6a7a8b1fb38b6e12d39241b2f5341df9c7
parent 254feb882a7c6e4e51416dff6a97d847fbbba551
author domen@coderock.org <domen@coderock.org> Fri, 08 Apr 2005 09:53:09 +0200
committer Jeff Garzik <jgarzik@pobox.com> Sat, 28 May 2005 07:59:16 -0400

[PATCH] drivers/scsi/sata_vsc: add #include req'd for DMA_32BIT_MASK constant

The previous patch did not compile cleanly on all architectures so
here's a fixed one which #includes <linux/dma-mapping.h>.

Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask()
This patch includes dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

diff -puN drivers/scsi/sata_vsc.c~dma_mask-drivers_scsi_sata_vsc drivers/scsi/sata_vsc.c

--------------------------
commit aa8f0dc6c3dbf1cf3ff58f3e945c981be134814d
tree 3e343cd5493d442d1a26dc7a421422d84698831e
parent bef9c558841604116704e10b3d9ff3dbf4939423
author Jeff Garzik <jgarzik@pobox.com> Fri, 27 May 2005 05:54:27 -0400
committer Jeff Garzik <jgarzik@pobox.com> Fri, 27 May 2005 05:54:27 -0400

libata: Fix use-after-iounmap

Jens Axboe pointed out that the iounmap() call in libata was occurring
too early, and some drivers (ahci, probably others) were using ioremap'd
memory after it had been unmapped.

The patch should address that problem by way of improving the libata
driver API:

* move ->host_stop() call after all ->port_stop() calls have occurred.

* create default helper function ata_host_stop(), and move iounmap()
call there.

* add ->host_stop_prewalk() hook, use it in sata_qstor.c (hi Mark).
sata_qstor appears to require the host-stop-before-port-stop ordering
that existed prior to applying the attached patch.

--------------------------


diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/dma-mapping.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -289,6 +290,8 @@ static void ahci_host_stop(struct ata_ho
 {
 	struct ahci_host_priv *hpriv = host_set->private_data;
 	kfree(hpriv);
+
+	ata_host_stop(host_set);
 }
 
 static int ahci_port_start(struct ata_port *ap)
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -153,6 +153,7 @@ static struct ata_port_operations piix_p
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_operations piix_sata_ops = {
@@ -180,6 +181,7 @@ static struct ata_port_operations piix_s
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info piix_port_info[] = {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3322,6 +3322,13 @@ void ata_port_stop (struct ata_port *ap)
 	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 }
 
+void ata_host_stop (struct ata_host_set *host_set)
+{
+	if (host_set->mmio_base)
+		iounmap(host_set->mmio_base);
+}
+
+
 /**
  *	ata_host_remove - Unregister SCSI host structure with upper layers
  *	@ap: Port to unregister
@@ -3878,10 +3885,6 @@ void ata_pci_remove_one (struct pci_dev 
 	}
 
 	free_irq(host_set->irq, host_set);
-	if (host_set->ops->host_stop)
-		host_set->ops->host_stop(host_set);
-	if (host_set->mmio_base)
-		iounmap(host_set->mmio_base);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
@@ -3900,6 +3903,9 @@ void ata_pci_remove_one (struct pci_dev 
 		scsi_host_put(ap->host);
 	}
 
+	if (host_set->ops->host_stop)
+		host_set->ops->host_stop(host_set);
+
 	kfree(host_set);
 
 	pci_release_regions(pdev);
@@ -3997,6 +4003,7 @@ EXPORT_SYMBOL_GPL(ata_chk_err);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
+EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -26,7 +26,7 @@
 #define __LIBATA_H__
 
 #define DRV_NAME	"libata"
-#define DRV_VERSION	"1.10"	/* must be exactly four chars */
+#define DRV_VERSION	"1.11"	/* must be exactly four chars */
 
 struct ata_scsi_args {
 	u16			*id;
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -329,6 +329,8 @@ static void nv_host_stop (struct ata_hos
 		host->host_desc->disable_hotplug(host_set);
 
 	kfree(host);
+
+	ata_host_stop(host_set);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -122,6 +122,7 @@ static struct ata_port_operations pdc_at
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info pdc_port_info[] = {
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -536,6 +536,8 @@ static void qs_host_stop(struct ata_host
 
 	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
 	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
+
+	ata_host_stop(host_set);
 }
 
 static void qs_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -161,6 +161,7 @@ static struct ata_port_operations sil_op
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info sil_port_info[] = {
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -114,6 +114,7 @@ static struct ata_port_operations sis_op
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info sis_port_info = {
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -313,6 +313,7 @@ static struct ata_port_operations k2_sat
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -245,6 +245,8 @@ static void pdc20621_host_stop(struct at
 
 	iounmap(dimm_mmio);
 	kfree(hpriv);
+
+	ata_host_stop(host_set);
 }
 
 static int pdc_port_start(struct ata_port *ap)
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -113,6 +113,7 @@ static struct ata_port_operations uli_op
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info uli_port_info = {
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -134,6 +134,7 @@ static struct ata_port_operations svia_s
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info svia_port_info = {
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -21,6 +21,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -230,6 +231,7 @@ static struct ata_port_operations vsc_sa
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned long base)
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -410,6 +410,7 @@ extern u8 ata_chk_err(struct ata_port *a
 extern void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
+extern void ata_host_stop (struct ata_host_set *host_set);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
