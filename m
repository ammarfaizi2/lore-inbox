Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbULRAHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbULRAHg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbULRAHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:07:35 -0500
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.69]:2037 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262238AbULRAFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:05:18 -0500
Date: Fri, 17 Dec 2004 19:05:17 -0500
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: Adaptec driver suspend bug ahc_dv_0
In-reply-to: <20041217160345.95366.qmail@web25007.mail.ukl.yahoo.com>
To: Steven Newbury <s_j_newbury@yahoo.co.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <41C3743D.2060204@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_nH2DAelz7Zkq2QFEobVofg)"
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
References: <20041217160345.95366.qmail@web25007.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_nH2DAelz7Zkq2QFEobVofg)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Steven Newbury wrote:

>(Using current bk linus kernel 20041216)
>When attempting to use ACPI sleep states on this system, one of the Adaptec
>driver kernel threads fails to stop:
>  
>
You can try the attached patch; it is all of the current power 
management fixes that are in my local tree. (Most is my own work, one is 
Shaohua's.) If you are using the -mm tree, you will want to remove the 
3c59x patch before applying this, because that is already in -mm.

These patches are believed to be OK for everything except SCSI removable 
disks that use the sd driver, which need better spinup and media change 
handling.

Nathan

--Boundary_(ID_nH2DAelz7Zkq2QFEobVofg)
Content-type: text/plain; name=2.6.10-rc3-20041017.bigdiff
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=2.6.10-rc3-20041017.bigdiff

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/17 18:33:47-05:00 nbryant@optonline.net 
#   Merge
# 
# drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
#   2004/12/17 18:33:45-05:00 nbryant@optonline.net +0 -0
#   SCCS merged
# 
# drivers/scsi/aic7xxx/aic7xxx_osm.h
#   2004/12/17 18:33:45-05:00 nbryant@optonline.net +0 -0
#   SCCS merged
# 
# ChangeSet
#   2004/12/17 18:28:55-05:00 nbryant@optonline.net 
#   update for new pci_save_state api
# 
# drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
#   2004/12/17 18:28:45-05:00 nbryant@optonline.net +2 -2
#   update for new pci_save_state api
# 
# drivers/scsi/aic7xxx/aic7xxx.h
#   2004/12/17 18:28:45-05:00 nbryant@optonline.net +0 -2
#   update for new pci_save_state api
# 
# ChangeSet
#   2004/12/02 21:47:43-05:00 nbryant@optonline.net 
#   sync up
# 
# drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
#   2004/12/02 21:47:33-05:00 nbryant@optonline.net +1 -1
#   hand merge
# 
# drivers/net/3c59x.c
#   2004/12/02 21:47:33-05:00 nbryant@optonline.net +1 -1
#   hand merge
# 
# drivers/scsi/aic7xxx/aic7xxx_pci.c
#   2004/12/01 21:52:26-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/aic7xxx/aic7xxx_osm.h
#   2004/12/01 21:52:26-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/aic7xxx/aic7xxx_osm.c
#   2004/12/01 21:52:26-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/sd.c
#   2004/12/01 21:52:25-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/scsi_sysfs.c
#   2004/12/01 21:52:25-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/scsi_priv.h
#   2004/12/01 21:52:25-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/scsi.c
#   2004/12/01 21:52:25-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/aic7xxx/aic7xxx_core.c
#   2004/12/01 21:52:25-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/aic7xxx/aic7xxx.h
#   2004/12/01 21:52:25-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/scsi/aic7xxx/aic79xx_osm.c
#   2004/12/01 21:52:25-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/acpi/sleep/main.c
#   2004/12/01 21:52:24-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# drivers/acpi/bus.c
#   2004/12/01 21:52:24-05:00 nbryant@optonline.net +0 -0
#   Auto merged
# 
# ChangeSet
#   2004/11/20 17:08:12-05:00 nbryant@optonline.net 
#   aic7xxx_acpi.patch7
# 
# drivers/scsi/aic7xxx/aic7xxx_pci.c
#   2004/07/22 20:45:33-04:00 nbryant@optonline.net +181 -173
#   Import patch aic7xxx_acpi.patch7
# 
# drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
#   2004/07/24 10:28:24-04:00 nbryant@optonline.net +58 -1
#   Import patch aic7xxx_acpi.patch7
# 
# drivers/scsi/aic7xxx/aic7xxx_osm.h
#   2004/07/24 10:01:00-04:00 nbryant@optonline.net +1 -0
#   Import patch aic7xxx_acpi.patch7
# 
# drivers/scsi/aic7xxx/aic7xxx_osm.c
#   2004/07/24 09:59:01-04:00 nbryant@optonline.net +1 -2
#   Import patch aic7xxx_acpi.patch7
# 
# drivers/scsi/aic7xxx/aic7xxx_core.c
#   2004/07/24 09:39:45-04:00 nbryant@optonline.net +1 -0
#   Import patch aic7xxx_acpi.patch7
# 
# drivers/scsi/aic7xxx/aic7xxx.h
#   2004/07/21 22:42:46-04:00 nbryant@optonline.net +3 -1
#   Import patch aic7xxx_acpi.patch7
# 
# drivers/scsi/aic7xxx/aic79xx_osm.c
#   2004/07/21 18:30:06-04:00 nbryant@optonline.net +1 -1
#   Import patch aic7xxx_acpi.patch7
# 
# ChangeSet
#   2004/11/20 17:07:48-05:00 nbryant@optonline.net 
#   scsi-powermanage-2.6.9.patch
# 
# include/scsi/scsi_driver.h
#   2004/11/20 16:49:28-05:00 nbryant@optonline.net +4 -0
#   Import patch scsi-powermanage-2.6.9.patch
# 
# drivers/scsi/sd.c
#   2004/11/20 16:49:28-05:00 nbryant@optonline.net +23 -1
#   Import patch scsi-powermanage-2.6.9.patch
# 
# drivers/scsi/scsi_sysfs.c
#   2004/11/20 16:49:28-05:00 nbryant@optonline.net +6 -2
#   Import patch scsi-powermanage-2.6.9.patch
# 
# drivers/scsi/scsi_priv.h
#   2004/11/20 16:49:28-05:00 nbryant@optonline.net +4 -0
#   Import patch scsi-powermanage-2.6.9.patch
# 
# drivers/scsi/scsi.c
#   2004/11/20 16:49:28-05:00 nbryant@optonline.net +35 -0
#   Import patch scsi-powermanage-2.6.9.patch
# 
# ChangeSet
#   2004/11/20 17:05:53-05:00 nbryant@optonline.net 
#   maskevent.patch3
# 
# drivers/acpi/sleep/main.c
#   2004/08/12 20:49:37-04:00 nbryant@optonline.net +3 -1
#   Import patch maskevent.patch3
# 
# drivers/acpi/event.c
#   2004/08/12 20:49:37-04:00 nbryant@optonline.net +2 -1
#   Import patch maskevent.patch3
# 
# drivers/acpi/bus.c
#   2004/08/12 20:49:37-04:00 nbryant@optonline.net +2 -1
#   Import patch maskevent.patch3
# 
# ChangeSet
#   2004/11/20 16:35:11-05:00 nbryant@optonline.net 
#   3c59x-powermanage.patch
# 
# drivers/net/3c59x.c
#   2004/08/11 22:32:58-04:00 nbryant@optonline.net +14 -11
#   Import patch 3c59x-powermanage.patch
# 
diff -Nru a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/acpi/bus.c	2004-12-17 19:00:30 -05:00
@@ -291,6 +291,7 @@
 DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
 
 extern int			event_is_open;
+extern int			acpi_event_is_masked;
 
 int
 acpi_bus_generate_event (
@@ -307,7 +308,7 @@
 		return_VALUE(-EINVAL);
 
 	/* drop event on the floor if no one's listening */
-	if (!event_is_open)
+	if (!event_is_open || acpi_event_is_masked)
 		return_VALUE(0);
 
 	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
diff -Nru a/drivers/acpi/event.c b/drivers/acpi/event.c
--- a/drivers/acpi/event.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/acpi/event.c	2004-12-17 19:00:30 -05:00
@@ -17,7 +17,8 @@
 
 /* Global vars for handling event proc entry */
 static spinlock_t		acpi_system_event_lock = SPIN_LOCK_UNLOCKED;
-int				event_is_open = 0;
+int				event_is_open;
+int				acpi_event_is_masked;
 extern struct list_head		acpi_bus_event_list;
 extern wait_queue_head_t	acpi_bus_event_queue;
 
diff -Nru a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/acpi/sleep/main.c	2004-12-17 19:00:30 -05:00
@@ -76,7 +76,7 @@
  *	arch-specific assembly, which in turn call acpi_enter_sleep_state().
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
-
+extern int acpi_event_is_masked;
 static int acpi_pm_enter(suspend_state_t pm_state)
 {
 	acpi_status status = AE_OK;
@@ -95,6 +95,7 @@
 
 	local_irq_save(flags);
 	acpi_enable_wakeup_device(acpi_state);
+	acpi_event_is_masked = 1;
 	switch (pm_state)
 	{
 	case PM_SUSPEND_STANDBY:
@@ -145,6 +146,7 @@
 
 	acpi_leave_sleep_state(acpi_state);
 	acpi_disable_wakeup_device(acpi_state);
+	acpi_event_is_masked = 0;
 
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
diff -Nru a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/net/3c59x.c	2004-12-17 19:00:30 -05:00
@@ -1491,7 +1491,7 @@
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	dev->poll_controller = poll_vortex; 
 #endif
-	if (pdev && vp->enable_wol) {
+	if (pdev) {
 		vp->pm_state_valid = 1;
  		pci_save_state(VORTEX_PCI(vp));
  		acpi_set_WOL(dev);
@@ -1548,9 +1548,10 @@
 	unsigned int config;
 	int i;
 
-	if (VORTEX_PCI(vp) && vp->enable_wol) {
+	if (VORTEX_PCI(vp)) {
 		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
 		pci_restore_state(VORTEX_PCI(vp));
+		pci_enable_device(VORTEX_PCI(vp));
 	}
 
 	/* Before initializing select the active media port. */
@@ -2706,7 +2707,7 @@
 	if (vp->full_bus_master_tx)
 		outl(0, ioaddr + DownListPtr);
 
-	if (final_down && VORTEX_PCI(vp) && vp->enable_wol) {
+	if (final_down && VORTEX_PCI(vp)) {
 		pci_save_state(VORTEX_PCI(vp));
 		acpi_set_WOL(dev);
 	}
@@ -3131,15 +3132,17 @@
 	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
-	/* Power up on: 1==Downloaded Filter, 2==Magic Packets, 4==Link Status. */
-	EL3WINDOW(7);
-	outw(2, ioaddr + 0x0c);
-	/* The RxFilter must accept the WOL frames. */
-	outw(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
-	outw(RxEnable, ioaddr + EL3_CMD);
+	if (vp->enable_wol) {
+		/* Power up on: 1==Downloaded Filter, 2==Magic Packets, 4==Link Status. */
+		EL3WINDOW(7);
+		outw(2, ioaddr + 0x0c);
+		/* The RxFilter must accept the WOL frames. */
+		outw(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
+		outw(RxEnable, ioaddr + EL3_CMD);
 
+		pci_enable_wake(VORTEX_PCI(vp), 0, 1);
+	}
 	/* Change the power state to D3; RxEnable doesn't take effect. */
-	pci_enable_wake(VORTEX_PCI(vp), 0, 1);
 	pci_set_power_state(VORTEX_PCI(vp), 3);
 }
 
@@ -3162,7 +3165,7 @@
 	 */
 	unregister_netdev(dev);
 
-	if (VORTEX_PCI(vp) && vp->enable_wol) {
+	if (VORTEX_PCI(vp)) {
 		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
 		if (vp->pm_state_valid)
 			pci_restore_state(VORTEX_PCI(vp));
diff -Nru a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-12-17 19:00:30 -05:00
@@ -2526,7 +2526,7 @@
 	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
 #else
 	daemonize("ahd_dv_%d", ahd->unit);
-	current->flags |= PF_FREEZE;
+	current->flags |= PF_NOFREEZE;
 #endif
 	unlock_kernel();
 
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx.h b/drivers/scsi/aic7xxx/aic7xxx.h
--- a/drivers/scsi/aic7xxx/aic7xxx.h	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/aic7xxx/aic7xxx.h	2004-12-17 19:00:30 -05:00
@@ -1169,7 +1169,7 @@
 /***************************** PCI Front End *********************************/
 struct ahc_pci_identity	*ahc_find_pci_device(ahc_dev_softc_t);
 int			 ahc_pci_config(struct ahc_softc *,
-					struct ahc_pci_identity *);
+					struct ahc_pci_identity *, int resume);
 int			 ahc_pci_test_register_access(struct ahc_softc *);
 
 /*************************** EISA/VL Front End ********************************/
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c	2004-12-17 19:00:30 -05:00
@@ -4045,6 +4045,7 @@
 
 	ahc = (struct ahc_softc *)arg;
 
+	ahc_intr_enable(ahc, FALSE);
 	/* This will reset most registers to 0, but not all */
 	ahc_reset(ahc, /*reinit*/FALSE);
 	ahc_outb(ahc, SCSISEQ, 0);
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-12-17 19:00:30 -05:00
@@ -479,7 +479,6 @@
 static void ahc_linux_release_simq(u_long arg);
 static void ahc_linux_dev_timed_unfreeze(u_long arg);
 static int  ahc_linux_queue_recovery_cmd(Scsi_Cmnd *cmd, scb_flag flag);
-static void ahc_linux_initialize_scsi_bus(struct ahc_softc *ahc);
 static void ahc_linux_size_nseg(void);
 static void ahc_linux_thread_run_complete_queue(struct ahc_softc *ahc);
 static void ahc_linux_start_dv(struct ahc_softc *ahc);
@@ -2224,7 +2223,7 @@
 	sprintf(current->comm, "ahc_dv_%d", ahc->unit);
 #else
 	daemonize("ahc_dv_%d", ahc->unit);
-	current->flags |= PF_FREEZE;
+	current->flags |= PF_NOFREEZE;
 #endif
 	unlock_kernel();
 
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_osm.h b/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-12-17 19:00:30 -05:00
@@ -638,6 +638,7 @@
 					Scsi_Host_Template *);
 
 uint64_t	ahc_linux_get_memsize(void);
+void		ahc_linux_initialize_scsi_bus(struct ahc_softc *ahc);
 
 /*************************** Pretty Printing **********************************/
 struct info_str {
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-12-17 19:00:30 -05:00
@@ -55,6 +55,10 @@
 static int	ahc_linux_pci_reserve_mem_region(struct ahc_softc *ahc,
 						 u_long *bus_addr,
 						 uint8_t __iomem **maddr);
+#ifdef CONFIG_PM
+static int	ahc_linux_pci_suspend(struct pci_dev *dev, u32 state);
+static int	ahc_linux_pci_resume(struct pci_dev *dev);
+#endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static void	ahc_linux_pci_dev_remove(struct pci_dev *pdev);
 
@@ -141,6 +145,10 @@
 	.name		= "aic7xxx",
 	.probe		= ahc_linux_pci_dev_probe,
 	.remove		= ahc_linux_pci_dev_remove,
+#ifdef CONFIG_PM
+	.suspend	= ahc_linux_pci_suspend,
+	.resume		= ahc_linux_pci_resume,
+#endif
 	.id_table	= ahc_linux_pci_id_table
 };
 
@@ -240,7 +248,7 @@
 	}
 #endif
 	ahc->dev_softc = pci;
-	error = ahc_pci_config(ahc, entry);
+	error = ahc_pci_config(ahc, entry, /*resume*/FALSE);
 	if (error != 0) {
 		ahc_free(ahc);
 		return (-error);
@@ -290,6 +298,55 @@
 	return (found);
 #endif
 }
+
+#ifdef CONFIG_PM
+int ahc_linux_pci_suspend(struct pci_dev *dev, u32 state)
+{
+	int rval;
+	u32 device_state;
+	struct ahc_softc *ahc =
+		ahc_find_softc((struct ahc_softc *)pci_get_drvdata(dev));
+
+        switch(state)
+        {
+		case PM_SUSPEND_ON:
+			device_state = 0;
+			break;
+		case PM_SUSPEND_STANDBY:
+		case PM_SUSPEND_MEM:
+		case PM_SUSPEND_DISK:
+		case PM_SUSPEND_MAX:
+                default:
+			device_state = 3;
+                        break;
+        }
+
+	rval = ahc->bus_suspend(ahc);
+	if (rval != 0)
+		return rval;
+
+	pci_save_state(dev);
+	pci_disable_device(dev);
+	pci_set_power_state(dev, device_state);
+	return 0;
+	/*return -EAGAIN;*/
+}
+
+int ahc_linux_pci_resume(struct pci_dev *dev)
+{
+	int rval;
+	struct ahc_softc *ahc =
+		ahc_find_softc((struct ahc_softc *)pci_get_drvdata(dev));
+
+        pci_set_power_state(dev, AHC_POWER_STATE_D0);
+        pci_restore_state(dev);
+        pci_enable_device(dev);
+
+	rval = ahc->bus_resume(ahc);
+	ahc_linux_initialize_scsi_bus(ahc);
+	return rval;
+}
+#endif /* CONFIG_PM */
 
 void
 ahc_linux_pci_exit(void)
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_pci.c b/drivers/scsi/aic7xxx/aic7xxx_pci.c
--- a/drivers/scsi/aic7xxx/aic7xxx_pci.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/aic7xxx/aic7xxx_pci.c	2004-12-17 19:00:30 -05:00
@@ -702,7 +702,7 @@
 }
 
 int
-ahc_pci_config(struct ahc_softc *ahc, struct ahc_pci_identity *entry)
+ahc_pci_config(struct ahc_softc *ahc, struct ahc_pci_identity *entry, int resume)
 {
 	u_long	 l;
 	u_int	 command;
@@ -715,60 +715,62 @@
 	uint8_t	 sblkctl;
 
 	our_id = 0;
-	error = entry->setup(ahc);
-	if (error != 0)
-		return (error);
-	ahc->chip |= AHC_PCI;
-	ahc->description = entry->name;
-
-	ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
-
-	error = ahc_pci_map_registers(ahc);
-	if (error != 0)
-		return (error);
-
-	/*
-	 * Before we continue probing the card, ensure that
-	 * its interrupts are *disabled*.  We don't want
-	 * a misstep to hang the machine in an interrupt
-	 * storm.
-	 */
-	ahc_intr_enable(ahc, FALSE);
-
-	devconfig = ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
-
-	/*
-	 * If we need to support high memory, enable dual
-	 * address cycles.  This bit must be set to enable
-	 * high address bit generation even if we are on a
-	 * 64bit bus (PCI64BIT set in devconfig).
-	 */
-	if ((ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
+	if (!resume) {
+		error = entry->setup(ahc);
+		if (error != 0)
+			return (error);
+		
+		ahc->chip |= AHC_PCI;
+		ahc->description = entry->name;
+		
+		ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
+		
+		error = ahc_pci_map_registers(ahc);
+		if (error != 0)
+			return (error);
+		
+		/*
+		 * Before we continue probing the card, ensure that
+		 * its interrupts are *disabled*.  We don't want
+		 * a misstep to hang the machine in an interrupt
+		 * storm.
+		 */
+		ahc_intr_enable(ahc, FALSE);
 
-		if (bootverbose)
-			printf("%s: Enabling 39Bit Addressing\n",
-			       ahc_name(ahc));
-		devconfig |= DACEN;
-	}
+		devconfig = ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
+		
+		/*
+		 * If we need to support high memory, enable dual
+		 * address cycles.  This bit must be set to enable
+		 * high address bit generation even if we are on a
+		 * 64bit bus (PCI64BIT set in devconfig).
+		 */
+		if ((ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
+			
+			if (bootverbose)
+				printf("%s: Enabling 39Bit Addressing\n",
+				       ahc_name(ahc));
+			devconfig |= DACEN;
+		}
 	
-	/* Ensure that pci error generation, a test feature, is disabled. */
-	devconfig |= PCIERRGENDIS;
-
-	ahc_pci_write_config(ahc->dev_softc, DEVCONFIG, devconfig, /*bytes*/4);
-
-	/* Ensure busmastering is enabled */
-	command = ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/2);
-	command |= PCIM_CMD_BUSMASTEREN;
-
-	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND, command, /*bytes*/2);
-
-	/* On all PCI adapters, we allow SCB paging */
-	ahc->flags |= AHC_PAGESCBS;
-
-	error = ahc_softc_init(ahc);
-	if (error != 0)
-		return (error);
-
+		/* Ensure that pci error generation, a test feature, is disabled. */
+		devconfig |= PCIERRGENDIS;
+		
+		ahc_pci_write_config(ahc->dev_softc, DEVCONFIG, devconfig, /*bytes*/4);
+		
+		/* Ensure busmastering is enabled */
+		command = ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/2);
+		command |= PCIM_CMD_BUSMASTEREN;
+		
+		ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND, command, /*bytes*/2);
+		
+		/* On all PCI adapters, we allow SCB paging */
+		ahc->flags |= AHC_PAGESCBS;
+		
+		error = ahc_softc_init(ahc);
+		if (error != 0)
+			return (error);
+	}
 	/*
 	 * Disable PCI parity error checking.  Users typically
 	 * do this to work around broken PCI chipsets that get
@@ -780,30 +782,32 @@
 	if ((ahc->flags & AHC_DISABLE_PCI_PERR) != 0)
 		ahc->seqctl |= FAILDIS;
 
-	ahc->bus_intr = ahc_pci_intr;
-	ahc->bus_chip_init = ahc_pci_chip_init;
-	ahc->bus_suspend = ahc_pci_suspend;
-	ahc->bus_resume = ahc_pci_resume;
-
-	/* Remeber how the card was setup in case there is no SEEPROM */
-	if ((ahc_inb(ahc, HCNTRL) & POWRDN) == 0) {
-		ahc_pause(ahc);
-		if ((ahc->features & AHC_ULTRA2) != 0)
-			our_id = ahc_inb(ahc, SCSIID_ULTRA2) & OID;
-		else
-			our_id = ahc_inb(ahc, SCSIID) & OID;
-		sxfrctl1 = ahc_inb(ahc, SXFRCTL1) & STPWEN;
-		scsiseq = ahc_inb(ahc, SCSISEQ);
-	} else {
-		sxfrctl1 = STPWEN;
-		our_id = 7;
-		scsiseq = 0;
+	if (!resume) {
+		ahc->bus_intr = ahc_pci_intr;
+		ahc->bus_chip_init = ahc_pci_chip_init;
+		ahc->bus_suspend = ahc_pci_suspend;
+		ahc->bus_resume = ahc_pci_resume;
+
+		/* Remeber how the card was setup in case there is no SEEPROM */
+		if ((ahc_inb(ahc, HCNTRL) & POWRDN) == 0) {
+			ahc_pause(ahc);
+			if ((ahc->features & AHC_ULTRA2) != 0)
+				our_id = ahc_inb(ahc, SCSIID_ULTRA2) & OID;
+			else
+				our_id = ahc_inb(ahc, SCSIID) & OID;
+			sxfrctl1 = ahc_inb(ahc, SXFRCTL1) & STPWEN;
+			scsiseq = ahc_inb(ahc, SCSISEQ);
+		} else {
+			sxfrctl1 = STPWEN;
+			our_id = 7;
+			scsiseq = 0;
+		}
+		
+		error = ahc_reset(ahc, /*reinit*/FALSE);
+		if (error != 0)
+			return (ENXIO);
 	}
 
-	error = ahc_reset(ahc, /*reinit*/FALSE);
-	if (error != 0)
-		return (ENXIO);
-
 	if ((ahc->features & AHC_DT) != 0) {
 		u_int sfunct;
 
@@ -842,30 +846,32 @@
 
 	ahc_outb(ahc, DSCOMMAND0, dscommand0);
 
-	ahc->pci_cachesize =
-	    ahc_pci_read_config(ahc->dev_softc, CSIZE_LATTIME,
-				/*bytes*/1) & CACHESIZE;
-	ahc->pci_cachesize *= 4;
-
-	if ((ahc->bugs & AHC_PCI_2_1_RETRY_BUG) != 0
-	 && ahc->pci_cachesize == 4) {
-
-		ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME,
-				     0, /*bytes*/1);
-		ahc->pci_cachesize = 0;
-	}
-
-	/*
-	 * We cannot perform ULTRA speeds without the presense
-	 * of the external precision resistor.
-	 */
-	if ((ahc->features & AHC_ULTRA) != 0) {
-		uint32_t devconfig;
+	if (!resume) {
+		ahc->pci_cachesize =
+			ahc_pci_read_config(ahc->dev_softc, CSIZE_LATTIME,
+					    /*bytes*/1) & CACHESIZE;
+		ahc->pci_cachesize *= 4;
+
+		if ((ahc->bugs & AHC_PCI_2_1_RETRY_BUG) != 0
+		    && ahc->pci_cachesize == 4) {
+			
+			ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME,
+					     0, /*bytes*/1);
+			ahc->pci_cachesize = 0;
+		}
 
-		devconfig = ahc_pci_read_config(ahc->dev_softc,
-						DEVCONFIG, /*bytes*/4);
-		if ((devconfig & REXTVALID) == 0)
-			ahc->features &= ~AHC_ULTRA;
+		/*
+		 * We cannot perform ULTRA speeds without the presense
+		 * of the external precision resistor.
+		 */
+		if ((ahc->features & AHC_ULTRA) != 0) {
+			uint32_t devconfig;
+			
+			devconfig = ahc_pci_read_config(ahc->dev_softc,
+							DEVCONFIG, /*bytes*/4);
+			if ((devconfig & REXTVALID) == 0)
+				ahc->features &= ~AHC_ULTRA;
+		}
 	}
 
 	/* See if we have a SEEPROM and perform auto-term */
@@ -883,30 +889,32 @@
 		ahc_outb(ahc, DSPCISTATUS, DFTHRSH_100);
 	}
 
-	if (ahc->flags & AHC_USEDEFAULTS) {
-		/*
-		 * PCI Adapter default setup
-		 * Should only be used if the adapter does not have
-		 * a SEEPROM.
-		 */
-		/* See if someone else set us up already */
-		if ((ahc->flags & AHC_NO_BIOS_INIT) == 0
-		 && scsiseq != 0) {
-			printf("%s: Using left over BIOS settings\n",
-				ahc_name(ahc));
-			ahc->flags &= ~AHC_USEDEFAULTS;
-			ahc->flags |= AHC_BIOS_ENABLED;
-		} else {
+	if (!resume) {
+		if (ahc->flags & AHC_USEDEFAULTS) {
 			/*
-			 * Assume only one connector and always turn
-			 * on termination.
+			 * PCI Adapter default setup
+			 * Should only be used if the adapter does not have
+			 * a SEEPROM.
 			 */
- 			our_id = 0x07;
-			sxfrctl1 = STPWEN;
+			/* See if someone else set us up already */
+			if ((ahc->flags & AHC_NO_BIOS_INIT) == 0
+			    && scsiseq != 0) {
+				printf("%s: Using left over BIOS settings\n",
+				       ahc_name(ahc));
+				ahc->flags &= ~AHC_USEDEFAULTS;
+				ahc->flags |= AHC_BIOS_ENABLED;
+			} else {
+				/*
+				 * Assume only one connector and always turn
+				 * on termination.
+				 */
+				our_id = 0x07;
+				sxfrctl1 = STPWEN;
+			}
+			ahc_outb(ahc, SCSICONF, our_id|ENSPCHK|RESET_SCSI);
+			
+			ahc->our_id = our_id;
 		}
-		ahc_outb(ahc, SCSICONF, our_id|ENSPCHK|RESET_SCSI);
-
-		ahc->our_id = our_id;
 	}
 
 	/*
@@ -923,53 +931,55 @@
 	if ((sxfrctl1 & STPWEN) != 0)
 		ahc->flags |= AHC_TERM_ENB_A;
 
-	/*
-	 * Save chip register configuration data for chip resets
-	 * that occur during runtime and resume events.
-	 */
-	ahc->bus_softc.pci_softc.devconfig =
-	    ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
-	ahc->bus_softc.pci_softc.command =
-	    ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/1);
-	ahc->bus_softc.pci_softc.csize_lattime =
-	    ahc_pci_read_config(ahc->dev_softc, CSIZE_LATTIME, /*bytes*/1);
-	ahc->bus_softc.pci_softc.dscommand0 = ahc_inb(ahc, DSCOMMAND0);
-	ahc->bus_softc.pci_softc.dspcistatus = ahc_inb(ahc, DSPCISTATUS);
-	if ((ahc->features & AHC_DT) != 0) {
-		u_int sfunct;
+	if (!resume) {
+		/*
+		 * Save chip register configuration data for chip resets
+		 * that occur during runtime and resume events.
+		 */
+		ahc->bus_softc.pci_softc.devconfig =
+			ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
+		ahc->bus_softc.pci_softc.command =
+			ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/1);
+		ahc->bus_softc.pci_softc.csize_lattime =
+			ahc_pci_read_config(ahc->dev_softc, CSIZE_LATTIME, /*bytes*/1);
+		ahc->bus_softc.pci_softc.dscommand0 = ahc_inb(ahc, DSCOMMAND0);
+		ahc->bus_softc.pci_softc.dspcistatus = ahc_inb(ahc, DSPCISTATUS);
+		if ((ahc->features & AHC_DT) != 0) {
+			u_int sfunct;
+			
+			sfunct = ahc_inb(ahc, SFUNCT) & ~ALT_MODE;
+			ahc_outb(ahc, SFUNCT, sfunct | ALT_MODE);
+			ahc->bus_softc.pci_softc.optionmode = ahc_inb(ahc, OPTIONMODE);
+			ahc->bus_softc.pci_softc.targcrccnt = ahc_inw(ahc, TARGCRCCNT);
+			ahc_outb(ahc, SFUNCT, sfunct);
+			ahc->bus_softc.pci_softc.crccontrol1 =
+				ahc_inb(ahc, CRCCONTROL1);
+		}
+		if ((ahc->features & AHC_MULTI_FUNC) != 0)
+			ahc->bus_softc.pci_softc.scbbaddr = ahc_inb(ahc, SCBBADDR);
+		
+		if ((ahc->features & AHC_ULTRA2) != 0)
+			ahc->bus_softc.pci_softc.dff_thrsh = ahc_inb(ahc, DFF_THRSH);
+		
+		/* Core initialization */
+		error = ahc_init(ahc);
+		if (error != 0)
+			return (error);
 
-		sfunct = ahc_inb(ahc, SFUNCT) & ~ALT_MODE;
-		ahc_outb(ahc, SFUNCT, sfunct | ALT_MODE);
-		ahc->bus_softc.pci_softc.optionmode = ahc_inb(ahc, OPTIONMODE);
-		ahc->bus_softc.pci_softc.targcrccnt = ahc_inw(ahc, TARGCRCCNT);
-		ahc_outb(ahc, SFUNCT, sfunct);
-		ahc->bus_softc.pci_softc.crccontrol1 =
-		    ahc_inb(ahc, CRCCONTROL1);
+		/*
+		 * Allow interrupts now that we are completely setup.
+		 */
+		error = ahc_pci_map_int(ahc);
+		if (error != 0)
+			return (error);
+		
+		ahc_list_lock(&l);
+		/*
+		 * Link this softc in with all other ahc instances.
+		 */
+		ahc_softc_insert(ahc);
+		ahc_list_unlock(&l);
 	}
-	if ((ahc->features & AHC_MULTI_FUNC) != 0)
-		ahc->bus_softc.pci_softc.scbbaddr = ahc_inb(ahc, SCBBADDR);
-
-	if ((ahc->features & AHC_ULTRA2) != 0)
-		ahc->bus_softc.pci_softc.dff_thrsh = ahc_inb(ahc, DFF_THRSH);
-
-	/* Core initialization */
-	error = ahc_init(ahc);
-	if (error != 0)
-		return (error);
-
-	/*
-	 * Allow interrupts now that we are completely setup.
-	 */
-	error = ahc_pci_map_int(ahc);
-	if (error != 0)
-		return (error);
-
-	ahc_list_lock(&l);
-	/*
-	 * Link this softc in with all other ahc instances.
-	 */
-	ahc_softc_insert(ahc);
-	ahc_list_unlock(&l);
 	return (0);
 }
 
@@ -2015,21 +2025,18 @@
 static int
 ahc_pci_resume(struct ahc_softc *ahc)
 {
-
-	ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
-
 	/*
 	 * We assume that the OS has restored our register
 	 * mappings, etc.  Just update the config space registers
 	 * that the OS doesn't know about and rely on our chip
 	 * reset handler to handle the rest.
 	 */
-	ahc_pci_write_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4,
-			     ahc->bus_softc.pci_softc.devconfig);
-	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/1,
-			     ahc->bus_softc.pci_softc.command);
-	ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME, /*bytes*/1,
-			     ahc->bus_softc.pci_softc.csize_lattime);
+	ahc_pci_write_config(ahc->dev_softc, DEVCONFIG,
+			     ahc->bus_softc.pci_softc.devconfig, /*bytes*/4);
+	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND,
+			     ahc->bus_softc.pci_softc.command, /*bytes*/1);
+	ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME,
+			     ahc->bus_softc.pci_softc.csize_lattime, /*bytes*/1);
 	if ((ahc->flags & AHC_HAS_TERM_LOGIC) != 0) {
 		struct	seeprom_descriptor sd;
 		u_int	sxfrctl1;
@@ -2045,6 +2052,7 @@
 				      &sxfrctl1);
 		ahc_release_seeprom(&sd);
 	}
+	ahc_pci_config(ahc, NULL, /*resume*/TRUE);
 	return (ahc_resume(ahc));
 }
 
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/scsi.c	2004-12-17 19:00:30 -05:00
@@ -60,6 +60,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_device.h>
+#include <scsi/scsi_driver.h>
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
@@ -1209,6 +1210,40 @@
 #define register_scsi_cpu()
 #define unregister_scsi_cpu()
 #endif /* CONFIG_HOTPLUG_CPU */
+
+#ifdef CONFIG_PM
+int generic_scsi_suspend(struct device *dev, u32 state)
+{
+	int err;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+	err = scsi_device_quiesce(sdev);
+	if (err)
+		return err;
+
+	if (drv->suspend)
+		return drv->suspend(dev, state);
+
+	return 0;
+}
+
+int generic_scsi_resume(struct device *dev)
+{
+	int err;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+	if (drv->resume) {
+		err = drv->resume(dev);
+		if (err)
+			return err;
+	}
+
+	scsi_device_resume(sdev);
+	return 0;
+}
+#endif /*CONFIG_PM*/
 
 MODULE_DESCRIPTION("SCSI core");
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
--- a/drivers/scsi/scsi_priv.h	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/scsi_priv.h	2004-12-17 19:00:30 -05:00
@@ -82,6 +82,10 @@
 static inline void scsi_log_completion(struct scsi_cmnd *cmd, int disposition)
 	{ };
 #endif
+#ifdef CONFIG_PM
+extern int generic_scsi_suspend(struct device *dev, u32 state);
+extern int generic_scsi_resume(struct device *dev);
+#endif
 
 /* scsi_devinfo.c */
 extern int scsi_get_device_flags(struct scsi_device *sdev,
diff -Nru a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/scsi_sysfs.c	2004-12-17 19:00:30 -05:00
@@ -201,8 +201,12 @@
 }
 
 struct bus_type scsi_bus_type = {
-        .name		= "scsi",
-        .match		= scsi_bus_match,
+	.name		= "scsi",
+	.match		= scsi_bus_match,
+#ifdef CONFIG_PM
+	.suspend	= generic_scsi_suspend,
+	.resume		= generic_scsi_resume,
+#endif
 };
 
 int scsi_sysfs_register(void)
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	2004-12-17 19:00:30 -05:00
+++ b/drivers/scsi/sd.c	2004-12-17 19:00:30 -05:00
@@ -117,6 +117,10 @@
 
 static int sd_probe(struct device *);
 static int sd_remove(struct device *);
+#ifdef CONFIG_PM
+static int sd_suspend(struct device *, u32);
+static int sd_resume(struct device *);
+#endif
 static void sd_shutdown(struct device *dev);
 static void sd_rescan(struct device *);
 static int sd_init_command(struct scsi_cmnd *);
@@ -135,6 +139,10 @@
 	.rescan			= sd_rescan,
 	.init_command		= sd_init_command,
 	.issue_flush		= sd_issue_flush,
+#ifdef CONFIG_PM
+	.suspend		= sd_suspend,
+	.resume			= sd_resume,
+#endif
 };
 
 /*
@@ -1572,7 +1580,21 @@
 	printk(KERN_NOTICE "Synchronizing SCSI cache for disk %s: \n",
 			sdkp->disk->disk_name);
 	sd_sync_cache(sdp);
-}	
+}
+
+#ifdef CONFIG_PM
+static int sd_suspend(struct device *dev, u32 state)
+{
+	sd_shutdown(dev);
+	return 0;
+}
+
+static int sd_resume(struct device *dev)
+{
+	sd_rescan(dev);
+	return 0;
+}
+#endif /*CONFIG_PM*/
 
 /**
  *	init_sd - entry point for this driver (both when built in or when
diff -Nru a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
--- a/include/scsi/scsi_driver.h	2004-12-17 19:00:30 -05:00
+++ b/include/scsi/scsi_driver.h	2004-12-17 19:00:30 -05:00
@@ -14,6 +14,10 @@
 	int (*init_command)(struct scsi_cmnd *);
 	void (*rescan)(struct device *);
 	int (*issue_flush)(struct device *, sector_t *);
+#ifdef CONFIG_PM
+	int (*suspend)(struct device *dev, u32 state);
+	int (*resume)(struct device *dev);
+#endif
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)

--Boundary_(ID_nH2DAelz7Zkq2QFEobVofg)--
