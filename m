Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWGRDtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWGRDtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWGRDtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:49:22 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:39575 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S1751215AbWGRDtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:49:21 -0400
Message-ID: <44BC5A3F.2080005@stanford.edu>
Date: Mon, 17 Jul 2006 20:49:19 -0700
From: Thomas Dillig <tdillig@stanford.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Null dereference errors in the kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are PhD students at Stanford University working on a static analysis 
project called SATURN (http://glide.stanford.edu/saturn). We have 
implemented a checker that finds potential null dereference errors and 
ran our tool on the kernel version 2.6.17.1. We have identified around 
300 potential issues related to null errors, and we've included 20 
sample reports below. If you would be interested, we can post all the 
issues we found. Also, we apologize in advance if we aren't supposed to 
post these error reports here, and we are happy to submit bug reports 
elsewhere if you tell us where to post these.

Thanks,
Thomas & Isil Dillig



Error reports:


[1]
790 drivers/video/modedb.c
NULL dereference of variable "best"


[2]
6538 drivers/scsi/aic7xxx/aic7xxx_core.c
Possible null dereference of variable "cur_column" checked for NULL at 
(6531:drivers/scsi/aic7xxx/aic7xxx_core.c)


[3]
46 sound/isa/sb/sb8_midi.c
NULL dereference of variable "chip" (inside macro SBP() )


[4]
239 drivers/usb/misc/usblcd.c
NULL dereference of variable "urb".


[5]
916 drivers/char/specialix.c
Possible null dereference of "bp" checked for NULL at 
(917:drivers/char/specialix.c). Dereferenced through call chain 
(drivers/char/specialix.c:sx_get_port, drivers/char/specialix.c:sx_in)


[6]
1196, 1201, 1204,... drivers/net/irda/donauboe.c
Possible null dereference of variable "self" checked for NULL at 
(1170:drivers/net/irda/donauboe.c)


[7]
144 drivers/char/agp/ati-agp.c
NULL dereference of variable "ati_generic_private.gatt_pages" in 
function call (drivers/char/agp/ati-agp.c:ati_free_gatt_pages).


[8]
816 net/decnet/dn_route.c
Possible null dereference of variable "rt->u.dst.dev" checked for NULL 
at (809:net/decnet/dn_route.c) and aliased as variable "dev".


[9]
100 drivers/mtd/maps/ts5500_flash.c
NULL dereference of variable of "mymtd" in function call (map_destroy).


[10]
1092, 1093, 1115 drivers/net/bonding/bond_sysfs.c
Possible null dereference of variable "slave" checked for NULL at 
(1097:drivers/net/bonding/bond_sysfs.c), aliased as variable "new_active".


[11]
512, 513 fs/ntfs/attrib.c
Possible null dereference of variable "ctx" checked for NULL at 
(474:fs/ntfs/attrib.c).


[12]
562, 563 drivers/ide/pci/pdc202xx_old.c
Possible null dereference of variable "hwif" checked for NULL at 
(565:drivers/ide/pci/pdc202xx_old.c).


[13]
1176, 1180 drivers/char/isicom.c
Possible null dereference of variable "tty" checked for NULL at 
(1183:drivers/char/isicom.c).


[14]
1230, 1232 drivers/scsi/tmscsim.c
Possible null dereference of variable "psgl" checked for NULL at 
(1249:drivers/scsi/tmscsim.c), aliased as "pcmd->request_buffer".


[15]
680 drivers/net/3c505.c
Possible null dereference  of variable "adapter->current_dma.skb" in 
function call (include/linux/netdevice.h:dev_kfree_skb_irq) checked at 
(688:drivers/net/3c505.c), aliased as variable "skb".


[16]
965 drivers/net/tulip/dmfe.c
NULL dereference of variable "skb".


[17]
730 drivers/net/hamradio/6pack.c
Possible null dereference of variable "sp" checked for NULL at 
(733:drivers/net/hamradio/6pack.c).


[18]
405 drivers/acpi/dispatcher/dswload.c
Possible null dereference of variable "op->common.value.arg" checked for 
NULL at (418:drivers/acpi/dispatcher/dswload.c).

[19]
639 fs/cifs/readdir.c
Possible null dereference of variable 
"cifsFile->srch_inf.ntwrk_buf_start" in function call (smbCalcSize), 
checked for NULL at (610:fs/cifs/readdir.c).


[20]
197, 198 fs/ocfs2/aops.c
Possible null dereference of variable "page" checked for NULL at 
(201:fs/ocfs2/aops.c).
