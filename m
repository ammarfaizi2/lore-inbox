Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVCSTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVCSTTV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVCSTTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 14:19:20 -0500
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:7609 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S262653AbVCSTRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 14:17:25 -0500
Message-ID: <423C7AB5.2010200@jg555.com>
Date: Sat, 19 Mar 2005 11:17:09 -0800
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Build issue current MIPS - RaQ2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not been able to build kernels since 2.6.9 on my RaQ2 for some 
time. I have tried the linux-mips.org port and the current 2.6.11.5 
release. I keep getting the same error.

  Building modules, stage 2.
  MODPOST
*** Warning: "pci_iounmap" [drivers/net/tulip/tulip.ko] undefined!
*** Warning: "pci_iomap" [drivers/net/tulip/tulip.ko] undefined!

with Make V=1
  Building modules, stage 2.
make -rR -f /usr/src/linux-2.6.11.5/scripts/Makefile.modpost
  scripts/mod/modpost   -o /usr/src/linux-2.6.11.5/Module.symvers 
vmlinux drivers/block/loop.o drivers/block/rd.o drivers/cdrom/cdrom.o 
drivers/char/rtc.o drivers/net/tulip/tulip.o drivers/scsi/scsi_mod.o 
drivers/scsi/scsi_transport_spi.o drivers/scsi/sd_mod.o 
drivers/scsi/sr_mod.o drivers/scsi/st.o 
drivers/scsi/sym53c8xx_2/sym53c8xx.o fs/exportfs/exportfs.o 
fs/isofs/isofs.o fs/lockd/lockd.o fs/nfs/nfs.o fs/nfsd/nfsd.o 
fs/nls/nls_ascii.o fs/nls/nls_base.o fs/nls/nls_cp437.o 
fs/nls/nls_iso8859-1.o fs/nls/nls_utf8.o fs/smbfs/smbfs.o lib/crc32.o 
lib/zlib_inflate/zlib_inflate.o net/key/af_key.o 
net/netlink/netlink_dev.o net/packet/af_packet.o net/sunrpc/sunrpc.o 
net/unix/unix.o
*** Warning: "pci_iounmap" [drivers/net/tulip/tulip.ko] undefined!
*** Warning: "pci_iomap" [drivers/net/tulip/tulip.ko] undefined!

Now it seems to me that the Makefile.modpost would need to include 
arch/mips/lib/iomap.o file to correct this issue, but that doesn't seem 
like the correct thing to do, and I have no clue on how to do that.

-- 
----
Jim Gifford
maillist@jg555.com

