Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTEVO4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTEVO4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:56:10 -0400
Received: from isp247n.hispeed.ch ([62.2.95.247]:61352 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261916AbTEVO4I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:56:08 -0400
From: Fabiano Sidler <fabianosidler@swissonline.ch>
To: linux-kernel@vger.kernel.org
Subject: Kernel unable to load modules
Date: Thu, 22 May 2003 17:09:09 +0200
User-Agent: KMail/1.5
PGP-key: Chaibs
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305221709.11147.fabianosidler@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all folks!

I hope I'm posting this to the right list:
Recently, I wanted to set up my box to kernel 2.4.20 and I built a kernel as I 
made it many times before. But from now on, my kernels are not longer able to 
load modules. Meanwhile I' ve built kernels with most of gcc versions (2.95.3 
- 3.3) and linux versions 2.4.18 - 20, but without any success. The modutils 
are up to date (gentoo .ebuild) and I removed the modules dir and ran 'make 
mrproper'.

This error I get trying to load a module:
***
root@tinagrar:~ $ modprobe 3c59x
/lib/modules/2.4.20.deever/kernel/drivers/net/3c59x.o: unresolved symbol 
del_timer_sync
/lib/modules/2.4.20.deever/kernel/drivers/net/3c59x.o: unresolved symbol 
xquad_portio
/lib/modules/2.4.20.deever/kernel/drivers/net/3c59x.o: insmod 
/lib/modules/2.4.20.deever/kernel/drivers/net/3c59x.o failed
/lib/modules/2.4.20.deever/kernel/drivers/net/3c59x.o: insmod 3c59x failed
***

While booting the kernel, following problems ocurr:
***...
Ps_execute: method failed - \_SB_.PCI0.SBRG.PS2M._STA (c7f5cee8)
evregion-0302 [-13] Ev_address_space_dispa: Region handler: AE_ERROR 
[PCIConfig]
 dswexec-0392 [-22] Ds_exec_end_op        : [LNot]: Could not resolve 
operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.SBRG.FDC0._STA (c7f5af48)
  uteval-0337 [-29] Ut_execute_STA        : _STA on FDC0 failed AE_ERROR
evregion-0302 [-11] Ev_address_space_dispa: Region handler: AE_ERROR 
[PCIConfig]
 dswexec-0392 [-20] Ds_exec_end_op        : [LNot]: Could not resolve 
operands, AE_ERROR
[10000... times]
...
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.1.1 20010405 on minor 1
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
...
***

That's all I can report, if you need my .config file for autopsy, please ask! 
;) (But I don't think that something is wrong there)

Thank you for helping people!
fps

