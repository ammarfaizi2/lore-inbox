Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSJXIv6>; Thu, 24 Oct 2002 04:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265356AbSJXIv6>; Thu, 24 Oct 2002 04:51:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:275 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265355AbSJXIv4>; Thu, 24 Oct 2002 04:51:56 -0400
Message-Id: <200210240853.g9O8qwp08460@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: EISA AIC7XXX not detected
Date: Thu, 24 Oct 2002 11:45:23 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200210231448.g9NEmJp04017@Port.imtp.ilyichevsk.odessa.ua> <365640000.1035385777@aslan.btc.adaptec.com>
In-Reply-To: <365640000.1035385777@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 October 2002 13:09, Justin T. Gibbs wrote:
> > Hi,
> >
> > I have an oldie Pentium 66 box which was running OS/2
> > for a very long time. Probably the last OS/2 box in our town :)
> >
> > I want to convert it into backup web server.
> >
> > The problem is that it does not see its disks when I boot Linux.
> > Currently I'm running it in NFS root mode, but 16MB RAM is not
> > much fun without swap :(
> >
> > I'd like to stick printks here and there in driver source,
> > thought you may have some advice.
>
> Since you seem to have enabled the EISA/VLB probe in your config,
> I don't know why your controller is not probed.

I sticked some printks in the code, here is a new syslog output
(diff with printks is an the end).

Oct 21 02:31:50 guard kernel: SCSI subsystem driver Revision: 1.00
Oct 21 02:31:50 guard kernel: vda: ahc_linux_detect(): 1
Oct 21 02:31:50 guard kernel: vda: ahc_linux_detect(): 2
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x1c00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x2c00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x3c00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x4c00
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: id=0x4907782
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: entry->full_id entry->id_mask id&entry->id_mask
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907771         0xffffffff         0x4907782
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907756         0xfffffffe         0x4907782
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907770         0xffffffff         0x4907782

seems my controller is not considered compatible ;)

Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: aic7770_find_device failed
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x5c00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x6c00
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: id=0x506d5093
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: entry->full_id entry->id_mask id&entry->id_mask
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907771         0xffffffff         0x506d5093
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907756         0xfffffffe         0x506d5092
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907770         0xffffffff         0x506d5093
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: aic7770_find_device failed
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x7c00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x8c00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0x9c00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0xac00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0xbc00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0xcc00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0xdc00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0xec00
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: no EISA card in slot
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: probing 0xfc00
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: id=0x3d891271
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: entry->full_id entry->id_mask id&entry->id_mask
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907771         0xffffffff         0x3d891271
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907756         0xfffffffe         0x3d891270
Oct 21 02:31:51 guard kernel: vda: aic7770_find_device: 0x4907770         0xffffffff         0x3d891271
Oct 21 02:31:51 guard kernel: vda: aic7770_linux_probe: aic7770_find_device failed
Oct 21 02:31:51 guard kernel: vda: ahc_linux_detect(): 3
Oct 21 02:31:51 guard kernel: kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Oct 21 02:31:51 guard kernel: NET4: Linux TCP/IP 1.0 for NET4.0

diff -u --recursive linux-2.4.19net3.orig/drivers/scsi/aic7xxx/aic7770.c linux-2.4.19net3/drivers/scsi/aic7xxx/aic7770.c
--- linux-2.4.19net3.orig/drivers/scsi/aic7xxx/aic7770.c	Fri Aug  2 22:39:44 2002
+++ linux-2.4.19net3/drivers/scsi/aic7xxx/aic7770.c	Thu Oct 24 09:21:20 2002
@@ -93,8 +93,13 @@
 	struct	aic7770_identity *entry;
 	int	i;
 
+		printk(KERN_DEBUG "vda: aic7770_find_device: id=0x%04x\n",id);
+		printk(KERN_DEBUG "vda: aic7770_find_device: entry->full_id entry->id_mask id&entry->id_mask\n");
 	for (i = 0; i < ahc_num_aic7770_devs; i++) {
 		entry = &aic7770_ident_table[i];
+		printk(KERN_DEBUG "vda: aic7770_find_device: 0x%04x         0x%04x         0x%04x\n",
+							     entry->full_id,entry->id_mask,id&entry->id_mask
+							);
 		if (entry->full_id == (id & entry->id_mask))
 			return (entry);
 	}
diff -u --recursive linux-2.4.19net3.orig/drivers/scsi/aic7xxx/aic7770_osm.c linux-2.4.19net3/drivers/scsi/aic7xxx/aic7770_osm.c
--- linux-2.4.19net3.orig/drivers/scsi/aic7xxx/aic7770_osm.c	Fri Aug  2 22:39:44 2002
+++ linux-2.4.19net3/drivers/scsi/aic7xxx/aic7770_osm.c	Thu Oct 24 09:12:05 2002
@@ -58,11 +58,14 @@
 	eisaBase = 0x1000 + AHC_EISA_SLOT_OFFSET;
 	found = 0;
 	for (slot = 1; slot < NUMSLOTS; eisaBase+=0x1000, slot++) {
+		printk(KERN_DEBUG "vda: aic7770_linux_probe: probing 0x%04x\n",eisaBase);
 		uint32_t eisa_id;
 		size_t	 id_size;
 
-		if (check_region(eisaBase, AHC_EISA_IOSIZE) != 0)
+		if (check_region(eisaBase, AHC_EISA_IOSIZE) != 0) {
+			printk(KERN_DEBUG "vda: aic7770_linux_probe: check_region failed\n");
 			continue;
+		}
 
 		eisa_id = 0;
 		id_size = sizeof(eisa_id);
@@ -72,10 +75,14 @@
 			eisa_id |= inb(eisaBase + IDOFFSET + i)
 				   << ((id_size-i-1) * 8);
 		}
-		if (eisa_id & 0x80000000)
+		if (eisa_id & 0x80000000) {
+			printk(KERN_DEBUG "vda: aic7770_linux_probe: no EISA card in slot\n");
 			continue;  /* no EISA card in slot */
+		}

 		entry = aic7770_find_device(eisa_id);
+		if (entry == NULL)
+			printk(KERN_DEBUG "vda: aic7770_linux_probe: aic7770_find_device failed\n");
 		if (entry != NULL) {
 			char	 buf[80];
 			char	*name;
@@ -88,8 +95,10 @@
 			 */
 			sprintf(buf, "ahc_eisa:%d", slot);
 			name = malloc(strlen(buf) + 1, M_DEVBUF, M_NOWAIT);
-			if (name == NULL)
+			if (name == NULL) {
+				printk(KERN_DEBUG "vda: aic7770_linux_probe: malloc failed\n");
 				break;
+			}
 			strcpy(name, buf);
 			ahc = ahc_alloc(template, name);
 			if (ahc == NULL) {
@@ -98,12 +107,14 @@
 				 * chances are we won't be able to
 				 * allocate future card structures.
 				 */
+				printk(KERN_DEBUG "vda: aic7770_linux_probe: ahc_alloc failed\n");
 				break;
 			}
 			error = aic7770_config(ahc, entry, eisaBase);
 			if (error != 0) {
 				ahc->bsh.ioport = 0;
 				ahc_free(ahc);
+				printk(KERN_DEBUG "vda: aic7770_linux_probe: aic7770_config failed\n");
 				continue;
 			}
 			found++;
diff -u --recursive linux-2.4.19net3.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.4.19net3/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.4.19net3.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	Fri Aug  2 22:39:44 2002
+++ linux-2.4.19net3/drivers/scsi/aic7xxx/aic7xxx_osm.c	Thu Oct 24 09:03:53 2002
@@ -1116,6 +1116,7 @@
 	 * this lock just prior to calling us.
 	 */
 	spin_unlock_irq(&io_request_lock);
+	printk(KERN_DEBUG "vda: ahc_linux_detect(): 1\n");
 
 	/*
 	 * Sanity checking of Linux SCSI data structures so
@@ -1167,8 +1168,10 @@
 	ahc_linux_pci_probe(template);
 #endif
 
+	printk(KERN_DEBUG "vda: ahc_linux_detect(): 2\n");
 	if (aic7xxx_no_probe == 0)
 		aic7770_linux_probe(template);
+	printk(KERN_DEBUG "vda: ahc_linux_detect(): 3\n");

 	/*
 	 * Register with the SCSI layer all

