Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268987AbUJKOSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268987AbUJKOSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUJKOSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:18:24 -0400
Received: from smtp09.auna.com ([62.81.186.19]:39412 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S268987AbUJKOSL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:18:11 -0400
Date: Mon, 11 Oct 2004 14:18:10 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Linux 2.6.9-rc4
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1097504290l.6177l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Lets polish it... I get this warnings on build:

  CC      fs/binfmt_elf.o
fs/binfmt_elf.c: In function `padzero':
fs/binfmt_elf.c:113: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result
include/asm/uaccess.h: In function `create_elf_tables':
fs/binfmt_elf.c:175: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
fs/binfmt_elf.c: In function `load_elf_binary':
fs/binfmt_elf.c:758: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result
fs/binfmt_elf.c: In function `fill_psinfo':
fs/binfmt_elf.c:1226: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result

  CC [M]  drivers/ieee1394/raw1394.o
include/asm/uaccess.h: In function `raw1394_read':
drivers/ieee1394/raw1394.c:446: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result

  CC      drivers/pci/msi.o
drivers/pci/msi.c: In function `msi_set_mask_bit':
drivers/pci/msi.c:80: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/pci/msi.c: In function `set_msi_affinity':
drivers/pci/msi.c:121: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/pci/msi.c:126: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/pci/msi.c: In function `msi_free_vector':
drivers/pci/msi.c:838: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/pci/msi.c: In function `reroute_msix_table':
drivers/pci/msi.c:901: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/pci/msi.c:903: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/pci/msi.c:905: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/pci/msi.c:907: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/pci/msi.c:909: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/pci/msi.c:911: warning: passing arg 2 of `writel' makes pointer from integer without a cast

  CC      drivers/scsi/aic7xxx/aic7xxx_osm.o
drivers/scsi/aic7xxx/aic7xxx_osm.c:440: warning: 'aic7xxx' defined but not used
drivers/scsi/aic7xxx/aic7xxx_osm.c:446: warning: 'dummy_buffer' defined but not used

  CC [M]  net/ipv4/netfilter/ip_tables.o
net/ipv4/netfilter/ip_tables.c: In function `do_replace':
net/ipv4/netfilter/ip_tables.c:1133: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


