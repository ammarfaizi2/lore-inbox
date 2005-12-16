Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVLPXNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVLPXNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVLPXNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:13:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49116 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964838AbVLPXNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:38 -0500
Date: Fri, 16 Dec 2005 23:13:08 GMT
Message-Id: <200512162313.jBGND8jJ019631@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 5/12]: MUTEX: Rename DECLARE_MUTEX for drivers/ dir, N thru Z
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
drivers/ directory, subdirs N through Z.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-NtoZ-2615rc5-2.diff
 drivers/net/irda/irtty-sir.c         |    2 +-
 drivers/net/irda/sir_dongle.c        |    2 +-
 drivers/net/ppp_generic.c            |    2 +-
 drivers/net/wan/dscc4.c              |    2 +-
 drivers/oprofile/event_buffer.c      |    2 +-
 drivers/oprofile/oprof.c             |    2 +-
 drivers/parport/share.c              |    2 +-
 drivers/pci/hotplug/rpadlpar_core.c  |    2 +-
 drivers/pci/hotplug/sgi_hotplug.c    |    2 +-
 drivers/pcmcia/au1000_generic.c      |    2 +-
 drivers/pcmcia/ds.c                  |    2 +-
 drivers/pcmcia/rsrc_nonstatic.c      |    2 +-
 drivers/pcmcia/soc_common.c          |    2 +-
 drivers/pnp/isapnp/core.c            |    2 +-
 drivers/pnp/manager.c                |    2 +-
 drivers/s390/char/raw3270.c          |    4 ++--
 drivers/sbus/char/aurora.c           |    2 +-
 drivers/scsi/aha152x.c               |    2 +-
 drivers/scsi/dpt/dpti_i2o.h          |    2 +-
 drivers/scsi/dpt_i2o.c               |    2 +-
 drivers/scsi/ide-scsi.c              |    2 +-
 drivers/scsi/megaraid/megaraid_sas.c |    2 +-
 drivers/scsi/pluto.c                 |    2 +-
 drivers/scsi/qla2xxx/qla_os.c        |    2 +-
 drivers/scsi/scsi.c                  |    2 +-
 drivers/scsi/scsi_proc.c             |    2 +-
 drivers/scsi/scsi_transport_iscsi.c  |    2 +-
 drivers/scsi/sd.c                    |    2 +-
 drivers/scsi/sr.c                    |    2 +-
 drivers/scsi/st.c                    |    2 +-
 drivers/serial/68328serial.c         |    2 +-
 drivers/serial/8250.c                |    2 +-
 drivers/serial/crisv10.c             |    4 ++--
 drivers/serial/pmac_zilog.c          |    2 +-
 drivers/serial/serial_core.c         |    2 +-
 drivers/serial/serial_txx9.c         |    2 +-
 drivers/telephony/phonedev.c         |    2 +-
 drivers/usb/class/audio.c            |    2 +-
 drivers/usb/class/cdc-acm.c          |    2 +-
 drivers/usb/class/usb-midi.c         |    2 +-
 drivers/usb/class/usblp.c            |    2 +-
 drivers/usb/core/hcd.c               |    2 +-
 drivers/usb/core/hub.c               |    2 +-
 drivers/usb/core/notify.c            |    2 +-
 drivers/usb/input/ati_remote.c       |    2 +-
 drivers/usb/media/sn9c102.h          |    2 +-
 drivers/usb/media/w9968cf.h          |    4 ++--
 drivers/usb/misc/idmouse.c           |    2 +-
 drivers/usb/misc/ldusb.c             |    2 +-
 drivers/usb/misc/legousbtower.c      |    2 +-
 drivers/usb/misc/sisusbvga/sisusb.c  |    2 +-
 drivers/usb/mon/mon_main.c           |    2 +-
 drivers/usb/serial/pl2303.c          |    2 +-
 53 files changed, 56 insertions(+), 56 deletions(-)

diff -uNrp linux-2.6.15-rc5/drivers/net/irda/irtty-sir.c linux-2.6.15-rc5-mutex/drivers/net/irda/irtty-sir.c
--- linux-2.6.15-rc5/drivers/net/irda/irtty-sir.c	2005-08-30 13:56:19.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/net/irda/irtty-sir.c	2005-12-15 17:14:57.000000000 +0000
@@ -354,7 +354,7 @@ static inline void irtty_stop_receiver(s
 /*****************************************************************/
 
 /* serialize ldisc open/close with sir_dev */
-static DECLARE_MUTEX(irtty_sem);
+static DECLARE_SEM_MUTEX(irtty_sem);
 
 /* notifier from sir_dev when irda% device gets opened (ifup) */
 
diff -uNrp linux-2.6.15-rc5/drivers/net/irda/sir_dongle.c linux-2.6.15-rc5-mutex/drivers/net/irda/sir_dongle.c
--- linux-2.6.15-rc5/drivers/net/irda/sir_dongle.c	2004-06-18 13:41:36.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/net/irda/sir_dongle.c	2005-12-15 17:14:57.000000000 +0000
@@ -28,7 +28,7 @@
  */
 
 static LIST_HEAD(dongle_list);			/* list of registered dongle drivers */
-static DECLARE_MUTEX(dongle_list_lock);		/* protects the list */
+static DECLARE_SEM_MUTEX(dongle_list_lock);		/* protects the list */
 
 int irda_register_dongle(struct dongle_driver *new)
 {
diff -uNrp linux-2.6.15-rc5/drivers/net/ppp_generic.c linux-2.6.15-rc5-mutex/drivers/net/ppp_generic.c
--- linux-2.6.15-rc5/drivers/net/ppp_generic.c	2005-12-08 16:23:43.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/ppp_generic.c	2005-12-15 17:14:57.000000000 +0000
@@ -202,7 +202,7 @@ static void cardmap_destroy(struct cardm
  * It also ensures that finding a ppp unit in the all_ppp_units map
  * and updating its file.refcnt field is atomic.
  */
-static DECLARE_MUTEX(all_ppp_sem);
+static DECLARE_SEM_MUTEX(all_ppp_sem);
 static struct cardmap *all_ppp_units;
 static atomic_t ppp_unit_count = ATOMIC_INIT(0);
 
diff -uNrp linux-2.6.15-rc5/drivers/net/wan/dscc4.c linux-2.6.15-rc5-mutex/drivers/net/wan/dscc4.c
--- linux-2.6.15-rc5/drivers/net/wan/dscc4.c	2005-12-08 16:23:43.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/net/wan/dscc4.c	2005-12-15 17:14:57.000000000 +0000
@@ -112,7 +112,7 @@ static int debug;
 static int quartz;
 
 #ifdef CONFIG_DSCC4_PCI_RST
-static DECLARE_MUTEX(dscc4_sem);
+static DECLARE_SEM_MUTEX(dscc4_sem);
 static u32 dscc4_pci_config_store[16];
 #endif
 
diff -uNrp linux-2.6.15-rc5/drivers/oprofile/event_buffer.c linux-2.6.15-rc5-mutex/drivers/oprofile/event_buffer.c
--- linux-2.6.15-rc5/drivers/oprofile/event_buffer.c	2005-06-22 13:51:55.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/oprofile/event_buffer.c	2005-12-15 17:14:57.000000000 +0000
@@ -23,7 +23,7 @@
 #include "event_buffer.h"
 #include "oprofile_stats.h"
 
-DECLARE_MUTEX(buffer_sem);
+DECLARE_SEM_MUTEX(buffer_sem);
  
 static unsigned long buffer_opened;
 static DECLARE_WAIT_QUEUE_HEAD(buffer_wait);
diff -uNrp linux-2.6.15-rc5/drivers/oprofile/oprof.c linux-2.6.15-rc5-mutex/drivers/oprofile/oprof.c
--- linux-2.6.15-rc5/drivers/oprofile/oprof.c	2005-03-02 12:08:20.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/oprofile/oprof.c	2005-12-15 17:14:57.000000000 +0000
@@ -25,7 +25,7 @@ struct oprofile_operations oprofile_ops;
 unsigned long oprofile_started;
 unsigned long backtrace_depth;
 static unsigned long is_setup;
-static DECLARE_MUTEX(start_sem);
+static DECLARE_SEM_MUTEX(start_sem);
 
 /* timer
    0 - use performance monitoring hardware if available
diff -uNrp linux-2.6.15-rc5/drivers/parport/share.c linux-2.6.15-rc5-mutex/drivers/parport/share.c
--- linux-2.6.15-rc5/drivers/parport/share.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/parport/share.c	2005-12-15 17:14:57.000000000 +0000
@@ -50,7 +50,7 @@ static DEFINE_SPINLOCK(full_list_lock);
 
 static LIST_HEAD(drivers);
 
-static DECLARE_MUTEX(registration_lock);
+static DECLARE_SEM_MUTEX(registration_lock);
 
 /* What you can do to a port that's gone away.. */
 static void dead_write_lines (struct parport *p, unsigned char b){}
diff -uNrp linux-2.6.15-rc5/drivers/pci/hotplug/rpadlpar_core.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/rpadlpar_core.c
--- linux-2.6.15-rc5/drivers/pci/hotplug/rpadlpar_core.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/rpadlpar_core.c	2005-12-15 17:14:57.000000000 +0000
@@ -27,7 +27,7 @@
 #include "rpaphp.h"
 #include "rpadlpar.h"
 
-static DECLARE_MUTEX(rpadlpar_sem);
+static DECLARE_SEM_MUTEX(rpadlpar_sem);
 
 #define DLPAR_MODULE_NAME "rpadlpar_io"
 
diff -uNrp linux-2.6.15-rc5/drivers/pci/hotplug/sgi_hotplug.c linux-2.6.15-rc5-mutex/drivers/pci/hotplug/sgi_hotplug.c
--- linux-2.6.15-rc5/drivers/pci/hotplug/sgi_hotplug.c	2005-11-01 13:19:12.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pci/hotplug/sgi_hotplug.c	2005-12-15 17:14:57.000000000 +0000
@@ -81,7 +81,7 @@ static struct hotplug_slot_ops sn_hotplu
 	.get_power_status       = get_power_status,
 };
 
-static DECLARE_MUTEX(sn_hotplug_sem);
+static DECLARE_SEM_MUTEX(sn_hotplug_sem);
 
 static ssize_t path_show (struct hotplug_slot *bss_hotplug_slot,
 	       		  char *buf)
diff -uNrp linux-2.6.15-rc5/drivers/pcmcia/au1000_generic.c linux-2.6.15-rc5-mutex/drivers/pcmcia/au1000_generic.c
--- linux-2.6.15-rc5/drivers/pcmcia/au1000_generic.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pcmcia/au1000_generic.c	2005-12-15 17:14:57.000000000 +0000
@@ -72,7 +72,7 @@ extern struct au1000_pcmcia_socket au100
 u32 *pcmcia_base_vaddrs[2];
 extern const unsigned long mips_io_port_base;
 
-DECLARE_MUTEX(pcmcia_sockets_lock);
+DECLARE_SEM_MUTEX(pcmcia_sockets_lock);
 
 static int (*au1x00_pcmcia_hw_init[])(struct device *dev) = {
 	au1x_board_init,
diff -uNrp linux-2.6.15-rc5/drivers/pcmcia/ds.c linux-2.6.15-rc5-mutex/drivers/pcmcia/ds.c
--- linux-2.6.15-rc5/drivers/pcmcia/ds.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pcmcia/ds.c	2005-12-15 17:14:57.000000000 +0000
@@ -499,7 +499,7 @@ static int pcmcia_device_query(struct pc
  * won't work, this doesn't matter much at the moment: the driver core doesn't
  * support it either.
  */
-static DECLARE_MUTEX(device_add_lock);
+static DECLARE_SEM_MUTEX(device_add_lock);
 
 struct pcmcia_device * pcmcia_device_add(struct pcmcia_socket *s, unsigned int function)
 {
diff -uNrp linux-2.6.15-rc5/drivers/pcmcia/rsrc_nonstatic.c linux-2.6.15-rc5-mutex/drivers/pcmcia/rsrc_nonstatic.c
--- linux-2.6.15-rc5/drivers/pcmcia/rsrc_nonstatic.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pcmcia/rsrc_nonstatic.c	2005-12-15 17:14:57.000000000 +0000
@@ -61,7 +61,7 @@ struct socket_data {
 	unsigned int			rsrc_mem_probe;
 };
 
-static DECLARE_MUTEX(rsrc_sem);
+static DECLARE_SEM_MUTEX(rsrc_sem);
 #define MEM_PROBE_LOW	(1 << 0)
 #define MEM_PROBE_HIGH	(1 << 1)
 
diff -uNrp linux-2.6.15-rc5/drivers/pcmcia/soc_common.c linux-2.6.15-rc5-mutex/drivers/pcmcia/soc_common.c
--- linux-2.6.15-rc5/drivers/pcmcia/soc_common.c	2005-11-01 13:19:12.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pcmcia/soc_common.c	2005-12-15 17:14:57.000000000 +0000
@@ -599,7 +599,7 @@ EXPORT_SYMBOL(soc_pcmcia_enable_irqs);
 
 
 LIST_HEAD(soc_pcmcia_sockets);
-DECLARE_MUTEX(soc_pcmcia_sockets_lock);
+DECLARE_SEM_MUTEX(soc_pcmcia_sockets_lock);
 
 static const char *skt_names[] = {
 	"PCMCIA socket 0",
diff -uNrp linux-2.6.15-rc5/drivers/pnp/isapnp/core.c linux-2.6.15-rc5-mutex/drivers/pnp/isapnp/core.c
--- linux-2.6.15-rc5/drivers/pnp/isapnp/core.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pnp/isapnp/core.c	2005-12-15 17:14:57.000000000 +0000
@@ -92,7 +92,7 @@ MODULE_LICENSE("GPL");
 #define _LTAG_FIXEDMEM32RANGE	0x86
 
 static unsigned char isapnp_checksum_value;
-static DECLARE_MUTEX(isapnp_cfg_mutex);
+static DECLARE_SEM_MUTEX(isapnp_cfg_mutex);
 static int isapnp_detected;
 static int isapnp_csn_count;
 
diff -uNrp linux-2.6.15-rc5/drivers/pnp/manager.c linux-2.6.15-rc5-mutex/drivers/pnp/manager.c
--- linux-2.6.15-rc5/drivers/pnp/manager.c	2005-12-08 16:23:44.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/pnp/manager.c	2005-12-15 17:14:57.000000000 +0000
@@ -16,7 +16,7 @@
 #include <linux/bitmap.h>
 #include "base.h"
 
-DECLARE_MUTEX(pnp_res_mutex);
+DECLARE_SEM_MUTEX(pnp_res_mutex);
 
 static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
diff -uNrp linux-2.6.15-rc5/drivers/s390/char/raw3270.c linux-2.6.15-rc5-mutex/drivers/s390/char/raw3270.c
--- linux-2.6.15-rc5/drivers/s390/char/raw3270.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/s390/char/raw3270.c	2005-12-15 17:14:57.000000000 +0000
@@ -59,7 +59,7 @@ struct raw3270 {
 #define RAW3270_FLAGS_CONSOLE	8	/* Device is the console. */
 
 /* Semaphore to protect global data of raw3270 (devices, views, etc). */
-static DECLARE_MUTEX(raw3270_sem);
+static DECLARE_SEM_MUTEX(raw3270_sem);
 
 /* List of 3270 devices. */
 static struct list_head raw3270_devices = LIST_HEAD_INIT(raw3270_devices);
@@ -487,7 +487,7 @@ struct raw3270_ua {	/* Query Reply struc
 static unsigned char raw3270_init_data[256];
 static struct raw3270_request raw3270_init_request;
 static struct diag210 raw3270_init_diag210;
-static DECLARE_MUTEX(raw3270_init_sem);
+static DECLARE_SEM_MUTEX(raw3270_init_sem);
 
 static int
 raw3270_init_irq(struct raw3270_view *view, struct raw3270_request *rq,
diff -uNrp linux-2.6.15-rc5/drivers/sbus/char/aurora.c linux-2.6.15-rc5-mutex/drivers/sbus/char/aurora.c
--- linux-2.6.15-rc5/drivers/sbus/char/aurora.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/sbus/char/aurora.c	2005-12-15 17:14:57.000000000 +0000
@@ -92,7 +92,7 @@ static struct Aurora_port aurora_port[AU
 
 /* no longer used. static struct Aurora_board * IRQ_to_board[16] = { NULL, } ;*/
 static unsigned char * tmp_buf = NULL;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 DECLARE_TASK_QUEUE(tq_aurora);
 
diff -uNrp linux-2.6.15-rc5/drivers/scsi/aha152x.c linux-2.6.15-rc5-mutex/drivers/scsi/aha152x.c
--- linux-2.6.15-rc5/drivers/scsi/aha152x.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/aha152x.c	2005-12-15 17:14:57.000000000 +0000
@@ -1161,7 +1161,7 @@ static void timer_expired(unsigned long 
 static int aha152x_device_reset(Scsi_Cmnd * SCpnt)
 {
 	struct Scsi_Host *shpnt = SCpnt->device->host;
-	DECLARE_MUTEX_LOCKED(sem);
+	DECLARE_SEM_MUTEX_LOCKED(sem);
 	struct timer_list timer;
 	int ret, issued, disconnected;
 	unsigned long flags;
diff -uNrp linux-2.6.15-rc5/drivers/scsi/dpt/dpti_i2o.h linux-2.6.15-rc5-mutex/drivers/scsi/dpt/dpti_i2o.h
--- linux-2.6.15-rc5/drivers/scsi/dpt/dpti_i2o.h	2004-06-18 13:41:50.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/scsi/dpt/dpti_i2o.h	2005-12-15 17:14:57.000000000 +0000
@@ -50,7 +50,7 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
 
-#define DECLARE_MUTEX(name) struct semaphore name=MUTEX
+#define DECLARE_SEM_MUTEX(name) struct semaphore name=MUTEX
 
 typedef struct wait_queue *adpt_wait_queue_head_t;
 #define ADPT_DECLARE_WAIT_QUEUE_HEAD(wait) adpt_wait_queue_head_t wait = NULL
diff -uNrp linux-2.6.15-rc5/drivers/scsi/dpt_i2o.c linux-2.6.15-rc5-mutex/drivers/scsi/dpt_i2o.c
--- linux-2.6.15-rc5/drivers/scsi/dpt_i2o.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/dpt_i2o.c	2005-12-15 17:14:57.000000000 +0000
@@ -106,7 +106,7 @@ static dpt_sig_S DPTI_sig = {
  *============================================================================
  */
 
-static DECLARE_MUTEX(adpt_configuration_lock);
+static DECLARE_SEM_MUTEX(adpt_configuration_lock);
 
 static struct i2o_sys_tbl *sys_tbl = NULL;
 static int sys_tbl_ind = 0;
diff -uNrp linux-2.6.15-rc5/drivers/scsi/ide-scsi.c linux-2.6.15-rc5-mutex/drivers/scsi/ide-scsi.c
--- linux-2.6.15-rc5/drivers/scsi/ide-scsi.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/ide-scsi.c	2005-12-15 17:14:57.000000000 +0000
@@ -109,7 +109,7 @@ typedef struct ide_scsi_obj {
 	unsigned long log;			/* log flags */
 } idescsi_scsi_t;
 
-static DECLARE_MUTEX(idescsi_ref_sem);
+static DECLARE_SEM_MUTEX(idescsi_ref_sem);
 
 #define ide_scsi_g(disk) \
 	container_of((disk)->private_data, struct ide_scsi_obj, driver)
diff -uNrp linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_sas.c linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_sas.c	2005-12-08 16:23:45.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/megaraid/megaraid_sas.c	2005-12-15 17:14:57.000000000 +0000
@@ -72,7 +72,7 @@ MODULE_DEVICE_TABLE(pci, megasas_pci_tab
 static int megasas_mgmt_majorno;
 static struct megasas_mgmt_info megasas_mgmt_info;
 static struct fasync_struct *megasas_async_queue;
-static DECLARE_MUTEX(megasas_async_queue_mutex);
+static DECLARE_SEM_MUTEX(megasas_async_queue_mutex);
 
 /**
  * megasas_get_cmd -	Get a command from the free pool
diff -uNrp linux-2.6.15-rc5/drivers/scsi/pluto.c linux-2.6.15-rc5-mutex/drivers/scsi/pluto.c
--- linux-2.6.15-rc5/drivers/scsi/pluto.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/pluto.c	2005-12-15 17:14:57.000000000 +0000
@@ -48,7 +48,7 @@ static struct ctrl_inquiry {
 } *fcs __initdata;
 static int fcscount __initdata = 0;
 static atomic_t fcss __initdata = ATOMIC_INIT(0);
-DECLARE_MUTEX_LOCKED(fc_sem);
+DECLARE_SEM_MUTEX_LOCKED(fc_sem);
 
 static int pluto_encode_addr(Scsi_Cmnd *SCpnt, u16 *addr, fc_channel *fc, fcp_cmnd *fcmd);
 
diff -uNrp linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_os.c linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_os.c
--- linux-2.6.15-rc5/drivers/scsi/qla2xxx/qla_os.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/qla2xxx/qla_os.c	2005-12-15 17:14:57.000000000 +0000
@@ -2082,7 +2082,7 @@ qla2x00_free_sp_pool( scsi_qla_host_t *h
 static int
 qla2x00_do_dpc(void *data)
 {
-	DECLARE_MUTEX_LOCKED(sem);
+	DECLARE_SEM_MUTEX_LOCKED(sem);
 	scsi_qla_host_t *ha;
 	fc_port_t	*fcport;
 	uint8_t		status;
diff -uNrp linux-2.6.15-rc5/drivers/scsi/scsi.c linux-2.6.15-rc5-mutex/drivers/scsi/scsi.c
--- linux-2.6.15-rc5/drivers/scsi/scsi.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/scsi.c	2005-12-15 17:14:57.000000000 +0000
@@ -210,7 +210,7 @@ static struct scsi_host_cmd_pool scsi_cm
 	.gfp_mask	= __GFP_DMA,
 };
 
-static DECLARE_MUTEX(host_cmd_pool_mutex);
+static DECLARE_SEM_MUTEX(host_cmd_pool_mutex);
 
 static struct scsi_cmnd *__scsi_get_command(struct Scsi_Host *shost,
 					    gfp_t gfp_mask)
diff -uNrp linux-2.6.15-rc5/drivers/scsi/scsi_proc.c linux-2.6.15-rc5-mutex/drivers/scsi/scsi_proc.c
--- linux-2.6.15-rc5/drivers/scsi/scsi_proc.c	2004-09-16 12:06:08.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/scsi/scsi_proc.c	2005-12-15 17:14:57.000000000 +0000
@@ -41,7 +41,7 @@
 static struct proc_dir_entry *proc_scsi;
 
 /* Protect sht->present and sht->proc_dir */
-static DECLARE_MUTEX(global_host_template_sem);
+static DECLARE_SEM_MUTEX(global_host_template_sem);
 
 static int proc_scsi_read(char *buffer, char **start, off_t offset,
 			  int length, int *eof, void *data)
diff -uNrp linux-2.6.15-rc5/drivers/scsi/scsi_transport_iscsi.c linux-2.6.15-rc5-mutex/drivers/scsi/scsi_transport_iscsi.c
--- linux-2.6.15-rc5/drivers/scsi/scsi_transport_iscsi.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/scsi_transport_iscsi.c	2005-12-15 17:14:57.000000000 +0000
@@ -145,7 +145,7 @@ static DECLARE_TRANSPORT_CLASS(iscsi_con
 
 static struct sock *nls;
 static int daemon_pid;
-static DECLARE_MUTEX(rx_queue_sema);
+static DECLARE_SEM_MUTEX(rx_queue_sema);
 
 struct mempool_zone {
 	mempool_t *pool;
diff -uNrp linux-2.6.15-rc5/drivers/scsi/sd.c linux-2.6.15-rc5-mutex/drivers/scsi/sd.c
--- linux-2.6.15-rc5/drivers/scsi/sd.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/sd.c	2005-12-15 17:14:57.000000000 +0000
@@ -110,7 +110,7 @@ static DEFINE_SPINLOCK(sd_index_lock);
 /* This semaphore is used to mediate the 0->1 reference get in the
  * face of object destruction (i.e. we can't allow a get on an
  * object after last put) */
-static DECLARE_MUTEX(sd_ref_sem);
+static DECLARE_SEM_MUTEX(sd_ref_sem);
 
 static int sd_revalidate_disk(struct gendisk *disk);
 static void sd_rw_intr(struct scsi_cmnd * SCpnt);
diff -uNrp linux-2.6.15-rc5/drivers/scsi/sr.c linux-2.6.15-rc5-mutex/drivers/scsi/sr.c
--- linux-2.6.15-rc5/drivers/scsi/sr.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/sr.c	2005-12-15 17:14:57.000000000 +0000
@@ -90,7 +90,7 @@ static DEFINE_SPINLOCK(sr_index_lock);
 /* This semaphore is used to mediate the 0->1 reference get in the
  * face of object destruction (i.e. we can't allow a get on an
  * object after last put) */
-static DECLARE_MUTEX(sr_ref_sem);
+static DECLARE_SEM_MUTEX(sr_ref_sem);
 
 static int sr_open(struct cdrom_device_info *, int);
 static void sr_release(struct cdrom_device_info *);
diff -uNrp linux-2.6.15-rc5/drivers/scsi/st.c linux-2.6.15-rc5-mutex/drivers/scsi/st.c
--- linux-2.6.15-rc5/drivers/scsi/st.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/scsi/st.c	2005-12-15 17:14:57.000000000 +0000
@@ -223,7 +223,7 @@ static void scsi_tape_release(struct kre
 
 #define to_scsi_tape(obj) container_of(obj, struct scsi_tape, kref)
 
-static DECLARE_MUTEX(st_ref_sem);
+static DECLARE_SEM_MUTEX(st_ref_sem);
 
 
 #include "osst_detect.h"
diff -uNrp linux-2.6.15-rc5/drivers/serial/68328serial.c linux-2.6.15-rc5-mutex/drivers/serial/68328serial.c
--- linux-2.6.15-rc5/drivers/serial/68328serial.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/68328serial.c	2005-12-15 17:14:57.000000000 +0000
@@ -143,7 +143,7 @@ static int m68328_console_cbaud   = DEFA
  * memory if large numbers of serial ports are open.
  */
 static unsigned char tmp_buf[SERIAL_XMIT_SIZE]; /* This is cheating */
-DECLARE_MUTEX(tmp_buf_sem);
+DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 static inline int serial_paranoia_check(struct m68k_serial *info,
 					char *name, const char *routine)
diff -uNrp linux-2.6.15-rc5/drivers/serial/8250.c linux-2.6.15-rc5-mutex/drivers/serial/8250.c
--- linux-2.6.15-rc5/drivers/serial/8250.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/8250.c	2005-12-15 17:14:57.000000000 +0000
@@ -2480,7 +2480,7 @@ static struct platform_device *serial825
  * 16x50 serial ports to be configured at run-time, to support PCMCIA
  * modems and PCI multiport cards.
  */
-static DECLARE_MUTEX(serial_sem);
+static DECLARE_SEM_MUTEX(serial_sem);
 
 static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *port)
 {
diff -uNrp linux-2.6.15-rc5/drivers/serial/crisv10.c linux-2.6.15-rc5-mutex/drivers/serial/crisv10.c
--- linux-2.6.15-rc5/drivers/serial/crisv10.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/crisv10.c	2005-12-15 17:14:57.000000000 +0000
@@ -1315,8 +1315,8 @@ static const struct control_pins e100_mo
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf;
-#ifdef DECLARE_MUTEX
-static DECLARE_MUTEX(tmp_buf_sem);
+#ifdef DECLARE_SEM_MUTEX
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 #else
 static struct semaphore tmp_buf_sem = MUTEX;
 #endif
diff -uNrp linux-2.6.15-rc5/drivers/serial/pmac_zilog.c linux-2.6.15-rc5-mutex/drivers/serial/pmac_zilog.c
--- linux-2.6.15-rc5/drivers/serial/pmac_zilog.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/pmac_zilog.c	2005-12-15 17:14:57.000000000 +0000
@@ -96,7 +96,7 @@ MODULE_LICENSE("GPL");
  */
 static struct uart_pmac_port	pmz_ports[MAX_ZS_PORTS];
 static int			pmz_ports_count;
-static DECLARE_MUTEX(pmz_irq_sem);
+static DECLARE_SEM_MUTEX(pmz_irq_sem);
 
 static struct uart_driver pmz_uart_reg = {
 	.owner		=	THIS_MODULE,
diff -uNrp linux-2.6.15-rc5/drivers/serial/serial_core.c linux-2.6.15-rc5-mutex/drivers/serial/serial_core.c
--- linux-2.6.15-rc5/drivers/serial/serial_core.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/serial_core.c	2005-12-15 17:14:57.000000000 +0000
@@ -47,7 +47,7 @@
 /*
  * This is used to lock changes in serial line configuration.
  */
-static DECLARE_MUTEX(port_sem);
+static DECLARE_SEM_MUTEX(port_sem);
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
diff -uNrp linux-2.6.15-rc5/drivers/serial/serial_txx9.c linux-2.6.15-rc5-mutex/drivers/serial/serial_txx9.c
--- linux-2.6.15-rc5/drivers/serial/serial_txx9.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/serial/serial_txx9.c	2005-12-15 17:14:57.000000000 +0000
@@ -1029,7 +1029,7 @@ static void serial_txx9_resume_port(int 
 	uart_resume_port(&serial_txx9_reg, &serial_txx9_ports[line].port);
 }
 
-static DECLARE_MUTEX(serial_txx9_sem);
+static DECLARE_SEM_MUTEX(serial_txx9_sem);
 
 /**
  *	serial_txx9_register_port - register a serial port
diff -uNrp linux-2.6.15-rc5/drivers/telephony/phonedev.c linux-2.6.15-rc5-mutex/drivers/telephony/phonedev.c
--- linux-2.6.15-rc5/drivers/telephony/phonedev.c	2004-09-16 12:06:09.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/telephony/phonedev.c	2005-12-15 17:14:57.000000000 +0000
@@ -37,7 +37,7 @@
  */
 
 static struct phone_device *phone_device[PHONE_NUM_DEVICES];
-static DECLARE_MUTEX(phone_lock);
+static DECLARE_SEM_MUTEX(phone_lock);
 
 /*
  *    Open a phone device.
diff -uNrp linux-2.6.15-rc5/drivers/usb/class/audio.c linux-2.6.15-rc5-mutex/drivers/usb/class/audio.c
--- linux-2.6.15-rc5/drivers/usb/class/audio.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/class/audio.c	2005-12-15 17:14:57.000000000 +0000
@@ -218,7 +218,7 @@
  * Linked list of all audio devices...
  */
 static struct list_head audiodevs = LIST_HEAD_INIT(audiodevs);
-static DECLARE_MUTEX(open_sem);
+static DECLARE_SEM_MUTEX(open_sem);
 
 /*
  * wait queue for processes wanting to open an USB audio device
diff -uNrp linux-2.6.15-rc5/drivers/usb/class/cdc-acm.c linux-2.6.15-rc5-mutex/drivers/usb/class/cdc-acm.c
--- linux-2.6.15-rc5/drivers/usb/class/cdc-acm.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/class/cdc-acm.c	2005-12-15 17:14:57.000000000 +0000
@@ -77,7 +77,7 @@ static struct usb_driver acm_driver;
 static struct tty_driver *acm_tty_driver;
 static struct acm *acm_table[ACM_TTY_MINORS];
 
-static DECLARE_MUTEX(open_sem);
+static DECLARE_SEM_MUTEX(open_sem);
 
 #define ACM_READY(acm)	(acm && acm->dev && acm->used)
 
diff -uNrp linux-2.6.15-rc5/drivers/usb/class/usb-midi.c linux-2.6.15-rc5-mutex/drivers/usb/class/usb-midi.c
--- linux-2.6.15-rc5/drivers/usb/class/usb-midi.c	2005-06-22 13:52:04.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/class/usb-midi.c	2005-12-15 17:14:57.000000000 +0000
@@ -296,7 +296,7 @@ static int cin_to_len[] = {
 
 static struct list_head mididevs = LIST_HEAD_INIT(mididevs);
 
-static DECLARE_MUTEX(open_sem);
+static DECLARE_SEM_MUTEX(open_sem);
 static DECLARE_WAIT_QUEUE_HEAD(open_wait);
 
 
diff -uNrp linux-2.6.15-rc5/drivers/usb/class/usblp.c linux-2.6.15-rc5-mutex/drivers/usb/class/usblp.c
--- linux-2.6.15-rc5/drivers/usb/class/usblp.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/class/usblp.c	2005-12-15 17:14:57.000000000 +0000
@@ -222,7 +222,7 @@ static int usblp_cache_device_id_string(
 
 /* forward reference to make our lives easier */
 static struct usb_driver usblp_driver;
-static DECLARE_MUTEX(usblp_sem);	/* locks the existence of usblp's */
+static DECLARE_SEM_MUTEX(usblp_sem);	/* locks the existence of usblp's */
 
 /*
  * Functions for usblp control messages.
diff -uNrp linux-2.6.15-rc5/drivers/usb/core/hcd.c linux-2.6.15-rc5-mutex/drivers/usb/core/hcd.c
--- linux-2.6.15-rc5/drivers/usb/core/hcd.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/core/hcd.c	2005-12-15 17:14:57.000000000 +0000
@@ -93,7 +93,7 @@ struct usb_busmap {
 static struct usb_busmap busmap;
 
 /* used when updating list of hcds */
-DECLARE_MUTEX (usb_bus_list_lock);	/* exported only for usbfs */
+DECLARE_SEM_MUTEX (usb_bus_list_lock);	/* exported only for usbfs */
 EXPORT_SYMBOL_GPL (usb_bus_list_lock);
 
 /* used for controlling access to virtual root hubs */
diff -uNrp linux-2.6.15-rc5/drivers/usb/core/hub.c linux-2.6.15-rc5-mutex/drivers/usb/core/hub.c
--- linux-2.6.15-rc5/drivers/usb/core/hub.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/core/hub.c	2005-12-15 17:14:57.000000000 +0000
@@ -2107,7 +2107,7 @@ static int
 hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port1,
 		int retry_counter)
 {
-	static DECLARE_MUTEX(usb_address0_sem);
+	static DECLARE_SEM_MUTEX(usb_address0_sem);
 
 	struct usb_device	*hdev = hub->hdev;
 	int			i, j, retval;
diff -uNrp linux-2.6.15-rc5/drivers/usb/core/notify.c linux-2.6.15-rc5-mutex/drivers/usb/core/notify.c
--- linux-2.6.15-rc5/drivers/usb/core/notify.c	2005-12-08 16:23:46.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/core/notify.c	2005-12-15 17:14:57.000000000 +0000
@@ -17,7 +17,7 @@
 
 
 static struct notifier_block *usb_notifier_list;
-static DECLARE_MUTEX(usb_notifier_lock);
+static DECLARE_SEM_MUTEX(usb_notifier_lock);
 
 static void usb_notifier_chain_register(struct notifier_block **list,
 					struct notifier_block *n)
diff -uNrp linux-2.6.15-rc5/drivers/usb/input/ati_remote.c linux-2.6.15-rc5-mutex/drivers/usb/input/ati_remote.c
--- linux-2.6.15-rc5/drivers/usb/input/ati_remote.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/input/ati_remote.c	2005-12-15 17:14:57.000000000 +0000
@@ -158,7 +158,7 @@ static char accel[] = { 1, 2, 4, 6, 9, 1
  */
 #define FILTER_TIME (HZ / 20)
 
-static DECLARE_MUTEX(disconnect_sem);
+static DECLARE_SEM_MUTEX(disconnect_sem);
 
 struct ati_remote {
 	struct input_dev *idev;
diff -uNrp linux-2.6.15-rc5/drivers/usb/media/sn9c102.h linux-2.6.15-rc5-mutex/drivers/usb/media/sn9c102.h
--- linux-2.6.15-rc5/drivers/usb/media/sn9c102.h	2005-08-30 13:56:27.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/sn9c102.h	2005-12-15 17:14:57.000000000 +0000
@@ -114,7 +114,7 @@ struct sn9c102_module_param {
 	u8 force_munmap;
 };
 
-static DECLARE_MUTEX(sn9c102_sysfs_lock);
+static DECLARE_SEM_MUTEX(sn9c102_sysfs_lock);
 static DECLARE_RWSEM(sn9c102_disconnect);
 
 struct sn9c102_device {
diff -uNrp linux-2.6.15-rc5/drivers/usb/media/w9968cf.h linux-2.6.15-rc5-mutex/drivers/usb/media/w9968cf.h
--- linux-2.6.15-rc5/drivers/usb/media/w9968cf.h	2005-06-22 13:52:05.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/usb/media/w9968cf.h	2005-12-15 17:14:57.000000000 +0000
@@ -195,11 +195,11 @@ enum w9968cf_vpp_flag {
 };
 
 static struct w9968cf_vpp_t* w9968cf_vpp;
-static DECLARE_MUTEX(w9968cf_vppmod_lock);
+static DECLARE_SEM_MUTEX(w9968cf_vppmod_lock);
 static DECLARE_WAIT_QUEUE_HEAD(w9968cf_vppmod_wait);
 
 static LIST_HEAD(w9968cf_dev_list); /* head of V4L registered cameras list */
-static DECLARE_MUTEX(w9968cf_devlist_sem); /* semaphore for list traversal */
+static DECLARE_SEM_MUTEX(w9968cf_devlist_sem); /* semaphore for list traversal */
 
 static DECLARE_RWSEM(w9968cf_disconnect); /* prevent races with open() */
 
diff -uNrp linux-2.6.15-rc5/drivers/usb/misc/idmouse.c linux-2.6.15-rc5-mutex/drivers/usb/misc/idmouse.c
--- linux-2.6.15-rc5/drivers/usb/misc/idmouse.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/idmouse.c	2005-12-15 17:14:57.000000000 +0000
@@ -122,7 +122,7 @@ static struct usb_driver idmouse_driver 
 };
 
 /* prevent races between open() and disconnect() */
-static DECLARE_MUTEX(disconnect_sem);
+static DECLARE_SEM_MUTEX(disconnect_sem);
 
 static int idmouse_create_image(struct usb_idmouse *dev)
 {
diff -uNrp linux-2.6.15-rc5/drivers/usb/misc/ldusb.c linux-2.6.15-rc5-mutex/drivers/usb/misc/ldusb.c
--- linux-2.6.15-rc5/drivers/usb/misc/ldusb.c	2005-11-01 13:19:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/ldusb.c	2005-12-15 17:14:57.000000000 +0000
@@ -165,7 +165,7 @@ struct ld_usb {
 };
 
 /* prevent races between open() and disconnect() */
-static DECLARE_MUTEX(disconnect_sem);
+static DECLARE_SEM_MUTEX(disconnect_sem);
 
 static struct usb_driver ld_usb_driver;
 
diff -uNrp linux-2.6.15-rc5/drivers/usb/misc/legousbtower.c linux-2.6.15-rc5-mutex/drivers/usb/misc/legousbtower.c
--- linux-2.6.15-rc5/drivers/usb/misc/legousbtower.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/legousbtower.c	2005-12-15 17:14:57.000000000 +0000
@@ -256,7 +256,7 @@ static void tower_disconnect	(struct usb
 
 
 /* prevent races between open() and disconnect */
-static DECLARE_MUTEX (disconnect_sem);
+static DECLARE_SEM_MUTEX (disconnect_sem);
 
 /* file operations needed when we register this driver */
 static struct file_operations tower_fops = {
diff -uNrp linux-2.6.15-rc5/drivers/usb/misc/sisusbvga/sisusb.c linux-2.6.15-rc5-mutex/drivers/usb/misc/sisusbvga/sisusb.c
--- linux-2.6.15-rc5/drivers/usb/misc/sisusbvga/sisusb.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/misc/sisusbvga/sisusb.c	2005-12-15 17:14:57.000000000 +0000
@@ -102,7 +102,7 @@ MODULE_PARM_DESC(last, "Number of last c
 
 static struct usb_driver sisusb_driver;
 
-DECLARE_MUTEX(disconnect_sem);
+DECLARE_SEM_MUTEX(disconnect_sem);
 
 static void
 sisusb_free_buffers(struct sisusb_usb_data *sisusb)
diff -uNrp linux-2.6.15-rc5/drivers/usb/mon/mon_main.c linux-2.6.15-rc5-mutex/drivers/usb/mon/mon_main.c
--- linux-2.6.15-rc5/drivers/usb/mon/mon_main.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/mon/mon_main.c	2005-12-15 17:14:57.000000000 +0000
@@ -23,7 +23,7 @@ static void mon_dissolve(struct mon_bus 
 static void mon_bus_drop(struct kref *r);
 static void mon_bus_init(struct dentry *mondir, struct usb_bus *ubus);
 
-DECLARE_MUTEX(mon_lock);
+DECLARE_SEM_MUTEX(mon_lock);
 
 static struct dentry *mon_dir;		/* /dbg/usbmon */
 static LIST_HEAD(mon_buses);		/* All buses we know: struct mon_bus */
diff -uNrp linux-2.6.15-rc5/drivers/usb/serial/pl2303.c linux-2.6.15-rc5-mutex/drivers/usb/serial/pl2303.c
--- linux-2.6.15-rc5/drivers/usb/serial/pl2303.c	2005-12-08 16:23:47.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/usb/serial/pl2303.c	2005-12-15 17:14:57.000000000 +0000
@@ -43,7 +43,7 @@ static int debug;
 #define PL2303_BUF_SIZE		1024
 #define PL2303_TMP_BUF_SIZE	1024
 
-static DECLARE_MUTEX(pl2303_tmp_buf_sem);
+static DECLARE_SEM_MUTEX(pl2303_tmp_buf_sem);
 
 struct pl2303_buf {
 	unsigned int	buf_size;
