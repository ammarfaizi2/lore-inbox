Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVHRAO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVHRAO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVHRAO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:14:59 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:10111 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751395AbVHRAOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:14:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=AKj/s97gO7jmn0Gmx/dzFwHs2+TaMiaec2gDMQBHIPokvDBKEe6UL9O+A9JHP9dTPqKgDNhJquS37pRsAXEiSHLq+h1p50Hb+pm6gvA7FHXiMlLQRAthbADQ9x7Hqk94JpUoMSUE4DIdhTHC2wovXHzFFhw3R/ZfRNMLkcFp9sg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] rename locking functions - convert init_MUTEX* users, part 1
Date: Thu, 18 Aug 2005 02:14:22 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508180214.22537.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert users of init_MUTEX and init_MUTEX_LOCKED to
init_mutex and init_mutex_locked - part 1.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/i2c/writing-clients            |    2 +-
 arch/arm/oprofile/common.c                   |    2 +-
 arch/i386/kernel/ldt.c                       |    2 +-
 arch/ppc/platforms/pmac_low_i2c.c            |    4 ++--
 arch/ppc64/kernel/pmac_low_i2c.c             |    4 ++--
 arch/ppc64/kernel/viopath.c                  |    4 ++--
 arch/sh/drivers/dma/dma-api.c                |    2 +-
 arch/x86_64/kernel/ldt.c                     |    2 +-
 drivers/acpi/ec.c                            |    6 +++---
 drivers/acpi/video.c                         |    2 +-
 drivers/atm/ambassador.c                     |    2 +-
 drivers/atm/fore200e.c                       |    2 +-
 drivers/atm/idt77252.c                       |    2 +-
 drivers/base/class.c                         |    2 +-
 drivers/base/core.c                          |    2 +-
 drivers/block/loop.c                         |    6 +++---
 drivers/block/nbd.c                          |    2 +-
 drivers/block/pktcdvd.c                      |    2 +-
 drivers/block/sx8.c                          |    2 +-
 drivers/char/generic_serial.c                |    2 +-
 drivers/char/lp.c                            |    2 +-
 drivers/char/mbcs.c                          |    6 +++---
 drivers/char/moxa.c                          |    2 +-
 drivers/char/ser_a2232.c                     |    2 +-
 drivers/char/sonypi.c                        |    2 +-
 drivers/char/specialix.c                     |    2 +-
 drivers/char/tpm/tpm.c                       |    4 ++--
 drivers/char/tty_io.c                        |    4 ++--
 drivers/char/watchdog/cpu5wdt.c              |    2 +-
 drivers/char/watchdog/pcwd_usb.c             |    2 +-
 drivers/cpufreq/cpufreq.c                    |    2 +-
 drivers/fc4/fc.c                             |    6 +++---
 drivers/hwmon/adm1021.c                      |    2 +-
 drivers/hwmon/adm1025.c                      |    2 +-
 drivers/hwmon/adm1026.c                      |    2 +-
 drivers/hwmon/adm1031.c                      |    2 +-
 drivers/hwmon/adm9240.c                      |    2 +-
 drivers/hwmon/asb100.c                       |    4 ++--
 drivers/hwmon/atxp1.c                        |    2 +-
 drivers/hwmon/ds1621.c                       |    2 +-
 drivers/hwmon/fscher.c                       |    2 +-
 drivers/hwmon/fscpos.c                       |    2 +-
 drivers/hwmon/gl518sm.c                      |    2 +-
 drivers/hwmon/gl520sm.c                      |    2 +-
 drivers/hwmon/it87.c                         |    4 ++--
 drivers/hwmon/lm63.c                         |    2 +-
 drivers/hwmon/lm75.c                         |    2 +-
 drivers/hwmon/lm77.c                         |    2 +-
 drivers/hwmon/lm78.c                         |    4 ++--
 drivers/hwmon/lm80.c                         |    2 +-
 drivers/hwmon/lm83.c                         |    2 +-
 drivers/hwmon/lm85.c                         |    2 +-
 drivers/hwmon/lm87.c                         |    2 +-
 drivers/hwmon/lm90.c                         |    2 +-
 drivers/hwmon/lm92.c                         |    2 +-
 drivers/hwmon/max1619.c                      |    2 +-
 drivers/hwmon/pc87360.c                      |    4 ++--
 drivers/hwmon/sis5595.c                      |    4 ++--
 drivers/hwmon/smsc47b397.c                   |    4 ++--
 drivers/hwmon/smsc47m1.c                     |    4 ++--
 drivers/hwmon/via686a.c                      |    2 +-
 drivers/hwmon/w83627ehf.c                    |    4 ++--
 drivers/hwmon/w83627hf.c                     |    4 ++--
 drivers/hwmon/w83781d.c                      |    4 ++--
 drivers/hwmon/w83l785ts.c                    |    2 +-
 drivers/i2c/busses/i2c-amd756-s4882.c        |    2 +-
 drivers/i2c/busses/scx200_acb.c              |    2 +-
 drivers/i2c/chips/eeprom.c                   |    2 +-
 drivers/i2c/chips/max6875.c                  |    2 +-
 drivers/i2c/chips/pcf8591.c                  |    2 +-
 drivers/i2c/chips/tps65010.c                 |    2 +-
 drivers/i2c/i2c-core.c                       |    4 ++--
 drivers/ieee1394/dv1394.c                    |    2 +-
 drivers/infiniband/core/ucm.c                |    6 +++---
 drivers/infiniband/core/user_mad.c           |    2 +-
 drivers/infiniband/hw/mthca/mthca_mcg.c      |    2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c  |    6 +++---
 drivers/infiniband/hw/mthca/mthca_provider.c |    2 +-
 78 files changed, 106 insertions(+), 106 deletions(-)

--- linux-2.6.13-rc6-git9-orig/Documentation/i2c/writing-clients	2005-08-17 21:51:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/Documentation/i2c/writing-clients	2005-08-18 00:55:10.000000000 +0200
@@ -435,7 +435,7 @@ For now, you can ignore the `flags' para
     /* SENSORS ONLY END */
 
     data->valid = 0; /* Only if you use this field */
-    init_MUTEX(&data->update_lock); /* Only if you use this field */
+    init_mutex(&data->update_lock); /* Only if you use this field */
 
     /* Any other initializations in data must be done here too. */
 
--- linux-2.6.13-rc6-git9-orig/arch/arm/oprofile/common.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/arm/oprofile/common.c	2005-08-18 00:55:10.000000000 +0200
@@ -128,7 +128,7 @@ static void pmu_stop(void)
 
 int __init pmu_init(struct oprofile_operations *ops, struct op_arm_model_spec *spec)
 {
-	init_MUTEX(&pmu_sem);
+	init_mutex(&pmu_sem);
 
 	if (spec->init() < 0)
 		return -ENODEV;
--- linux-2.6.13-rc6-git9-orig/arch/i386/kernel/ldt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/i386/kernel/ldt.c	2005-08-18 00:55:10.000000000 +0200
@@ -94,7 +94,7 @@ int init_new_context(struct task_struct 
 	struct mm_struct * old_mm;
 	int retval = 0;
 
-	init_MUTEX(&mm->context.sem);
+	init_mutex(&mm->context.sem);
 	mm->context.size = 0;
 	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
--- linux-2.6.13-rc6-git9-orig/arch/ppc/platforms/pmac_low_i2c.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/ppc/platforms/pmac_low_i2c.c	2005-08-18 00:55:10.000000000 +0200
@@ -341,7 +341,7 @@ static void keywest_low_i2c_add(struct d
 	}
 	memset(host, 0, sizeof(*host));
 
-	init_MUTEX(&host->mutex);
+	init_mutex(&host->mutex);
 	host->np = of_node_get(np);	
 	psteps = (unsigned long *)get_property(np, "AAPL,address-step", NULL);
 	steps = psteps ? (*psteps) : 0x10;
@@ -399,7 +399,7 @@ static void pmu_low_i2c_add(struct devic
 	}
 	memset(host, 0, sizeof(*host));
 
-	init_MUTEX(&host->mutex);
+	init_mutex(&host->mutex);
 	host->np = of_node_get(np);	
 	host->num_channels = 3;
 	host->mode = pmac_low_i2c_mode_std;
--- linux-2.6.13-rc6-git9-orig/arch/ppc64/kernel/pmac_low_i2c.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/pmac_low_i2c.c	2005-08-18 00:55:10.000000000 +0200
@@ -352,7 +352,7 @@ static void keywest_low_i2c_add(struct d
 	}
 	memset(host, 0, sizeof(*host));
 
-	init_MUTEX(&host->mutex);
+	init_mutex(&host->mutex);
 	host->np = of_node_get(np);	
 	psteps = (u32 *)get_property(np, "AAPL,address-step", NULL);
 	steps = psteps ? (*psteps) : 0x10;
@@ -411,7 +411,7 @@ static void pmu_low_i2c_add(struct devic
 	}
 	memset(host, 0, sizeof(*host));
 
-	init_MUTEX(&host->mutex);
+	init_mutex(&host->mutex);
 	host->np = of_node_get(np);	
 	host->num_channels = 3;
 	host->mode = pmac_low_i2c_mode_std;
--- linux-2.6.13-rc6-git9-orig/arch/ppc64/kernel/viopath.c	2005-08-17 21:51:34.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/viopath.c	2005-08-18 00:55:10.000000000 +0200
@@ -467,7 +467,7 @@ static int allocateEvents(HvLpIndex remo
 		atomic_set(&parms.wait_atomic, 1);
 	} else {
 		parms.used_wait_atomic = 0;
-		init_MUTEX_LOCKED(&parms.sem);
+		init_mutex_locked(&parms.sem);
 	}
 	mf_allocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo, 250,	/* It would be nice to put a real number here! */
 			    numEvents, &viopath_donealloc, &parms);
@@ -576,7 +576,7 @@ int viopath_close(HvLpIndex remoteLp, in
 	spin_unlock_irqrestore(&statuslock, flags);
 
 	parms.used_wait_atomic = 0;
-	init_MUTEX_LOCKED(&parms.sem);
+	init_mutex_locked(&parms.sem);
 	mf_deallocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo,
 			      numReq, &viopath_donealloc, &parms);
 	down(&parms.sem);
--- linux-2.6.13-rc6-git9-orig/arch/sh/drivers/dma/dma-api.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/sh/drivers/dma/dma-api.c	2005-08-18 00:55:10.000000000 +0200
@@ -242,7 +242,7 @@ int __init register_dmac(struct dma_info
 		if (info->flags & DMAC_CHANNELS_TEI_CAPABLE)
 			chan->flags |= DMA_TEI_CAPABLE;
 
-		init_MUTEX(&chan->sem);
+		init_mutex(&chan->sem);
 		init_waitqueue_head(&chan->wait_queue);
 
 #ifdef CONFIG_SYSFS
--- linux-2.6.13-rc6-git9-orig/arch/x86_64/kernel/ldt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/x86_64/kernel/ldt.c	2005-08-18 00:55:10.000000000 +0200
@@ -99,7 +99,7 @@ int init_new_context(struct task_struct 
 	struct mm_struct * old_mm;
 	int retval = 0;
 
-	init_MUTEX(&mm->context.sem);
+	init_mutex(&mm->context.sem);
 	mm->context.size = 0;
 	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
--- linux-2.6.13-rc6-git9-orig/drivers/acpi/ec.c	2005-08-17 21:51:36.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/acpi/ec.c	2005-08-18 00:55:10.000000000 +0200
@@ -1207,7 +1207,7 @@ acpi_ec_burst_add (
 	ec->common.uid = -1;
  	atomic_set(&ec->burst.pending_gpe, 0);
  	atomic_set(&ec->burst.leaving_burst , 1);
- 	init_MUTEX(&ec->burst.sem);
+ 	init_mutex(&ec->burst.sem);
  	init_waitqueue_head(&ec->burst.wait);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
@@ -1454,7 +1454,7 @@ acpi_fake_ecdt_burst_callback (
 {
 	acpi_status	status;
 
-	init_MUTEX(&ec_ecdt->burst.sem);
+	init_mutex(&ec_ecdt->burst.sem);
 	init_waitqueue_head(&ec_ecdt->burst.wait);
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 		acpi_ec_io_ports, ec_ecdt);
@@ -1594,7 +1594,7 @@ acpi_ec_burst_get_real_ecdt(void)
 		return -ENOMEM;
 	memset(ec_ecdt, 0, sizeof(union acpi_ec));
 
- 	init_MUTEX(&ec_ecdt->burst.sem);
+ 	init_mutex(&ec_ecdt->burst.sem);
  	init_waitqueue_head(&ec_ecdt->burst.wait);
 	ec_ecdt->common.command_addr = ecdt_ptr->ec_control;
 	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
--- linux-2.6.13-rc6-git9-orig/drivers/acpi/video.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/acpi/video.c	2005-08-18 00:55:10.000000000 +0200
@@ -1844,7 +1844,7 @@ acpi_video_bus_add (
 	if (result)
 		goto end;
 
-	init_MUTEX(&video->sem);
+	init_mutex(&video->sem);
 	INIT_LIST_HEAD(&video->video_device_list);
 
 	acpi_video_bus_get_devices(video, device);
--- linux-2.6.13-rc6-git9-orig/drivers/atm/ambassador.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/atm/ambassador.c	2005-08-18 00:55:10.000000000 +0200
@@ -2204,7 +2204,7 @@ static void setup_dev(amb_dev *dev, stru
       
       // semaphore for txer/rxer modifications - we cannot use a
       // spinlock as the critical region needs to switch processes
-      init_MUTEX (&dev->vcc_sf);
+      init_mutex (&dev->vcc_sf);
       // queue manipulation spinlocks; we want atomic reads and
       // writes to the queue descriptors (handles IRQ and SMP)
       // consider replacing "int pending" -> "atomic_t available"
--- linux-2.6.13-rc6-git9-orig/drivers/atm/fore200e.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/atm/fore200e.c	2005-08-18 00:55:10.000000000 +0200
@@ -2497,7 +2497,7 @@ fore200e_initialize(struct fore200e* for
 
     DPRINTK(2, "device %s being initialized\n", fore200e->name);
 
-    init_MUTEX(&fore200e->rate_sf);
+    init_mutex(&fore200e->rate_sf);
     spin_lock_init(&fore200e->q_lock);
 
     cpq = fore200e->cp_queues = fore200e->virt_base + FORE200E_CP_QUEUES_OFFSET;
--- linux-2.6.13-rc6-git9-orig/drivers/atm/idt77252.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/atm/idt77252.c	2005-08-18 00:55:10.000000000 +0200
@@ -3713,7 +3713,7 @@ idt77252_init_one(struct pci_dev *pcidev
 	membase = pci_resource_start(pcidev, 1);
 	srambase = pci_resource_start(pcidev, 2);
 
-	init_MUTEX(&card->mutex);
+	init_mutex(&card->mutex);
 	spin_lock_init(&card->cmd_lock);
 	spin_lock_init(&card->tst_lock);
 
--- linux-2.6.13-rc6-git9-orig/drivers/base/class.c	2005-08-17 21:53:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/base/class.c	2005-08-18 00:55:10.000000000 +0200
@@ -141,7 +141,7 @@ int class_register(struct class * cls)
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
-	init_MUTEX(&cls->sem);
+	init_mutex(&cls->sem);
 	error = kobject_set_name(&cls->subsys.kset.kobj, "%s", cls->name);
 	if (error)
 		return error;
--- linux-2.6.13-rc6-git9-orig/drivers/base/core.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/base/core.c	2005-08-18 00:55:10.000000000 +0200
@@ -209,7 +209,7 @@ void device_initialize(struct device *de
 	kobject_init(&dev->kobj);
 	klist_init(&dev->klist_children);
 	INIT_LIST_HEAD(&dev->dma_pools);
-	init_MUTEX(&dev->sem);
+	init_mutex(&dev->sem);
 }
 
 /**
--- linux-2.6.13-rc6-git9-orig/drivers/block/loop.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/block/loop.c	2005-08-18 00:55:10.000000000 +0200
@@ -1275,9 +1275,9 @@ static int __init loop_init(void)
 		lo->lo_queue = blk_alloc_queue(GFP_KERNEL);
 		if (!lo->lo_queue)
 			goto out_mem4;
-		init_MUTEX(&lo->lo_ctl_mutex);
-		init_MUTEX_LOCKED(&lo->lo_sem);
-		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
+		init_mutex(&lo->lo_ctl_mutex);
+		init_mutex_locked(&lo->lo_sem);
+		init_mutex_locked(&lo->lo_bh_mutex);
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
 		disk->major = LOOP_MAJOR;
--- linux-2.6.13-rc6-git9-orig/drivers/block/nbd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/block/nbd.c	2005-08-18 00:55:10.000000000 +0200
@@ -687,7 +687,7 @@ static int __init nbd_init(void)
 		nbd_dev[i].flags = 0;
 		spin_lock_init(&nbd_dev[i].queue_lock);
 		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
-		init_MUTEX(&nbd_dev[i].tx_lock);
+		init_mutex(&nbd_dev[i].tx_lock);
 		nbd_dev[i].blksize = 1024;
 		nbd_dev[i].bytesize = 0x7ffffc00ULL << 10; /* 2TB */
 		disk->major = NBD_MAJOR;
--- linux-2.6.13-rc6-git9-orig/drivers/block/pktcdvd.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/block/pktcdvd.c	2005-08-18 00:55:10.000000000 +0200
@@ -2662,7 +2662,7 @@ static int __init pkt_init(void)
 		goto out;
 	}
 
-	init_MUTEX(&ctl_mutex);
+	init_mutex(&ctl_mutex);
 
 	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
 
--- linux-2.6.13-rc6-git9-orig/drivers/block/sx8.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/block/sx8.c	2005-08-18 00:55:10.000000000 +0200
@@ -1618,7 +1618,7 @@ static int carm_init_one (struct pci_dev
 	host->flags = pci_dac ? FL_DAC : 0;
 	spin_lock_init(&host->lock);
 	INIT_WORK(&host->fsm_task, carm_fsm_task, host);
-	init_MUTEX_LOCKED(&host->probe_sem);
+	init_mutex_locked(&host->probe_sem);
 
 	for (i = 0; i < ARRAY_SIZE(host->req); i++)
 		host->req[i].tag = i;
--- linux-2.6.13-rc6-git9-orig/drivers/char/generic_serial.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/generic_serial.c	2005-08-18 00:55:10.000000000 +0200
@@ -889,7 +889,7 @@ int gs_init_port(struct gs_port *port)
 	spin_lock_irqsave (&port->driver_lock, flags);
 	if (port->tty) 
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
-	init_MUTEX(&port->port_write_sem);
+	init_mutex(&port->port_write_sem);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
 	spin_unlock_irqrestore(&port->driver_lock, flags);
 	gs_set_termios(port->tty, NULL);
--- linux-2.6.13-rc6-git9-orig/drivers/char/lp.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/lp.c	2005-08-18 00:55:10.000000000 +0200
@@ -897,7 +897,7 @@ static int __init lp_init (void)
 		lp_table[i].last_error = 0;
 		init_waitqueue_head (&lp_table[i].waitq);
 		init_waitqueue_head (&lp_table[i].dataq);
-		init_MUTEX (&lp_table[i].port_mutex);
+		init_mutex (&lp_table[i].port_mutex);
 		lp_table[i].timeout = 10 * HZ;
 	}
 
--- linux-2.6.13-rc6-git9-orig/drivers/char/mbcs.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/mbcs.c	2005-08-18 00:55:10.000000000 +0200
@@ -764,9 +764,9 @@ static int mbcs_probe(struct cx_dev *dev
 	init_waitqueue_head(&soft->dmaread_queue);
 	init_waitqueue_head(&soft->algo_queue);
 
-	init_MUTEX(&soft->dmawritelock);
-	init_MUTEX(&soft->dmareadlock);
-	init_MUTEX(&soft->algolock);
+	init_mutex(&soft->dmawritelock);
+	init_mutex(&soft->dmareadlock);
+	init_mutex(&soft->algolock);
 
 	mbcs_getdma_init(&soft->getdma);
 	mbcs_putdma_init(&soft->putdma);
--- linux-2.6.13-rc6-git9-orig/drivers/char/moxa.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/moxa.c	2005-08-18 00:55:10.000000000 +0200
@@ -337,7 +337,7 @@ static int __init moxa_init(void)
 	if (!moxaDriver)
 		return -ENOMEM;
 
-	init_MUTEX(&moxaBuffSem);
+	init_mutex(&moxaBuffSem);
 	moxaDriver->owner = THIS_MODULE;
 	moxaDriver->name = "ttya";
 	moxaDriver->devfs_name = "tts/a";
--- linux-2.6.13-rc6-git9-orig/drivers/char/ser_a2232.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/ser_a2232.c	2005-08-18 00:55:10.000000000 +0200
@@ -659,7 +659,7 @@ static void a2232_init_portstructs(void)
 		port->gs.closing_wait = 30 * HZ;
 		port->gs.rd = &a2232_real_driver;
 #ifdef NEW_WRITE_LOCKING
-		init_MUTEX(&(port->gs.port_write_sem));
+		init_mutex(&(port->gs.port_write_sem));
 #endif
 		init_waitqueue_head(&port->gs.open_wait);
 		init_waitqueue_head(&port->gs.close_wait);
--- linux-2.6.13-rc6-git9-orig/drivers/char/sonypi.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/sonypi.c	2005-08-18 00:55:10.000000000 +0200
@@ -1160,7 +1160,7 @@ static int __devinit sonypi_probe(void)
 	}
 
 	init_waitqueue_head(&sonypi_device.fifo_proc_list);
-	init_MUTEX(&sonypi_device.lock);
+	init_mutex(&sonypi_device.lock);
 	sonypi_device.bluetooth_power = -1;
 
 	if (pcidev && pci_enable_device(pcidev)) {
--- linux-2.6.13-rc6-git9-orig/drivers/char/specialix.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/specialix.c	2005-08-18 00:55:10.000000000 +0200
@@ -2569,7 +2569,7 @@ static int __init specialix_init_module(
 
 	func_enter();
 
-	init_MUTEX(&tmp_buf_sem); /* Init de the semaphore - pvdl */
+	init_mutex(&tmp_buf_sem); /* Init de the semaphore - pvdl */
 
 	if (iobase[0] || iobase[1] || iobase[2] || iobase[3]) {
 		for(i = 0; i < SX_NBOARD; i++) {
--- linux-2.6.13-rc6-git9-orig/drivers/char/tpm/tpm.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/tpm/tpm.c	2005-08-18 00:55:10.000000000 +0200
@@ -540,8 +540,8 @@ int tpm_register_hardware(struct pci_dev
 
 	memset(chip, 0, sizeof(struct tpm_chip));
 
-	init_MUTEX(&chip->buffer_mutex);
-	init_MUTEX(&chip->tpm_mutex);
+	init_mutex(&chip->buffer_mutex);
+	init_mutex(&chip->tpm_mutex);
 	INIT_LIST_HEAD(&chip->list);
 
 	init_timer(&chip->user_read_timer);
--- linux-2.6.13-rc6-git9-orig/drivers/char/tty_io.c	2005-08-18 00:53:30.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/tty_io.c	2005-08-18 00:55:10.000000000 +0200
@@ -2645,8 +2645,8 @@ static void initialize_tty_struct(struct
 	tty->flip.char_buf_ptr = tty->flip.char_buf;
 	tty->flip.flag_buf_ptr = tty->flip.flag_buf;
 	INIT_WORK(&tty->flip.work, flush_to_ldisc, tty);
-	init_MUTEX(&tty->flip.pty_sem);
-	init_MUTEX(&tty->termios_sem);
+	init_mutex(&tty->flip.pty_sem);
+	init_mutex(&tty->termios_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup, tty);
--- linux-2.6.13-rc6-git9-orig/drivers/char/watchdog/cpu5wdt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/watchdog/cpu5wdt.c	2005-08-18 00:55:10.000000000 +0200
@@ -238,7 +238,7 @@ static int __devinit cpu5wdt_init(void)
 	if ( !val )
 		printk(KERN_INFO PFX "sorry, was my fault\n");
 
-	init_MUTEX_LOCKED(&cpu5wdt_device.stop);
+	init_mutex_locked(&cpu5wdt_device.stop);
 	cpu5wdt_device.queue = 0;
 
 	clear_bit(0, &cpu5wdt_device.inuse);
--- linux-2.6.13-rc6-git9-orig/drivers/char/watchdog/pcwd_usb.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/watchdog/pcwd_usb.c	2005-08-18 00:55:10.000000000 +0200
@@ -606,7 +606,7 @@ static int usb_pcwd_probe(struct usb_int
 
 	usb_pcwd_device = usb_pcwd;
 
-	init_MUTEX (&usb_pcwd->sem);
+	init_mutex (&usb_pcwd->sem);
 	usb_pcwd->udev = udev;
 	usb_pcwd->interface = interface;
 	usb_pcwd->interface_number = iface_desc->desc.bInterfaceNumber;
--- linux-2.6.13-rc6-git9-orig/drivers/cpufreq/cpufreq.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/cpufreq/cpufreq.c	2005-08-18 00:55:10.000000000 +0200
@@ -605,7 +605,7 @@ static int cpufreq_add_dev (struct sys_d
 	policy->cpu = cpu;
 	policy->cpus = cpumask_of_cpu(cpu);
 
-	init_MUTEX_LOCKED(&policy->lock);
+	init_mutex_locked(&policy->lock);
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update, (void *)(long)cpu);
 
--- linux-2.6.13-rc6-git9-orig/drivers/fc4/fc.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/fc4/fc.c	2005-08-18 00:55:10.000000000 +0200
@@ -550,7 +550,7 @@ int fcp_initialize(fc_channel *fcchain, 
 	l->magic = LSMAGIC;
 	l->count = count;
 	FCND(("FCP Init for %d channels\n", count))
-	init_MUTEX_LOCKED(&l->sem);
+	init_mutex_locked(&l->sem);
 	init_timer(&l->timer);
 	l->timer.function = fcp_login_timeout;
 	l->timer.data = (unsigned long)l;
@@ -673,7 +673,7 @@ int fcp_forceoffline(fc_channel *fcchain
 	l.count = count;
 	l.magic = LSOMAGIC;
 	FCND(("FCP Force Offline for %d channels\n", count))
-	init_MUTEX_LOCKED(&l.sem);
+	init_mutex_locked(&l.sem);
 	init_timer(&l.timer);
 	l.timer.function = fcp_login_timeout;
 	l.timer.data = (unsigned long)&l;
@@ -1081,7 +1081,7 @@ static int fc_do_els(fc_channel *fc, uns
 	
 	memset (&l, 0, sizeof(lse));
 	l.magic = LSEMAGIC;
-	init_MUTEX_LOCKED(&l.sem);
+	init_mutex_locked(&l.sem);
 	l.timer.function = fcp_login_timeout;
 	l.timer.data = (unsigned long)&l;
 	l.status = FC_STATUS_TIMED_OUT;
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/adm1021.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/adm1021.c	2005-08-18 00:55:10.000000000 +0200
@@ -284,7 +284,7 @@ static int adm1021_detect(struct i2c_ada
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 	data->type = kind;
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/adm1025.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/adm1025.c	2005-08-18 00:55:10.000000000 +0200
@@ -406,7 +406,7 @@ static int adm1025_detect(struct i2c_ada
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/adm1026.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/adm1026.c	2005-08-18 00:55:10.000000000 +0200
@@ -1542,7 +1542,7 @@ int adm1026_detect(struct i2c_adapter *a
 	/* Fill in the remaining client fields */
 	data->type = kind;
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/adm1031.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/adm1031.c	2005-08-18 00:55:10.000000000 +0200
@@ -778,7 +778,7 @@ static int adm1031_detect(struct i2c_ada
 
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/adm9240.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/adm9240.c	2005-08-18 00:55:10.000000000 +0200
@@ -574,7 +574,7 @@ static int adm9240_detect(struct i2c_ada
 	/* fill in the remaining client fields and attach */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->type = kind;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_free;
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/asb100.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/asb100.c	2005-08-18 00:55:10.000000000 +0200
@@ -741,7 +741,7 @@ static int asb100_detect(struct i2c_adap
 	memset(data, 0, sizeof(struct asb100_data));
 
 	new_client = &data->client;
-	init_MUTEX(&data->lock);
+	init_mutex(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -801,7 +801,7 @@ static int asb100_detect(struct i2c_adap
 	data->type = kind;
 
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/atxp1.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/atxp1.c	2005-08-18 00:55:11.000000000 +0200
@@ -307,7 +307,7 @@ static int atxp1_detect(struct i2c_adapt
 
 	data->valid = 0;
 
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	err = i2c_attach_client(new_client);
 
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/ds1621.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/ds1621.c	2005-08-18 00:55:11.000000000 +0200
@@ -240,7 +240,7 @@ int ds1621_detect(struct i2c_adapter *ad
 	/* Fill in remaining client fields and put it into the global list */
 	strlcpy(new_client->name, "ds1621", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/fscher.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/fscher.c	2005-08-18 00:55:11.000000000 +0200
@@ -332,7 +332,7 @@ static int fscher_detect(struct i2c_adap
 	 * global list */
 	strlcpy(new_client->name, "fscher", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/fscpos.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/fscpos.c	2005-08-18 00:55:11.000000000 +0200
@@ -483,7 +483,7 @@ int fscpos_detect(struct i2c_adapter *ad
 	strlcpy(new_client->name, "fscpos", I2C_NAME_SIZE);
 
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/gl518sm.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/gl518sm.c	2005-08-18 00:55:11.000000000 +0200
@@ -407,7 +407,7 @@ static int gl518_detect(struct i2c_adapt
 	strlcpy(new_client->name, "gl518sm", I2C_NAME_SIZE);
 	data->type = kind;
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/gl520sm.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/gl520sm.c	2005-08-18 00:55:11.000000000 +0200
@@ -561,7 +561,7 @@ static int gl520_detect(struct i2c_adapt
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "gl520sm", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/it87.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/it87.c	2005-08-18 00:55:11.000000000 +0200
@@ -780,7 +780,7 @@ int it87_detect(struct i2c_adapter *adap
 
 	new_client = &data->client;
 	if (is_isa)
-		init_MUTEX(&data->lock);
+		init_mutex(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -827,7 +827,7 @@ int it87_detect(struct i2c_adapter *adap
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->type = kind;
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm63.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm63.c	2005-08-18 00:55:11.000000000 +0200
@@ -427,7 +427,7 @@ static int lm63_detect(struct i2c_adapte
 
 	strlcpy(new_client->name, "lm63", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm75.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm75.c	2005-08-18 00:55:11.000000000 +0200
@@ -198,7 +198,7 @@ static int lm75_detect(struct i2c_adapte
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm77.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm77.c	2005-08-18 00:55:11.000000000 +0200
@@ -307,7 +307,7 @@ static int lm77_detect(struct i2c_adapte
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm78.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm78.c	2005-08-18 00:55:11.000000000 +0200
@@ -536,7 +536,7 @@ int lm78_detect(struct i2c_adapter *adap
 
 	new_client = &data->client;
 	if (is_isa)
-		init_MUTEX(&data->lock);
+		init_mutex(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -589,7 +589,7 @@ int lm78_detect(struct i2c_adapter *adap
 	data->type = kind;
 
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm80.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm80.c	2005-08-18 00:55:11.000000000 +0200
@@ -437,7 +437,7 @@ int lm80_detect(struct i2c_adapter *adap
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm83.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm83.c	2005-08-18 00:55:11.000000000 +0200
@@ -300,7 +300,7 @@ static int lm83_detect(struct i2c_adapte
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm85.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm85.c	2005-08-18 00:55:11.000000000 +0200
@@ -1153,7 +1153,7 @@ int lm85_detect(struct i2c_adapter *adap
 	/* Fill in the remaining client fields */
 	data->type = kind;
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm87.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm87.c	2005-08-18 00:55:11.000000000 +0200
@@ -589,7 +589,7 @@ static int lm87_detect(struct i2c_adapte
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, "lm87", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm90.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm90.c	2005-08-18 00:55:11.000000000 +0200
@@ -490,7 +490,7 @@ static int lm90_detect(struct i2c_adapte
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
 	data->kind = kind;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/lm92.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/lm92.c	2005-08-18 00:55:11.000000000 +0200
@@ -349,7 +349,7 @@ static int lm92_detect(struct i2c_adapte
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the i2c subsystem a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/max1619.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/max1619.c	2005-08-18 00:55:11.000000000 +0200
@@ -265,7 +265,7 @@ static int max1619_detect(struct i2c_ada
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/pc87360.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/pc87360.c	2005-08-18 00:55:11.000000000 +0200
@@ -748,7 +748,7 @@ int pc87360_detect(struct i2c_adapter *a
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	init_MUTEX(&data->lock);
+	init_mutex(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &pc87360_driver;
 	new_client->flags = 0;
@@ -781,7 +781,7 @@ int pc87360_detect(struct i2c_adapter *a
 
 	strcpy(new_client->name, name);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	for (i = 0; i < 3; i++) {
 		if (((data->address[i] = extra_isa[i]))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/sis5595.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/sis5595.c	2005-08-18 00:55:11.000000000 +0200
@@ -541,7 +541,7 @@ int sis5595_detect(struct i2c_adapter *a
 
 	new_client = &data->client;
 	new_client->addr = address;
-	init_MUTEX(&data->lock);
+	init_mutex(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->adapter = adapter;
 	new_client->driver = &sis5595_driver;
@@ -562,7 +562,7 @@ int sis5595_detect(struct i2c_adapter *a
 	strlcpy(new_client->name, "sis5595", I2C_NAME_SIZE);
 
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/smsc47b397.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/smsc47b397.c	2005-08-18 00:55:11.000000000 +0200
@@ -273,14 +273,14 @@ static int smsc47b397_detect(struct i2c_
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = addr;
-	init_MUTEX(&data->lock);
+	init_mutex(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &smsc47b397_driver;
 	new_client->flags = 0;
 
 	strlcpy(new_client->name, "smsc47b397", I2C_NAME_SIZE);
 
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	if ((err = i2c_attach_client(new_client)))
 		goto error_free;
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/smsc47m1.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/smsc47m1.c	2005-08-18 00:55:11.000000000 +0200
@@ -426,13 +426,13 @@ static int smsc47m1_detect(struct i2c_ad
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	init_MUTEX(&data->lock);
+	init_mutex(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &smsc47m1_driver;
 	new_client->flags = 0;
 
 	strlcpy(new_client->name, "smsc47m1", I2C_NAME_SIZE);
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* If no function is properly configured, there's no point in
 	   actually registering the chip. */
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/via686a.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/via686a.c	2005-08-18 00:55:11.000000000 +0200
@@ -652,7 +652,7 @@ static int via686a_detect(struct i2c_ada
 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
 
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/w83627ehf.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/w83627ehf.c	2005-08-18 00:55:11.000000000 +0200
@@ -689,14 +689,14 @@ static int w83627ehf_detect(struct i2c_a
 	client = &data->client;
 	i2c_set_clientdata(client, data);
 	client->addr = address;
-	init_MUTEX(&data->lock);
+	init_mutex(&data->lock);
 	client->adapter = adapter;
 	client->driver = &w83627ehf_driver;
 	client->flags = 0;
 
 	strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the i2c layer a new client has arrived */
 	if ((err = i2c_attach_client(client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/w83627hf.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/w83627hf.c	2005-08-18 00:55:11.000000000 +0200
@@ -1065,7 +1065,7 @@ int w83627hf_detect(struct i2c_adapter *
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	init_MUTEX(&data->lock);
+	init_mutex(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &w83627hf_driver;
 	new_client->flags = 0;
@@ -1085,7 +1085,7 @@ int w83627hf_detect(struct i2c_adapter *
 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
 	data->type = kind;
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/w83781d.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/w83781d.c	2005-08-18 00:55:11.000000000 +0200
@@ -1055,7 +1055,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	init_MUTEX(&data->lock);
+	init_mutex(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &w83781d_driver;
 	new_client->flags = 0;
@@ -1160,7 +1160,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	data->type = kind;
 
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/hwmon/w83l785ts.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/hwmon/w83l785ts.c	2005-08-18 00:55:11.000000000 +0200
@@ -224,7 +224,7 @@ static int w83l785ts_detect(struct i2c_a
 	/* We can fill in the remaining client fields. */
 	strlcpy(new_client->name, "w83l785ts", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Default values in case the first read fails (unlikely). */
 	data->temp_over = data->temp = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/i2c/busses/i2c-amd756-s4882.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/i2c/busses/i2c-amd756-s4882.c	2005-08-18 00:55:11.000000000 +0200
@@ -166,7 +166,7 @@ static int __init amd756_s4882_init(void
 	}
 
 	printk(KERN_INFO "Enabling SMBus multiplexing for Tyan S4882\n");
-	init_MUTEX(&amd756_lock);
+	init_mutex(&amd756_lock);
 
 	/* Define the 5 virtual adapters and algorithms structures */
 	if (!(s4882_adapter = kmalloc(5 * sizeof(struct i2c_adapter),
--- linux-2.6.13-rc6-git9-orig/drivers/i2c/busses/scx200_acb.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/i2c/busses/scx200_acb.c	2005-08-18 00:55:11.000000000 +0200
@@ -460,7 +460,7 @@ static int  __init scx200_acb_create(int
 	adapter->algo = &scx200_acb_algorithm;
 	adapter->class = I2C_CLASS_HWMON;
 
-	init_MUTEX(&iface->sem);
+	init_mutex(&iface->sem);
 
 	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
 	if (request_region(base, 8, description) == 0) {
--- linux-2.6.13-rc6-git9-orig/drivers/i2c/chips/eeprom.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/i2c/chips/eeprom.c	2005-08-18 00:55:11.000000000 +0200
@@ -195,7 +195,7 @@ int eeprom_detect(struct i2c_adapter *ad
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
 	data->valid = 0;
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 	data->nature = UNKNOWN;
 
 	/* Tell the I2C layer a new client has arrived */
--- linux-2.6.13-rc6-git9-orig/drivers/i2c/chips/max6875.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/i2c/chips/max6875.c	2005-08-18 00:55:11.000000000 +0200
@@ -404,7 +404,7 @@ static int max6875_detect(struct i2c_ada
 
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "max6875", I2C_NAME_SIZE);
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Verify that the chip is really what we think it is */
 	if ((max6875_update_slice(new_client, &data->blocks[max6875_eeprom_config], 4) < 0) ||
--- linux-2.6.13-rc6-git9-orig/drivers/i2c/chips/pcf8591.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/i2c/chips/pcf8591.c	2005-08-18 00:55:11.000000000 +0200
@@ -203,7 +203,7 @@ int pcf8591_detect(struct i2c_adapter *a
 	/* Fill in the remaining client fields and put it into the global 
 	   list */
 	strlcpy(new_client->name, "pcf8591", I2C_NAME_SIZE);
-	init_MUTEX(&data->update_lock);
+	init_mutex(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
--- linux-2.6.13-rc6-git9-orig/drivers/i2c/chips/tps65010.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/i2c/chips/tps65010.c	2005-08-18 00:55:11.000000000 +0200
@@ -505,7 +505,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 		return 0;
 
 	memset(tps, 0, sizeof *tps);
-	init_MUTEX(&tps->lock);
+	init_mutex(&tps->lock);
 	INIT_WORK(&tps->work, tps65010_work, tps);
 	tps->irq = -1;
 	tps->client.addr = address;
--- linux-2.6.13-rc6-git9-orig/drivers/i2c/i2c-core.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/i2c/i2c-core.c	2005-08-18 00:55:11.000000000 +0200
@@ -164,8 +164,8 @@ int i2c_add_adapter(struct i2c_adapter *
 	}
 
 	adap->nr =  id & MAX_ID_MASK;
-	init_MUTEX(&adap->bus_lock);
-	init_MUTEX(&adap->clist_lock);
+	init_mutex(&adap->bus_lock);
+	init_mutex(&adap->clist_lock);
 	list_add_tail(&adap->list,&adapters);
 	INIT_LIST_HEAD(&adap->clients);
 
--- linux-2.6.13-rc6-git9-orig/drivers/ieee1394/dv1394.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/ieee1394/dv1394.c	2005-08-18 00:55:11.000000000 +0200
@@ -2269,7 +2269,7 @@ static int dv1394_init(struct ti_ohci *o
 	clear_bit(0, &video->open);
 	spin_lock_init(&video->spinlock);
 	video->dma_running = 0;
-	init_MUTEX(&video->sem);
+	init_mutex(&video->sem);
 	init_waitqueue_head(&video->waitq);
 	video->fasync = NULL;
 
--- linux-2.6.13-rc6-git9-orig/drivers/infiniband/core/ucm.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/infiniband/core/ucm.c	2005-08-18 00:55:11.000000000 +0200
@@ -139,7 +139,7 @@ static struct ib_ucm_context *ib_ucm_ctx
 	ctx->file = file;
 
 	INIT_LIST_HEAD(&ctx->events);
-	init_MUTEX(&ctx->mutex);
+	init_mutex(&ctx->mutex);
 
 	list_add_tail(&ctx->file_list, &file->ctxs);
 
@@ -1289,7 +1289,7 @@ static int ib_ucm_open(struct inode *ino
 	INIT_LIST_HEAD(&file->ctxs);
 	init_waitqueue_head(&file->poll_wait);
 
-	init_MUTEX(&file->mutex);
+	init_mutex(&file->mutex);
 
 	filp->private_data = file;
 	file->filp = filp;
@@ -1364,7 +1364,7 @@ static int __init ib_ucm_init(void)
 	class_device_create(ib_ucm_class, IB_UCM_DEV, NULL, "ucm");
 
 	idr_init(&ctx_id_table);
-	init_MUTEX(&ctx_id_mutex);
+	init_mutex(&ctx_id_mutex);
 
 	return 0;
 err_class:
--- linux-2.6.13-rc6-git9-orig/drivers/infiniband/core/user_mad.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/infiniband/core/user_mad.c	2005-08-18 00:55:11.000000000 +0200
@@ -751,7 +751,7 @@ static int ib_umad_init_port(struct ib_d
 
 	port->ib_dev   = device;
 	port->port_num = port_num;
-	init_MUTEX(&port->sm_sem);
+	init_mutex(&port->sm_sem);
 
 	cdev_init(&port->dev, &umad_fops);
 	port->dev.owner = THIS_MODULE;
--- linux-2.6.13-rc6-git9-orig/drivers/infiniband/hw/mthca/mthca_mcg.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/infiniband/hw/mthca/mthca_mcg.c	2005-08-18 00:55:11.000000000 +0200
@@ -366,7 +366,7 @@ int __devinit mthca_init_mcg_table(struc
 	if (err)
 		return err;
 
-	init_MUTEX(&dev->mcg_table.sem);
+	init_mutex(&dev->mcg_table.sem);
 
 	return 0;
 }
--- linux-2.6.13-rc6-git9-orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-08-18 00:55:11.000000000 +0200
@@ -299,7 +299,7 @@ struct mthca_icm_table *mthca_alloc_icm_
 	table->num_obj  = nobj;
 	table->obj_size = obj_size;
 	table->lowmem   = use_lowmem;
-	init_MUTEX(&table->mutex);
+	init_mutex(&table->mutex);
 
 	for (i = 0; i < num_icm; ++i)
 		table->icm[i] = NULL;
@@ -454,7 +454,7 @@ struct mthca_user_db_table *mthca_init_u
 	if (!db_tab)
 		return ERR_PTR(-ENOMEM);
 
-	init_MUTEX(&db_tab->mutex);
+	init_mutex(&db_tab->mutex);
 	for (i = 0; i < npages; ++i) {
 		db_tab->page[i].refcount = 0;
 		db_tab->page[i].uvirt    = 0;
@@ -620,7 +620,7 @@ int mthca_init_db_tab(struct mthca_dev *
 	if (!dev->db_tab)
 		return -ENOMEM;
 
-	init_MUTEX(&dev->db_tab->mutex);
+	init_mutex(&dev->db_tab->mutex);
 
 	dev->db_tab->npages     = dev->uar_table.uarc_size / 4096;
 	dev->db_tab->max_group1 = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/infiniband/hw/mthca/mthca_provider.c	2005-08-18 00:55:11.000000000 +0200
@@ -1025,7 +1025,7 @@ int mthca_register_device(struct mthca_d
 		dev->ib_dev.post_recv     = mthca_tavor_post_receive;
 	}
 
-	init_MUTEX(&dev->cap_mask_mutex);
+	init_mutex(&dev->cap_mask_mutex);
 
 	ret = ib_register_device(&dev->ib_dev);
 	if (ret)


