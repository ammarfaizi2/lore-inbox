Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbTFMWIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbTFMWIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:08:10 -0400
Received: from 216-243-106-114.lobo.net ([216.243.106.114]:4663 "EHLO
	MAIL.INTEGRITY.COM") by vger.kernel.org with ESMTP id S265550AbTFMWIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:08:00 -0400
Message-ID: <3EEA4E52.4080205@integrityns.com>
Date: Fri, 13 Jun 2003 16:21:06 -0600
From: Fred Feirtag <ffeirtag@integrityns.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Modular IDE Build Failing Without Modular Generic PCI bus-master
 DMA support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2003 22:21:47.0298 (UTC) FILETIME=[2D974820:01C331FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.4.20, "Generic PCI bus-master DMA support"
could be built into the kernel (modular was never an option),
and IDE could link modular, as for use in an OS-less
NFS/Samba file server.  Is modular IDE with DMA still broken,
since Generic PCI bus-master DMA support can't be a module?

--Fred  ffeirtag@integrityns.com

make modules_install
...
cd /lib/modules/2.4.21-diskless; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.21-diskless; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.21-diskless/kernel/drivers/ide/ide-disk.o
depmod:         ide_remove_proc_entries_Rsmp_6a41216a
depmod:         proc_ide_read_geometry_Rsmp_50fed6f7
depmod: *** Unresolved symbols in /lib/modules/2.4.21-diskless/kernel/drivers/ide/ide-floppy.o
depmod:         ide_remove_proc_entries_Rsmp_6a41216a
depmod:         proc_ide_read_geometry_Rsmp_50fed6f7
depmod: *** Unresolved symbols in /lib/modules/2.4.21-diskless/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         create_proc_ide_interfaces_Rsmp_ab2c600e
depmod: *** Unresolved symbols in /lib/modules/2.4.21-diskless/kernel/drivers/ide/ide-tape.o
depmod:         ide_remove_proc_entries_Rsmp_6a41216a
depmod: *** Unresolved symbols in /lib/modules/2.4.21-diskless/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         proc_ide_create_Rsmp_a8e0f104
depmod:         ide_remove_proc_entries_Rsmp_6a41216a
depmod:         destroy_proc_ide_drives_Rsmp_6b7f1fed
depmod:         ide_add_proc_entries_Rsmp_3269dc46
depmod:         ide_scan_pcibus
depmod:         create_proc_ide_interfaces_Rsmp_ab2c600e
depmod:         proc_ide_read_capacity_Rsmp_46b2a30d
depmod:         proc_ide_destroy_Rsmp_35e1351c
[root@linux linux-diskless]#




