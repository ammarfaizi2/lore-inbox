Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVLPXQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVLPXQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVLPXOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:14:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964837AbVLPXNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:39 -0500
Date: Fri, 16 Dec 2005 23:13:08 GMT
Message-Id: <200512162313.jBGND8PR019629@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 4/12]: MUTEX: Rename DECLARE_MUTEX for drivers/ dir, A thru M
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
drivers/ directory, subdirs A through M.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-AtoM-2615rc5-2.diff
 drivers/acpi/pci_link.c                        |    2 +-
 drivers/acpi/processor_perflib.c               |    2 +-
 drivers/acpi/scan.c                            |    2 +-
 drivers/base/attribute_container.c             |    2 +-
 drivers/base/dmapool.c                         |    2 +-
 drivers/base/firmware_class.c                  |    2 +-
 drivers/base/power/main.c                      |    4 ++--
 drivers/base/sys.c                             |    2 +-
 drivers/block/floppy.c                         |    2 +-
 drivers/cdrom/cdu31a.c                         |    2 +-
 drivers/cdrom/sbpcd.c                          |    2 +-
 drivers/char/amiserial.c                       |    2 +-
 drivers/char/esp.c                             |    2 +-
 drivers/char/generic_serial.c                  |    2 +-
 drivers/char/ipmi/ipmi_watchdog.c              |    6 +++---
 drivers/char/isicom.c                          |    2 +-
 drivers/char/istallion.c                       |    2 +-
 drivers/char/misc.c                            |    2 +-
 drivers/char/nwflash.c                         |    2 +-
 drivers/char/raw.c                             |    2 +-
 drivers/char/riscom8.c                         |    2 +-
 drivers/char/serial167.c                       |    2 +-
 drivers/char/specialix.c                       |    2 +-
 drivers/char/stallion.c                        |    2 +-
 drivers/char/synclink.c                        |    2 +-
 drivers/char/tty_io.c                          |    4 ++--
 drivers/char/vt.c                              |    2 +-
 drivers/char/watchdog/pcwd_usb.c               |    2 +-
 drivers/char/watchdog/s3c2410_wdt.c            |    2 +-
 drivers/connector/connector.c                  |    2 +-
 drivers/cpufreq/cpufreq.c                      |    2 +-
 drivers/cpufreq/cpufreq_conservative.c         |    2 +-
 drivers/cpufreq/cpufreq_ondemand.c             |    2 +-
 drivers/cpufreq/cpufreq_userspace.c            |    2 +-
 drivers/fc4/fc.c                               |    2 +-
 drivers/firmware/dcdbas.c                      |    2 +-
 drivers/hwmon/hdaps.c                          |    2 +-
 drivers/i2c/busses/i2c-ali1535.c               |    2 +-
 drivers/i2c/chips/ds1374.c                     |    2 +-
 drivers/i2c/chips/m41t00.c                     |    2 +-
 drivers/i2c/i2c-core.c                         |    2 +-
 drivers/ide/ide-cd.c                           |    2 +-
 drivers/ide/ide-disk.c                         |    2 +-
 drivers/ide/ide-floppy.c                       |    2 +-
 drivers/ide/ide-tape.c                         |    2 +-
 drivers/ide/ide.c                              |    4 ++--
 drivers/ieee1394/hosts.c                       |    2 +-
 drivers/ieee1394/ieee1394_core.c               |    2 +-
 drivers/ieee1394/nodemgr.c                     |    2 +-
 drivers/infiniband/core/device.c               |    2 +-
 drivers/infiniband/core/ucm.c                  |    2 +-
 drivers/infiniband/core/uverbs_main.c          |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    2 +-
 drivers/input/gameport/gameport.c              |    2 +-
 drivers/input/joystick/amijoy.c                |    2 +-
 drivers/input/mouse/psmouse-base.c             |    2 +-
 drivers/input/serio/serio.c                    |    2 +-
 drivers/input/serio/serio_raw.c                |    2 +-
 drivers/isdn/capi/kcapi.c                      |    2 +-
 drivers/macintosh/adb.c                        |    4 ++--
 drivers/macintosh/smu.c                        |    2 +-
 drivers/macintosh/therm_pm72.c                 |    2 +-
 drivers/macintosh/windfarm_core.c              |    2 +-
 drivers/md/dm-table.c                          |    2 +-
 drivers/md/dm.c                                |    2 +-
 drivers/md/kcopyd.c                            |    4 ++--
 drivers/md/md.c                                |    2 +-
 drivers/media/common/saa7146_core.c            |    2 +-
 drivers/media/dvb/dvb-core/dvb_frontend.c      |    2 +-
 drivers/media/dvb/dvb-core/dvbdev.c            |    2 +-
 drivers/media/video/cx88/cx88-core.c           |    2 +-
 drivers/media/video/em28xx/em28xx-video.c      |    2 +-
 drivers/media/video/saa7134/saa7134-core.c     |    2 +-
 drivers/media/video/saa7134/saa7134-tvaudio.c  |    2 +-
 drivers/media/video/videodev.c                 |    2 +-
 drivers/mfd/ucb1x00-core.c                     |    2 +-
 drivers/mmc/mmc_block.c                        |    2 +-
 drivers/mtd/devices/doc2000.c                  |    2 +-
 drivers/mtd/mtdcore.c                          |    2 +-
 80 files changed, 87 insertions(+), 87 deletions(-)

diff -uNrp linux-2.6.15-rc5/drivers/acpi/pci_link.c linux-2.6.15-rc5-mutex/drivers/acpi/pci_link.c
--- linux-2.6.15-rc5/drivers/acpi/pci_link.c	2005-11-01 13:19:04.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/acpi/pci_link.c	2005-12-15 17:14:57.000000000 +0000
@@ -91,7 +91,7 @@ static struct {
 	int count;
 	struct list_head entries;
 } acpi_link;
-DECLARE_MUTEX(acpi_link_lock);
+DECLARE_SEM_MUTEX(acpi_link_lock);
 
 /* --------------------------------------------------------------------------
                             PCI Link Device Management
diff -uNrp linux-2.6.15-rc5/drivers/acpi/processor_perflib.c linux-2.6.15-rc5-mutex/drivers/acpi/processor_perflib.c
--- linux-2.6.15-rc5/drivers/acpi/processor_perflib.c	2005-11-01 13:19:04.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/acpi/processor_perflib.c	2005-12-15 17:14:57.000000000 +0000
@@ -48,7 +48,7 @@
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("acpi_processor")
 
-static DECLARE_MUTEX(performance_sem);
+static DECLARE_SEM_MUTEX(performance_sem);
 
 /*
  * _PPC support is implemented as a CPUfreq policy notifier:
diff -uNrp linux-2.6.15-rc5/drivers/acpi/scan.c linux-2.6.15-rc5-mutex/drivers/acpi/scan.c
--- linux-2.6.15-rc5/drivers/acpi/scan.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/acpi/scan.c	2005-12-15 17:14:57.000000000 +0000
@@ -472,7 +472,7 @@ static int acpi_bus_get_perf_flags(struc
    -------------------------------------------------------------------------- */
 
 static LIST_HEAD(acpi_bus_drivers);
-static DECLARE_MUTEX(acpi_bus_drivers_lock);
+static DECLARE_SEM_MUTEX(acpi_bus_drivers_lock);
 
 /**
  * acpi_bus_match 
diff -uNrp linux-2.6.15-rc5/drivers/base/attribute_container.c linux-2.6.15-rc5-mutex/drivers/base/attribute_container.c
--- linux-2.6.15-rc5/drivers/base/attribute_container.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/attribute_container.c	2005-12-15 17:14:57.000000000 +0000
@@ -62,7 +62,7 @@ EXPORT_SYMBOL_GPL(attribute_container_cl
 
 static struct list_head attribute_container_list;
 
-static DECLARE_MUTEX(attribute_container_mutex);
+static DECLARE_SEM_MUTEX(attribute_container_mutex);
 
 /**
  * attribute_container_register - register an attribute container
diff -uNrp linux-2.6.15-rc5/drivers/base/dmapool.c linux-2.6.15-rc5-mutex/drivers/base/dmapool.c
--- linux-2.6.15-rc5/drivers/base/dmapool.c	2005-11-01 13:19:05.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/dmapool.c	2005-12-15 17:14:57.000000000 +0000
@@ -38,7 +38,7 @@ struct dma_page {	/* cacheable header fo
 #define	POOL_POISON_FREED	0xa7	/* !inuse */
 #define	POOL_POISON_ALLOCATED	0xa9	/* !initted */
 
-static DECLARE_MUTEX (pools_lock);
+static DECLARE_SEM_MUTEX (pools_lock);
 
 static ssize_t
 show_pools (struct device *dev, struct device_attribute *attr, char *buf)
diff -uNrp linux-2.6.15-rc5/drivers/base/firmware_class.c linux-2.6.15-rc5-mutex/drivers/base/firmware_class.c
--- linux-2.6.15-rc5/drivers/base/firmware_class.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/firmware_class.c	2005-12-15 17:14:57.000000000 +0000
@@ -35,7 +35,7 @@ static int loading_timeout = 10;	/* In s
 
 /* fw_lock could be moved to 'struct firmware_priv' but since it is just
  * guarding for corner cases a global lock should be OK */
-static DECLARE_MUTEX(fw_lock);
+static DECLARE_SEM_MUTEX(fw_lock);
 
 struct firmware_priv {
 	char fw_id[FIRMWARE_NAME_MAX];
diff -uNrp linux-2.6.15-rc5/drivers/base/power/main.c linux-2.6.15-rc5-mutex/drivers/base/power/main.c
--- linux-2.6.15-rc5/drivers/base/power/main.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/power/main.c	2005-12-15 17:14:57.000000000 +0000
@@ -27,8 +27,8 @@ LIST_HEAD(dpm_active);
 LIST_HEAD(dpm_off);
 LIST_HEAD(dpm_off_irq);
 
-DECLARE_MUTEX(dpm_sem);
-DECLARE_MUTEX(dpm_list_sem);
+DECLARE_SEM_MUTEX(dpm_sem);
+DECLARE_SEM_MUTEX(dpm_list_sem);
 
 /**
  *	device_pm_set_parent - Specify power dependency.
diff -uNrp linux-2.6.15-rc5/drivers/base/sys.c linux-2.6.15-rc5-mutex/drivers/base/sys.c
--- linux-2.6.15-rc5/drivers/base/sys.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/base/sys.c	2005-12-15 17:14:57.000000000 +0000
@@ -104,7 +104,7 @@ EXPORT_SYMBOL_GPL(sysdev_class_unregiste
 
 
 static LIST_HEAD(sysdev_drivers);
-static DECLARE_MUTEX(sysdev_drivers_lock);
+static DECLARE_SEM_MUTEX(sysdev_drivers_lock);
 
 /**
  *	sysdev_driver_register - Register auxillary driver
diff -uNrp linux-2.6.15-rc5/drivers/block/floppy.c linux-2.6.15-rc5-mutex/drivers/block/floppy.c
--- linux-2.6.15-rc5/drivers/block/floppy.c	2005-12-08 16:23:38.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/block/floppy.c	2005-12-15 17:14:57.000000000 +0000
@@ -414,7 +414,7 @@ static struct floppy_write_errors write_
 static struct timer_list motor_off_timer[N_DRIVE];
 static struct gendisk *disks[N_DRIVE];
 static struct block_device *opened_bdev[N_DRIVE];
-static DECLARE_MUTEX(open_lock);
+static DECLARE_SEM_MUTEX(open_lock);
 static struct floppy_raw_cmd *raw_cmd, default_raw_cmd;
 
 /*
diff -uNrp linux-2.6.15-rc5/drivers/cdrom/cdu31a.c linux-2.6.15-rc5-mutex/drivers/cdrom/cdu31a.c
--- linux-2.6.15-rc5/drivers/cdrom/cdu31a.c	2005-06-22 13:51:46.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/cdrom/cdu31a.c	2005-12-15 17:14:57.000000000 +0000
@@ -264,7 +264,7 @@ static int sony_toc_read = 0;	/* Has the
 static struct s_sony_subcode last_sony_subcode;	/* Points to the last
 						   subcode address read */
 
-static DECLARE_MUTEX(sony_sem);		/* Semaphore for drive hardware access */
+static DECLARE_SEM_MUTEX(sony_sem);		/* Semaphore for drive hardware access */
 
 static int is_double_speed = 0;	/* does the drive support double speed ? */
 
diff -uNrp linux-2.6.15-rc5/drivers/cdrom/sbpcd.c linux-2.6.15-rc5-mutex/drivers/cdrom/sbpcd.c
--- linux-2.6.15-rc5/drivers/cdrom/sbpcd.c	2005-11-01 13:19:05.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/cdrom/sbpcd.c	2005-12-15 17:14:57.000000000 +0000
@@ -598,7 +598,7 @@ static u_char xa_tail_buf[CD_XA_TAIL];
 static volatile u_char busy_data;
 static volatile u_char busy_audio; /* true semaphores would be safer */
 #endif /* OLD_BUSY */ 
-static DECLARE_MUTEX(ioctl_read_sem);
+static DECLARE_SEM_MUTEX(ioctl_read_sem);
 static u_long timeout;
 static volatile u_char timed_out_delay;
 static volatile u_char timed_out_data;
diff -uNrp linux-2.6.15-rc5/drivers/char/amiserial.c linux-2.6.15-rc5-mutex/drivers/char/amiserial.c
--- linux-2.6.15-rc5/drivers/char/amiserial.c	2005-11-01 13:19:05.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/amiserial.c	2005-12-15 17:14:57.000000000 +0000
@@ -128,7 +128,7 @@ static struct serial_state rs_table[1];
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 #include <asm/uaccess.h>
 
diff -uNrp linux-2.6.15-rc5/drivers/char/esp.c linux-2.6.15-rc5-mutex/drivers/char/esp.c
--- linux-2.6.15-rc5/drivers/char/esp.c	2005-06-22 13:51:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/esp.c	2005-12-15 17:14:57.000000000 +0000
@@ -160,7 +160,7 @@ static void rs_wait_until_sent(struct tt
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 static inline int serial_paranoia_check(struct esp_struct *info,
 					char *name, const char *routine)
diff -uNrp linux-2.6.15-rc5/drivers/char/generic_serial.c linux-2.6.15-rc5-mutex/drivers/char/generic_serial.c
--- linux-2.6.15-rc5/drivers/char/generic_serial.c	2005-06-22 13:51:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/generic_serial.c	2005-12-15 17:14:57.000000000 +0000
@@ -34,7 +34,7 @@
 #define DEBUG 
 
 static char *                  tmp_buf; 
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 static int gs_debug;
 
diff -uNrp linux-2.6.15-rc5/drivers/char/ipmi/ipmi_watchdog.c linux-2.6.15-rc5-mutex/drivers/char/ipmi/ipmi_watchdog.c
--- linux-2.6.15-rc5/drivers/char/ipmi/ipmi_watchdog.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/ipmi/ipmi_watchdog.c	2005-12-15 17:14:57.000000000 +0000
@@ -308,7 +308,7 @@ static void panic_halt_ipmi_heartbeat(vo
    The semaphore is claimed when the set_timeout is sent and freed
    when both messages are free. */
 static atomic_t set_timeout_tofree = ATOMIC_INIT(0);
-static DECLARE_MUTEX(set_timeout_lock);
+static DECLARE_SEM_MUTEX(set_timeout_lock);
 static void set_timeout_free_smi(struct ipmi_smi_msg *msg)
 {
     if (atomic_dec_and_test(&set_timeout_tofree))
@@ -458,8 +458,8 @@ static void panic_halt_ipmi_set_timeout(
    The semaphore is claimed when the set_timeout is sent and freed
    when both messages are free. */
 static atomic_t heartbeat_tofree = ATOMIC_INIT(0);
-static DECLARE_MUTEX(heartbeat_lock);
-static DECLARE_MUTEX_LOCKED(heartbeat_wait_lock);
+static DECLARE_SEM_MUTEX(heartbeat_lock);
+static DECLARE_SEM_MUTEX_LOCKED(heartbeat_wait_lock);
 static void heartbeat_free_smi(struct ipmi_smi_msg *msg)
 {
     if (atomic_dec_and_test(&heartbeat_tofree))
diff -uNrp linux-2.6.15-rc5/drivers/char/isicom.c linux-2.6.15-rc5-mutex/drivers/char/isicom.c
--- linux-2.6.15-rc5/drivers/char/isicom.c	2005-08-30 13:56:15.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/isicom.c	2005-12-15 17:14:57.000000000 +0000
@@ -163,7 +163,7 @@ static void isicom_tx(unsigned long _dat
 static void isicom_start(struct tty_struct * tty);
 
 static unsigned char * tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 /*   baud index mappings from linux defns to isi */
 
diff -uNrp linux-2.6.15-rc5/drivers/char/istallion.c linux-2.6.15-rc5-mutex/drivers/char/istallion.c
--- linux-2.6.15-rc5/drivers/char/istallion.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/istallion.c	2005-12-15 17:14:57.000000000 +0000
@@ -181,7 +181,7 @@ static struct tty_driver	*stli_serial;
  *	is already swapping a shared buffer won't make things any worse.
  */
 static char			*stli_tmpwritebuf;
-static DECLARE_MUTEX(stli_tmpwritesem);
+static DECLARE_SEM_MUTEX(stli_tmpwritesem);
 
 #define	STLI_TXBUFSIZE		4096
 
diff -uNrp linux-2.6.15-rc5/drivers/char/misc.c linux-2.6.15-rc5-mutex/drivers/char/misc.c
--- linux-2.6.15-rc5/drivers/char/misc.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/misc.c	2005-12-15 17:14:57.000000000 +0000
@@ -55,7 +55,7 @@
  * Head entry for the doubly linked miscdevice list
  */
 static LIST_HEAD(misc_list);
-static DECLARE_MUTEX(misc_sem);
+static DECLARE_SEM_MUTEX(misc_sem);
 
 /*
  * Assigned numbers, used for dynamic minors
diff -uNrp linux-2.6.15-rc5/drivers/char/nwflash.c linux-2.6.15-rc5-mutex/drivers/char/nwflash.c
--- linux-2.6.15-rc5/drivers/char/nwflash.c	2005-06-22 13:51:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/nwflash.c	2005-12-15 17:14:57.000000000 +0000
@@ -56,7 +56,7 @@ static int gbWriteEnable;
 static int gbWriteBase64Enable;
 static volatile unsigned char *FLASH_BASE;
 static int gbFlashSize = KFLASH_SIZE;
-static DECLARE_MUTEX(nwflash_sem);
+static DECLARE_SEM_MUTEX(nwflash_sem);
 
 extern spinlock_t gpio_lock;
 
diff -uNrp linux-2.6.15-rc5/drivers/char/raw.c linux-2.6.15-rc5-mutex/drivers/char/raw.c
--- linux-2.6.15-rc5/drivers/char/raw.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/raw.c	2005-12-15 17:14:57.000000000 +0000
@@ -29,7 +29,7 @@ struct raw_device_data {
 
 static struct class *raw_class;
 static struct raw_device_data raw_devices[MAX_RAW_MINORS];
-static DECLARE_MUTEX(raw_mutex);
+static DECLARE_SEM_MUTEX(raw_mutex);
 static struct file_operations raw_ctl_fops;	     /* forward declaration */
 
 /*
diff -uNrp linux-2.6.15-rc5/drivers/char/riscom8.c linux-2.6.15-rc5-mutex/drivers/char/riscom8.c
--- linux-2.6.15-rc5/drivers/char/riscom8.c	2005-01-04 11:13:11.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/riscom8.c	2005-12-15 17:14:57.000000000 +0000
@@ -81,7 +81,7 @@
 static struct riscom_board * IRQ_to_board[16];
 static struct tty_driver *riscom_driver;
 static unsigned char * tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
diff -uNrp linux-2.6.15-rc5/drivers/char/serial167.c linux-2.6.15-rc5-mutex/drivers/char/serial167.c
--- linux-2.6.15-rc5/drivers/char/serial167.c	2005-01-04 11:13:11.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/serial167.c	2005-12-15 17:14:57.000000000 +0000
@@ -129,7 +129,7 @@ struct cyclades_port cy_port[] = {
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf = 0;
-DECLARE_MUTEX(tmp_buf_sem);
+DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 /*
  * This is used to look up the divisor speeds and the timeouts
diff -uNrp linux-2.6.15-rc5/drivers/char/specialix.c linux-2.6.15-rc5-mutex/drivers/char/specialix.c
--- linux-2.6.15-rc5/drivers/char/specialix.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/specialix.c	2005-12-15 17:14:57.000000000 +0000
@@ -183,7 +183,7 @@ static int sx_poll = HZ;
 
 static struct tty_driver *specialix_driver;
 static unsigned char * tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
diff -uNrp linux-2.6.15-rc5/drivers/char/stallion.c linux-2.6.15-rc5-mutex/drivers/char/stallion.c
--- linux-2.6.15-rc5/drivers/char/stallion.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/stallion.c	2005-12-15 17:14:57.000000000 +0000
@@ -148,7 +148,7 @@ static struct tty_driver	*stl_serial;
  *	is already swapping a shared buffer won't make things any worse.
  */
 static char			*stl_tmpwritebuf;
-static DECLARE_MUTEX(stl_tmpwritesem);
+static DECLARE_SEM_MUTEX(stl_tmpwritesem);
 
 /*
  *	Define a local default termios struct. All ports will be created
diff -uNrp linux-2.6.15-rc5/drivers/char/synclink.c linux-2.6.15-rc5-mutex/drivers/char/synclink.c
--- linux-2.6.15-rc5/drivers/char/synclink.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/synclink.c	2005-12-15 17:14:57.000000000 +0000
@@ -951,7 +951,7 @@ static void* mgsl_get_text_ptr(void)
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
+static DECLARE_SEM_MUTEX(tmp_buf_sem);
 
 static inline int mgsl_paranoia_check(struct mgsl_struct *info,
 					char *name, const char *routine)
diff -uNrp linux-2.6.15-rc5/drivers/char/tty_io.c linux-2.6.15-rc5-mutex/drivers/char/tty_io.c
--- linux-2.6.15-rc5/drivers/char/tty_io.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/tty_io.c	2005-12-15 17:14:57.000000000 +0000
@@ -130,13 +130,13 @@ LIST_HEAD(tty_drivers);			/* linked list
 
 /* Semaphore to protect creating and releasing a tty. This is shared with
    vt.c for deeply disgusting hack reasons */
-DECLARE_MUTEX(tty_sem);
+DECLARE_SEM_MUTEX(tty_sem);
 
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
 static DEFINE_IDR(allocated_ptys);
-static DECLARE_MUTEX(allocated_ptys_lock);
+static DECLARE_SEM_MUTEX(allocated_ptys_lock);
 static int ptmx_open(struct inode *, struct file *);
 #endif
 
diff -uNrp linux-2.6.15-rc5/drivers/char/vt.c linux-2.6.15-rc5-mutex/drivers/char/vt.c
--- linux-2.6.15-rc5/drivers/char/vt.c	2005-11-01 13:19:06.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/vt.c	2005-12-15 17:14:57.000000000 +0000
@@ -1907,7 +1907,7 @@ static void do_con_trol(struct tty_struc
  * kernel memory allocation is available.
  */
 char con_buf[CON_BUF_SIZE];
-DECLARE_MUTEX(con_buf_sem);
+DECLARE_SEM_MUTEX(con_buf_sem);
 
 /* acquires console_sem */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
diff -uNrp linux-2.6.15-rc5/drivers/char/watchdog/pcwd_usb.c linux-2.6.15-rc5-mutex/drivers/char/watchdog/pcwd_usb.c
--- linux-2.6.15-rc5/drivers/char/watchdog/pcwd_usb.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/char/watchdog/pcwd_usb.c	2005-12-15 17:14:57.000000000 +0000
@@ -143,7 +143,7 @@ struct usb_pcwd_private {
 static struct usb_pcwd_private *usb_pcwd_device;
 
 /* prevent races between open() and disconnect() */
-static DECLARE_MUTEX (disconnect_sem);
+static DECLARE_SEM_MUTEX (disconnect_sem);
 
 /* local function prototypes */
 static int usb_pcwd_probe	(struct usb_interface *interface, const struct usb_device_id *id);
diff -uNrp linux-2.6.15-rc5/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.15-rc5-mutex/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.15-rc5/drivers/char/watchdog/s3c2410_wdt.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/char/watchdog/s3c2410_wdt.c	2005-12-15 17:14:57.000000000 +0000
@@ -91,7 +91,7 @@ typedef enum close_state {
 	CLOSE_STATE_ALLOW=0x4021
 } close_state_t;
 
-static DECLARE_MUTEX(open_lock);
+static DECLARE_SEM_MUTEX(open_lock);
 
 static struct resource	*wdt_mem;
 static struct resource	*wdt_irq;
diff -uNrp linux-2.6.15-rc5/drivers/connector/connector.c linux-2.6.15-rc5-mutex/drivers/connector/connector.c
--- linux-2.6.15-rc5/drivers/connector/connector.c	2005-11-01 13:19:06.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/connector/connector.c	2005-12-15 17:14:57.000000000 +0000
@@ -41,7 +41,7 @@ module_param(cn_val, uint, 0);
 MODULE_PARM_DESC(cn_idx, "Connector's main device idx.");
 MODULE_PARM_DESC(cn_val, "Connector's main device val.");
 
-static DECLARE_MUTEX(notify_lock);
+static DECLARE_SEM_MUTEX(notify_lock);
 static LIST_HEAD(notify_list);
 
 static struct cn_dev cdev;
diff -uNrp linux-2.6.15-rc5/drivers/cpufreq/cpufreq.c linux-2.6.15-rc5-mutex/drivers/cpufreq/cpufreq.c
--- linux-2.6.15-rc5/drivers/cpufreq/cpufreq.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/cpufreq/cpufreq.c	2005-12-15 17:14:57.000000000 +0000
@@ -56,7 +56,7 @@ static DECLARE_RWSEM		(cpufreq_notifier_
 
 
 static LIST_HEAD(cpufreq_governor_list);
-static DECLARE_MUTEX		(cpufreq_governor_sem);
+static DECLARE_SEM_MUTEX		(cpufreq_governor_sem);
 
 struct cpufreq_policy * cpufreq_cpu_get(unsigned int cpu)
 {
diff -uNrp linux-2.6.15-rc5/drivers/cpufreq/cpufreq_conservative.c linux-2.6.15-rc5-mutex/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.15-rc5/drivers/cpufreq/cpufreq_conservative.c	2005-11-01 13:19:06.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/cpufreq/cpufreq_conservative.c	2005-12-15 17:14:57.000000000 +0000
@@ -71,7 +71,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_inf
 
 static unsigned int dbs_enable;	/* number of CPUs using this policy */
 
-static DECLARE_MUTEX 	(dbs_sem);
+static DECLARE_SEM_MUTEX 	(dbs_sem);
 static DECLARE_WORK	(dbs_work, do_dbs_timer, NULL);
 
 struct dbs_tuners {
diff -uNrp linux-2.6.15-rc5/drivers/cpufreq/cpufreq_ondemand.c linux-2.6.15-rc5-mutex/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.15-rc5/drivers/cpufreq/cpufreq_ondemand.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/cpufreq/cpufreq_ondemand.c	2005-12-15 17:14:57.000000000 +0000
@@ -70,7 +70,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_inf
 
 static unsigned int dbs_enable;	/* number of CPUs using this policy */
 
-static DECLARE_MUTEX 	(dbs_sem);
+static DECLARE_SEM_MUTEX 	(dbs_sem);
 static DECLARE_WORK	(dbs_work, do_dbs_timer, NULL);
 
 struct dbs_tuners {
diff -uNrp linux-2.6.15-rc5/drivers/cpufreq/cpufreq_userspace.c linux-2.6.15-rc5-mutex/drivers/cpufreq/cpufreq_userspace.c
--- linux-2.6.15-rc5/drivers/cpufreq/cpufreq_userspace.c	2005-03-02 12:08:06.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/cpufreq/cpufreq_userspace.c	2005-12-15 17:14:57.000000000 +0000
@@ -35,7 +35,7 @@ static unsigned int	cpu_set_freq[NR_CPUS
 static unsigned int	cpu_is_managed[NR_CPUS];
 static struct cpufreq_policy current_policy[NR_CPUS];
 
-static DECLARE_MUTEX	(userspace_sem); 
+static DECLARE_SEM_MUTEX	(userspace_sem); 
 
 #define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_GOVERNOR, "userspace", msg)
 
diff -uNrp linux-2.6.15-rc5/drivers/fc4/fc.c linux-2.6.15-rc5-mutex/drivers/fc4/fc.c
--- linux-2.6.15-rc5/drivers/fc4/fc.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/fc4/fc.c	2005-12-15 17:14:57.000000000 +0000
@@ -928,7 +928,7 @@ int fcp_scsi_dev_reset(Scsi_Cmnd *SCpnt)
 	fcp_cmd *cmd;
 	fcp_cmnd *fcmd;
 	fc_channel *fc = FC_SCMND(SCpnt);
-        DECLARE_MUTEX_LOCKED(sem);
+        DECLARE_SEM_MUTEX_LOCKED(sem);
 
 	if (!fc->rst_pkt) {
 		fc->rst_pkt = (Scsi_Cmnd *) kmalloc(sizeof(SCpnt), GFP_KERNEL);
diff -uNrp linux-2.6.15-rc5/drivers/firmware/dcdbas.c linux-2.6.15-rc5-mutex/drivers/firmware/dcdbas.c
--- linux-2.6.15-rc5/drivers/firmware/dcdbas.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/firmware/dcdbas.c	2005-12-15 17:14:57.000000000 +0000
@@ -48,7 +48,7 @@ static u8 *smi_data_buf;
 static dma_addr_t smi_data_buf_handle;
 static unsigned long smi_data_buf_size;
 static u32 smi_data_buf_phys_addr;
-static DECLARE_MUTEX(smi_data_lock);
+static DECLARE_SEM_MUTEX(smi_data_lock);
 
 static unsigned int host_control_action;
 static unsigned int host_control_smi_type;
diff -uNrp linux-2.6.15-rc5/drivers/hwmon/hdaps.c linux-2.6.15-rc5-mutex/drivers/hwmon/hdaps.c
--- linux-2.6.15-rc5/drivers/hwmon/hdaps.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/hdaps.c	2005-12-15 17:14:57.000000000 +0000
@@ -70,7 +70,7 @@ static u8 km_activity;
 static int rest_x;
 static int rest_y;
 
-static DECLARE_MUTEX(hdaps_sem);
+static DECLARE_SEM_MUTEX(hdaps_sem);
 
 /*
  * __get_latch - Get the value from a given port.  Callers must hold hdaps_sem.
diff -uNrp linux-2.6.15-rc5/drivers/i2c/busses/i2c-ali1535.c linux-2.6.15-rc5-mutex/drivers/i2c/busses/i2c-ali1535.c
--- linux-2.6.15-rc5/drivers/i2c/busses/i2c-ali1535.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/busses/i2c-ali1535.c	2005-12-15 17:14:57.000000000 +0000
@@ -136,7 +136,7 @@
 
 static struct pci_driver ali1535_driver;
 static unsigned short ali1535_smba;
-static DECLARE_MUTEX(i2c_ali1535_sem);
+static DECLARE_SEM_MUTEX(i2c_ali1535_sem);
 
 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
diff -uNrp linux-2.6.15-rc5/drivers/i2c/chips/ds1374.c linux-2.6.15-rc5-mutex/drivers/i2c/chips/ds1374.c
--- linux-2.6.15-rc5/drivers/i2c/chips/ds1374.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/chips/ds1374.c	2005-12-15 17:14:57.000000000 +0000
@@ -41,7 +41,7 @@
 
 #define	DS1374_DRV_NAME		"ds1374"
 
-static DECLARE_MUTEX(ds1374_mutex);
+static DECLARE_SEM_MUTEX(ds1374_mutex);
 
 static struct i2c_driver ds1374_driver;
 static struct i2c_client *save_client;
diff -uNrp linux-2.6.15-rc5/drivers/i2c/chips/m41t00.c linux-2.6.15-rc5-mutex/drivers/i2c/chips/m41t00.c
--- linux-2.6.15-rc5/drivers/i2c/chips/m41t00.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/chips/m41t00.c	2005-12-15 17:14:57.000000000 +0000
@@ -30,7 +30,7 @@
 
 #define	M41T00_DRV_NAME		"m41t00"
 
-static DECLARE_MUTEX(m41t00_mutex);
+static DECLARE_SEM_MUTEX(m41t00_mutex);
 
 static struct i2c_driver m41t00_driver;
 static struct i2c_client *save_client;
diff -uNrp linux-2.6.15-rc5/drivers/i2c/i2c-core.c linux-2.6.15-rc5-mutex/drivers/i2c/i2c-core.c
--- linux-2.6.15-rc5/drivers/i2c/i2c-core.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/i2c-core.c	2005-12-15 17:14:57.000000000 +0000
@@ -36,7 +36,7 @@
 
 static LIST_HEAD(adapters);
 static LIST_HEAD(drivers);
-static DECLARE_MUTEX(core_lists);
+static DECLARE_SEM_MUTEX(core_lists);
 static DEFINE_IDR(i2c_adapter_idr);
 
 /* match always succeeds, as we want the probe() to tell if we really accept this match */
diff -uNrp linux-2.6.15-rc5/drivers/ide/ide-cd.c linux-2.6.15-rc5-mutex/drivers/ide/ide-cd.c
--- linux-2.6.15-rc5/drivers/ide/ide-cd.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ide/ide-cd.c	2005-12-15 17:14:57.000000000 +0000
@@ -324,7 +324,7 @@
 
 #include "ide-cd.h"
 
-static DECLARE_MUTEX(idecd_ref_sem);
+static DECLARE_SEM_MUTEX(idecd_ref_sem);
 
 #define to_ide_cd(obj) container_of(obj, struct cdrom_info, kref) 
 
diff -uNrp linux-2.6.15-rc5/drivers/ide/ide-disk.c linux-2.6.15-rc5-mutex/drivers/ide/ide-disk.c
--- linux-2.6.15-rc5/drivers/ide/ide-disk.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ide/ide-disk.c	2005-12-15 17:14:57.000000000 +0000
@@ -78,7 +78,7 @@ struct ide_disk_obj {
 	struct kref	kref;
 };
 
-static DECLARE_MUTEX(idedisk_ref_sem);
+static DECLARE_SEM_MUTEX(idedisk_ref_sem);
 
 #define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)
 
diff -uNrp linux-2.6.15-rc5/drivers/ide/ide-floppy.c linux-2.6.15-rc5-mutex/drivers/ide/ide-floppy.c
--- linux-2.6.15-rc5/drivers/ide/ide-floppy.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ide/ide-floppy.c	2005-12-15 17:14:57.000000000 +0000
@@ -517,7 +517,7 @@ typedef struct {
 	u8		reserved[4];
 } idefloppy_mode_parameter_header_t;
 
-static DECLARE_MUTEX(idefloppy_ref_sem);
+static DECLARE_SEM_MUTEX(idefloppy_ref_sem);
 
 #define to_ide_floppy(obj) container_of(obj, struct ide_floppy_obj, kref)
 
diff -uNrp linux-2.6.15-rc5/drivers/ide/ide-tape.c linux-2.6.15-rc5-mutex/drivers/ide/ide-tape.c
--- linux-2.6.15-rc5/drivers/ide/ide-tape.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ide/ide-tape.c	2005-12-15 17:14:57.000000000 +0000
@@ -1011,7 +1011,7 @@ typedef struct ide_tape_obj {
          int debug_level; 
 } idetape_tape_t;
 
-static DECLARE_MUTEX(idetape_ref_sem);
+static DECLARE_SEM_MUTEX(idetape_ref_sem);
 
 static struct class *idetape_sysfs_class;
 
diff -uNrp linux-2.6.15-rc5/drivers/ide/ide.c linux-2.6.15-rc5-mutex/drivers/ide/ide.c
--- linux-2.6.15-rc5/drivers/ide/ide.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ide/ide.c	2005-12-15 17:14:57.000000000 +0000
@@ -174,7 +174,7 @@ static int idebus_parameter;	/* holds th
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
 static int initializing;	/* set while initializing built-in drivers */
 
-DECLARE_MUTEX(ide_cfg_sem);
+DECLARE_SEM_MUTEX(ide_cfg_sem);
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
@@ -829,7 +829,7 @@ EXPORT_SYMBOL(ide_register_hw);
  *	Locks for IDE setting functionality
  */
 
-DECLARE_MUTEX(ide_setting_sem);
+DECLARE_SEM_MUTEX(ide_setting_sem);
 
 /**
  *	__ide_add_setting	-	add an ide setting option
diff -uNrp linux-2.6.15-rc5/drivers/ieee1394/hosts.c linux-2.6.15-rc5-mutex/drivers/ieee1394/hosts.c
--- linux-2.6.15-rc5/drivers/ieee1394/hosts.c	2005-11-01 13:19:07.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/hosts.c	2005-12-15 17:14:57.000000000 +0000
@@ -105,7 +105,7 @@ static int alloc_hostnum_cb(struct hpsb_
  * Return Value: a pointer to the &hpsb_host if succesful, %NULL if
  * no memory was available.
  */
-static DECLARE_MUTEX(host_num_alloc);
+static DECLARE_SEM_MUTEX(host_num_alloc);
 
 struct hpsb_host *hpsb_alloc_host(struct hpsb_host_driver *drv, size_t extra,
 				  struct device *dev)
diff -uNrp linux-2.6.15-rc5/drivers/ieee1394/ieee1394_core.c linux-2.6.15-rc5-mutex/drivers/ieee1394/ieee1394_core.c
--- linux-2.6.15-rc5/drivers/ieee1394/ieee1394_core.c	2005-11-01 13:19:07.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/ieee1394_core.c	2005-12-15 17:14:57.000000000 +0000
@@ -1003,7 +1003,7 @@ void abort_timedouts(unsigned long __opa
 static int khpsbpkt_pid = -1, khpsbpkt_kill;
 static DECLARE_COMPLETION(khpsbpkt_complete);
 static struct sk_buff_head hpsbpkt_queue;
-static DECLARE_MUTEX_LOCKED(khpsbpkt_sig);
+static DECLARE_SEM_MUTEX_LOCKED(khpsbpkt_sig);
 
 
 static void queue_packet_complete(struct hpsb_packet *packet)
diff -uNrp linux-2.6.15-rc5/drivers/ieee1394/nodemgr.c linux-2.6.15-rc5-mutex/drivers/ieee1394/nodemgr.c
--- linux-2.6.15-rc5/drivers/ieee1394/nodemgr.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/nodemgr.c	2005-12-15 17:14:57.000000000 +0000
@@ -108,7 +108,7 @@ static struct csr1212_bus_ops nodemgr_cs
  * but now we are much simpler because of the LDM.
  */
 
-static DECLARE_MUTEX(nodemgr_serialize);
+static DECLARE_SEM_MUTEX(nodemgr_serialize);
 
 struct host_info {
 	struct hpsb_host *host;
diff -uNrp linux-2.6.15-rc5/drivers/infiniband/core/device.c linux-2.6.15-rc5-mutex/drivers/infiniband/core/device.c
--- linux-2.6.15-rc5/drivers/infiniband/core/device.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/core/device.c	2005-12-15 17:14:57.000000000 +0000
@@ -63,7 +63,7 @@ static LIST_HEAD(client_list);
  * modifying one list or the other list.  In any case this is not a
  * hot path so there's no point in trying to optimize.
  */
-static DECLARE_MUTEX(device_sem);
+static DECLARE_SEM_MUTEX(device_sem);
 
 static int ib_device_check_mandatory(struct ib_device *device)
 {
diff -uNrp linux-2.6.15-rc5/drivers/infiniband/core/ucm.c linux-2.6.15-rc5-mutex/drivers/infiniband/core/ucm.c
--- linux-2.6.15-rc5/drivers/infiniband/core/ucm.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/core/ucm.c	2005-12-15 17:14:57.000000000 +0000
@@ -113,7 +113,7 @@ static struct ib_client ucm_client = {
 	.remove = ib_ucm_remove_one
 };
 
-static DECLARE_MUTEX(ctx_id_mutex);
+static DECLARE_SEM_MUTEX(ctx_id_mutex);
 static DEFINE_IDR(ctx_id_table);
 static DECLARE_BITMAP(dev_map, IB_UCM_MAX_DEVICES);
 
diff -uNrp linux-2.6.15-rc5/drivers/infiniband/core/uverbs_main.c linux-2.6.15-rc5-mutex/drivers/infiniband/core/uverbs_main.c
--- linux-2.6.15-rc5/drivers/infiniband/core/uverbs_main.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/core/uverbs_main.c	2005-12-15 17:14:57.000000000 +0000
@@ -66,7 +66,7 @@ enum {
 
 static struct class *uverbs_class;
 
-DECLARE_MUTEX(ib_uverbs_idr_mutex);
+DECLARE_SEM_MUTEX(ib_uverbs_idr_mutex);
 DEFINE_IDR(ib_uverbs_pd_idr);
 DEFINE_IDR(ib_uverbs_mr_idr);
 DEFINE_IDR(ib_uverbs_mw_idr);
diff -uNrp linux-2.6.15-rc5/drivers/infiniband/ulp/ipoib/ipoib_ib.c linux-2.6.15-rc5-mutex/drivers/infiniband/ulp/ipoib/ipoib_ib.c
--- linux-2.6.15-rc5/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-12-15 17:14:57.000000000 +0000
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(data_debug_level,
 
 #define	IPOIB_OP_RECV	(1ul << 31)
 
-static DECLARE_MUTEX(pkey_sem);
+static DECLARE_SEM_MUTEX(pkey_sem);
 
 struct ipoib_ah *ipoib_create_ah(struct net_device *dev,
 				 struct ib_pd *pd, struct ib_ah_attr *attr)
diff -uNrp linux-2.6.15-rc5/drivers/infiniband/ulp/ipoib/ipoib_multicast.c linux-2.6.15-rc5-mutex/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
--- linux-2.6.15-rc5/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-12-15 17:14:57.000000000 +0000
@@ -53,7 +53,7 @@ MODULE_PARM_DESC(mcast_debug_level,
 		 "Enable multicast debug tracing if > 0");
 #endif
 
-static DECLARE_MUTEX(mcast_mutex);
+static DECLARE_SEM_MUTEX(mcast_mutex);
 
 /* Used for all multicast joins (broadcast, IPv4 mcast and IPv6 mcast) */
 struct ipoib_mcast {
diff -uNrp linux-2.6.15-rc5/drivers/input/gameport/gameport.c linux-2.6.15-rc5-mutex/drivers/input/gameport/gameport.c
--- linux-2.6.15-rc5/drivers/input/gameport/gameport.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/gameport/gameport.c	2005-12-15 17:14:57.000000000 +0000
@@ -46,7 +46,7 @@ EXPORT_SYMBOL(gameport_stop_polling);
  * gameport_sem protects entire gameport subsystem and is taken
  * every time gameport port or driver registrered or unregistered.
  */
-static DECLARE_MUTEX(gameport_sem);
+static DECLARE_SEM_MUTEX(gameport_sem);
 
 static LIST_HEAD(gameport_list);
 
diff -uNrp linux-2.6.15-rc5/drivers/input/joystick/amijoy.c linux-2.6.15-rc5-mutex/drivers/input/joystick/amijoy.c
--- linux-2.6.15-rc5/drivers/input/joystick/amijoy.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/joystick/amijoy.c	2005-12-15 17:14:57.000000000 +0000
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(map, "Map of attached j
 __obsolete_setup("amijoy=");
 
 static int amijoy_used;
-static DECLARE_MUTEX(amijoy_sem);
+static DECLARE_SEM_MUTEX(amijoy_sem);
 static struct input_dev *amijoy_dev[2];
 static char *amijoy_phys[2] = { "amijoy/input0", "amijoy/input1" };
 
diff -uNrp linux-2.6.15-rc5/drivers/input/mouse/psmouse-base.c linux-2.6.15-rc5-mutex/drivers/input/mouse/psmouse-base.c
--- linux-2.6.15-rc5/drivers/input/mouse/psmouse-base.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/mouse/psmouse-base.c	2005-12-15 17:14:57.000000000 +0000
@@ -96,7 +96,7 @@ __obsolete_setup("psmouse_rate=");
  * rarely more than one PS/2 mouse connected and since semaphore
  * is taken in "slow" paths it is not worth it.
  */
-static DECLARE_MUTEX(psmouse_sem);
+static DECLARE_SEM_MUTEX(psmouse_sem);
 
 struct psmouse_protocol {
 	enum psmouse_type type;
diff -uNrp linux-2.6.15-rc5/drivers/input/serio/serio.c linux-2.6.15-rc5-mutex/drivers/input/serio/serio.c
--- linux-2.6.15-rc5/drivers/input/serio/serio.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/serio/serio.c	2005-12-15 17:14:57.000000000 +0000
@@ -55,7 +55,7 @@ EXPORT_SYMBOL(serio_reconnect);
  * serio_sem protects entire serio subsystem and is taken every time
  * serio port or driver registrered or unregistered.
  */
-static DECLARE_MUTEX(serio_sem);
+static DECLARE_SEM_MUTEX(serio_sem);
 
 static LIST_HEAD(serio_list);
 
diff -uNrp linux-2.6.15-rc5/drivers/input/serio/serio_raw.c linux-2.6.15-rc5-mutex/drivers/input/serio/serio_raw.c
--- linux-2.6.15-rc5/drivers/input/serio/serio_raw.c	2005-08-30 13:56:17.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/input/serio/serio_raw.c	2005-12-15 17:14:57.000000000 +0000
@@ -46,7 +46,7 @@ struct serio_raw_list {
 	struct list_head node;
 };
 
-static DECLARE_MUTEX(serio_raw_sem);
+static DECLARE_SEM_MUTEX(serio_raw_sem);
 static LIST_HEAD(serio_raw_list);
 static unsigned int serio_raw_no;
 
diff -uNrp linux-2.6.15-rc5/drivers/isdn/capi/kcapi.c linux-2.6.15-rc5-mutex/drivers/isdn/capi/kcapi.c
--- linux-2.6.15-rc5/drivers/isdn/capi/kcapi.c	2005-03-02 12:08:09.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/isdn/capi/kcapi.c	2005-12-15 17:14:57.000000000 +0000
@@ -66,7 +66,7 @@ LIST_HEAD(capi_drivers);
 DEFINE_RWLOCK(capi_drivers_list_lock);
 
 static DEFINE_RWLOCK(application_lock);
-static DECLARE_MUTEX(controller_sem);
+static DECLARE_SEM_MUTEX(controller_sem);
 
 struct capi20_appl *capi_applications[CAPI_MAXAPPL];
 struct capi_ctr *capi_cards[CAPI_MAXCONTR];
diff -uNrp linux-2.6.15-rc5/drivers/macintosh/adb.c linux-2.6.15-rc5-mutex/drivers/macintosh/adb.c
--- linux-2.6.15-rc5/drivers/macintosh/adb.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/macintosh/adb.c	2005-12-15 17:14:57.000000000 +0000
@@ -84,7 +84,7 @@ struct notifier_block *adb_client_list =
 static int adb_got_sleep;
 static int adb_inited;
 static pid_t adb_probe_task_pid;
-static DECLARE_MUTEX(adb_probe_mutex);
+static DECLARE_SEM_MUTEX(adb_probe_mutex);
 static struct completion adb_probe_task_comp;
 static int sleepy_trackpad;
 static int autopoll_devs;
@@ -119,7 +119,7 @@ static struct adb_handler {
  * time adb_unregister returns, we know that the old handler isn't being
  * called.
  */
-static DECLARE_MUTEX(adb_handler_sem);
+static DECLARE_SEM_MUTEX(adb_handler_sem);
 static DEFINE_RWLOCK(adb_handler_lock);
 
 #if 0
diff -uNrp linux-2.6.15-rc5/drivers/macintosh/smu.c linux-2.6.15-rc5-mutex/drivers/macintosh/smu.c
--- linux-2.6.15-rc5/drivers/macintosh/smu.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/macintosh/smu.c	2005-12-15 17:14:57.000000000 +0000
@@ -92,7 +92,7 @@ struct smu_device {
  * for now, just hard code that
  */
 static struct smu_device	*smu;
-static DECLARE_MUTEX(smu_part_access);
+static DECLARE_SEM_MUTEX(smu_part_access);
 
 /*
  * SMU driver low level stuff
diff -uNrp linux-2.6.15-rc5/drivers/macintosh/therm_pm72.c linux-2.6.15-rc5-mutex/drivers/macintosh/therm_pm72.c
--- linux-2.6.15-rc5/drivers/macintosh/therm_pm72.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/macintosh/therm_pm72.c	2005-12-15 17:14:57.000000000 +0000
@@ -158,7 +158,7 @@ static int				critical_state;
 static int				rackmac;
 static s32				dimm_output_clamp;
 
-static DECLARE_MUTEX(driver_lock);
+static DECLARE_SEM_MUTEX(driver_lock);
 
 /*
  * We have 3 types of CPU PID control. One is "split" old style control
diff -uNrp linux-2.6.15-rc5/drivers/macintosh/windfarm_core.c linux-2.6.15-rc5-mutex/drivers/macintosh/windfarm_core.c
--- linux-2.6.15-rc5/drivers/macintosh/windfarm_core.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/macintosh/windfarm_core.c	2005-12-15 17:14:57.000000000 +0000
@@ -48,7 +48,7 @@
 
 static LIST_HEAD(wf_controls);
 static LIST_HEAD(wf_sensors);
-static DECLARE_MUTEX(wf_lock);
+static DECLARE_SEM_MUTEX(wf_lock);
 static struct notifier_block *wf_client_list;
 static int wf_client_count;
 static unsigned int wf_overtemp;
diff -uNrp linux-2.6.15-rc5/drivers/md/dm-table.c linux-2.6.15-rc5-mutex/drivers/md/dm-table.c
--- linux-2.6.15-rc5/drivers/md/dm-table.c	2005-08-30 13:56:17.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/md/dm-table.c	2005-12-15 17:14:57.000000000 +0000
@@ -765,7 +765,7 @@ int dm_table_complete(struct dm_table *t
 	return r;
 }
 
-static DECLARE_MUTEX(_event_lock);
+static DECLARE_SEM_MUTEX(_event_lock);
 void dm_table_event_callback(struct dm_table *t,
 			     void (*fn)(void *), void *context)
 {
diff -uNrp linux-2.6.15-rc5/drivers/md/dm.c linux-2.6.15-rc5-mutex/drivers/md/dm.c
--- linux-2.6.15-rc5/drivers/md/dm.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/md/dm.c	2005-12-15 17:14:57.000000000 +0000
@@ -652,7 +652,7 @@ static int dm_any_congested(void *conges
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
-static DECLARE_MUTEX(_minor_lock);
+static DECLARE_SEM_MUTEX(_minor_lock);
 static DEFINE_IDR(_minor_idr);
 
 static void free_minor(unsigned int minor)
diff -uNrp linux-2.6.15-rc5/drivers/md/kcopyd.c linux-2.6.15-rc5-mutex/drivers/md/kcopyd.c
--- linux-2.6.15-rc5/drivers/md/kcopyd.c	2005-03-02 12:08:10.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/md/kcopyd.c	2005-12-15 17:14:57.000000000 +0000
@@ -570,7 +570,7 @@ int kcopyd_cancel(struct kcopyd_job *job
 /*-----------------------------------------------------------------
  * Unit setup
  *---------------------------------------------------------------*/
-static DECLARE_MUTEX(_client_lock);
+static DECLARE_SEM_MUTEX(_client_lock);
 static LIST_HEAD(_clients);
 
 static void client_add(struct kcopyd_client *kc)
@@ -587,7 +587,7 @@ static void client_del(struct kcopyd_cli
 	up(&_client_lock);
 }
 
-static DECLARE_MUTEX(kcopyd_init_lock);
+static DECLARE_SEM_MUTEX(kcopyd_init_lock);
 static int kcopyd_clients = 0;
 
 static int kcopyd_init(void)
diff -uNrp linux-2.6.15-rc5/drivers/md/md.c linux-2.6.15-rc5-mutex/drivers/md/md.c
--- linux-2.6.15-rc5/drivers/md/md.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/md/md.c	2005-12-15 17:14:57.000000000 +0000
@@ -1882,7 +1882,7 @@ int mdp_major = 0;
 
 static struct kobject *md_probe(dev_t dev, int *part, void *data)
 {
-	static DECLARE_MUTEX(disks_sem);
+	static DECLARE_SEM_MUTEX(disks_sem);
 	mddev_t *mddev = mddev_find(dev);
 	struct gendisk *disk;
 	int partitioned = (MAJOR(dev) != MD_MAJOR);
diff -uNrp linux-2.6.15-rc5/drivers/media/common/saa7146_core.c linux-2.6.15-rc5-mutex/drivers/media/common/saa7146_core.c
--- linux-2.6.15-rc5/drivers/media/common/saa7146_core.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/common/saa7146_core.c	2005-12-15 17:14:57.000000000 +0000
@@ -21,7 +21,7 @@
 #include <media/saa7146.h>
 
 LIST_HEAD(saa7146_devices);
-DECLARE_MUTEX(saa7146_devices_lock);
+DECLARE_SEM_MUTEX(saa7146_devices_lock);
 
 static int saa7146_num;
 
diff -uNrp linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-12-15 17:14:57.000000000 +0000
@@ -88,7 +88,7 @@ MODULE_PARM_DESC(dvb_powerdown_on_sleep,
  * FESTATE_LOSTLOCK. When the lock has been lost, and we're searching it again.
  */
 
-static DECLARE_MUTEX(frontend_mutex);
+static DECLARE_SEM_MUTEX(frontend_mutex);
 
 struct dvb_frontend_private {
 
diff -uNrp linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvbdev.c linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvbdev.c
--- linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvbdev.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvbdev.c	2005-12-15 17:14:57.000000000 +0000
@@ -44,7 +44,7 @@ MODULE_PARM_DESC(dvbdev_debug, "Turn on/
 #define dprintk if (dvbdev_debug) printk
 
 static LIST_HEAD(dvb_adapter_list);
-static DECLARE_MUTEX(dvbdev_register_lock);
+static DECLARE_SEM_MUTEX(dvbdev_register_lock);
 
 static const char * const dnames[] = {
         "video", "audio", "sec", "frontend", "demux", "dvr", "ca",
diff -uNrp linux-2.6.15-rc5/drivers/media/video/cx88/cx88-core.c linux-2.6.15-rc5-mutex/drivers/media/video/cx88/cx88-core.c
--- linux-2.6.15-rc5/drivers/media/video/cx88/cx88-core.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/cx88/cx88-core.c	2005-12-15 17:14:57.000000000 +0000
@@ -74,7 +74,7 @@ MODULE_PARM_DESC(nocomb,"disable comb fi
 
 static unsigned int cx88_devcount;
 static LIST_HEAD(cx88_devlist);
-static DECLARE_MUTEX(devlist);
+static DECLARE_SEM_MUTEX(devlist);
 
 /* ------------------------------------------------------------------ */
 /* debug help functions                                               */
diff -uNrp linux-2.6.15-rc5/drivers/media/video/em28xx/em28xx-video.c linux-2.6.15-rc5-mutex/drivers/media/video/em28xx/em28xx-video.c
--- linux-2.6.15-rc5/drivers/media/video/em28xx/em28xx-video.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/em28xx/em28xx-video.c	2005-12-15 17:14:57.000000000 +0000
@@ -184,7 +184,7 @@ static struct v4l2_queryctrl em28xx_qctr
 
 static struct usb_driver em28xx_usb_driver;
 
-static DECLARE_MUTEX(em28xx_sysfs_lock);
+static DECLARE_SEM_MUTEX(em28xx_sysfs_lock);
 static DECLARE_RWSEM(em28xx_disconnect);
 
 /*********************  v4l2 interface  ******************************************/
diff -uNrp linux-2.6.15-rc5/drivers/media/video/saa7134/saa7134-core.c linux-2.6.15-rc5-mutex/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.15-rc5/drivers/media/video/saa7134/saa7134-core.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/saa7134/saa7134-core.c	2005-12-15 17:14:57.000000000 +0000
@@ -83,7 +83,7 @@ MODULE_PARM_DESC(radio_nr, "radio device
 MODULE_PARM_DESC(tuner,    "tuner type");
 MODULE_PARM_DESC(card,     "card type");
 
-static DECLARE_MUTEX(devlist_lock);
+static DECLARE_SEM_MUTEX(devlist_lock);
 LIST_HEAD(saa7134_devlist);
 static LIST_HEAD(mops_list);
 static unsigned int saa7134_devcount;
diff -uNrp linux-2.6.15-rc5/drivers/media/video/saa7134/saa7134-tvaudio.c linux-2.6.15-rc5-mutex/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.15-rc5/drivers/media/video/saa7134/saa7134-tvaudio.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/saa7134/saa7134-tvaudio.c	2005-12-15 17:14:57.000000000 +0000
@@ -970,7 +970,7 @@ int saa7134_tvaudio_getstereo(struct saa
 
 int saa7134_tvaudio_init2(struct saa7134_dev *dev)
 {
-	DECLARE_MUTEX_LOCKED(sem);
+	DECLARE_SEM_MUTEX_LOCKED(sem);
 	int (*my_thread)(void *data) = NULL;
 
 	switch (dev->pci->device) {
diff -uNrp linux-2.6.15-rc5/drivers/media/video/videodev.c linux-2.6.15-rc5-mutex/drivers/media/video/videodev.c
--- linux-2.6.15-rc5/drivers/media/video/videodev.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/videodev.c	2005-12-15 17:14:57.000000000 +0000
@@ -85,7 +85,7 @@ static struct class video_class = {
  */
 
 static struct video_device *video_device[VIDEO_NUM_DEVICES];
-static DECLARE_MUTEX(videodev_lock);
+static DECLARE_SEM_MUTEX(videodev_lock);
 
 struct video_device* video_devdata(struct file *file)
 {
diff -uNrp linux-2.6.15-rc5/drivers/mfd/ucb1x00-core.c linux-2.6.15-rc5-mutex/drivers/mfd/ucb1x00-core.c
--- linux-2.6.15-rc5/drivers/mfd/ucb1x00-core.c	2005-11-01 13:19:09.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mfd/ucb1x00-core.c	2005-12-15 17:14:57.000000000 +0000
@@ -31,7 +31,7 @@
 
 #include "ucb1x00.h"
 
-static DECLARE_MUTEX(ucb1x00_sem);
+static DECLARE_SEM_MUTEX(ucb1x00_sem);
 static LIST_HEAD(ucb1x00_drivers);
 static LIST_HEAD(ucb1x00_devices);
 
diff -uNrp linux-2.6.15-rc5/drivers/mmc/mmc_block.c linux-2.6.15-rc5-mutex/drivers/mmc/mmc_block.c
--- linux-2.6.15-rc5/drivers/mmc/mmc_block.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mmc/mmc_block.c	2005-12-15 17:14:57.000000000 +0000
@@ -56,7 +56,7 @@ struct mmc_blk_data {
 	unsigned int	block_bits;
 };
 
-static DECLARE_MUTEX(open_lock);
+static DECLARE_SEM_MUTEX(open_lock);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
diff -uNrp linux-2.6.15-rc5/drivers/mtd/devices/doc2000.c linux-2.6.15-rc5-mutex/drivers/mtd/devices/doc2000.c
--- linux-2.6.15-rc5/drivers/mtd/devices/doc2000.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mtd/devices/doc2000.c	2005-12-15 17:14:57.000000000 +0000
@@ -975,7 +975,7 @@ static int doc_writev_ecc(struct mtd_inf
 			  u_char *eccbuf, struct nand_oobinfo *oobsel)
 {
 	static char static_buf[512];
-	static DECLARE_MUTEX(writev_buf_sem);
+	static DECLARE_SEM_MUTEX(writev_buf_sem);
 
 	size_t totretlen = 0;
 	size_t thisvecofs = 0;
diff -uNrp linux-2.6.15-rc5/drivers/mtd/mtdcore.c linux-2.6.15-rc5-mutex/drivers/mtd/mtdcore.c
--- linux-2.6.15-rc5/drivers/mtd/mtdcore.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mtd/mtdcore.c	2005-12-15 17:14:57.000000000 +0000
@@ -27,7 +27,7 @@
 
 /* These are exported solely for the purpose of mtd_blkdevs.c. You
    should not use them for _anything_ else */
-DECLARE_MUTEX(mtd_table_mutex);
+DECLARE_SEM_MUTEX(mtd_table_mutex);
 struct mtd_info *mtd_table[MAX_MTD_DEVICES];
 
 EXPORT_SYMBOL_GPL(mtd_table_mutex);
