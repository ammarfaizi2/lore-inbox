Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWIVUxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWIVUxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWIVUxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:53:21 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:58511 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750784AbWIVUxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:53:20 -0400
Message-ID: <45144D3D.4010400@freescale.com>
Date: Fri, 22 Sep 2006 15:53:17 -0500
From: Timur Tabi <timur@freescale.com>
Organization: Freescale
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "qc timeout" error in sata_sil 3114 driver, 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a new PowerPC board (8349 based) with a Silicon Image 3114 SATA controller
connected to a Hitachi drive.  When the sata_sil driver loads and tries to find the device,
I get "qc timeout" errors.  I don't know a lot about SATA.  Can anyone give me a clue as
to what could be wrong?

[    9.434695] sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
[    9.442102] ata_device_add: ENTER
[    9.445425] ata_host_add: ENTER
[    9.448749] ata_port_start: prd alloc, virt c0583000, dma 583000
[    9.454767] ata1: SATA max UDMA/100 cmd 0xD100E080 ctl 0xD100E08A bmdma 0xD100E000 irq 22
[    9.462948] __ata_port_freeze: ata1 port frozen
[    9.467471] ata_host_add: ENTER
[    9.470732] ata_port_start: prd alloc, virt cff55000, dma ff55000
[    9.476830] ata2: SATA max UDMA/100 cmd 0xD100E0C0 ctl 0xD100E0CA bmdma 0xD100E008 irq 22
[    9.485000] __ata_port_freeze: ata2 port frozen
[    9.489522] ata_host_add: ENTER
[    9.492782] ata_port_start: prd alloc, virt c05d4000, dma 5d4000
[    9.498794] ata3: SATA max UDMA/100 cmd 0xD100E280 ctl 0xD100E28A bmdma 0xD100E200 irq 22
[    9.506965] __ata_port_freeze: ata3 port frozen
[    9.511487] ata_host_add: ENTER
[    9.514749] ata_port_start: prd alloc, virt c05d6000, dma 5d6000
[    9.520759] ata4: SATA max UDMA/100 cmd 0xD100E2C0 ctl 0xD100E2CA bmdma 0xD100E208 irq 22
[    9.528930] __ata_port_freeze: ata4 port frozen
[    9.533470] ata_device_add: probe begin
[    9.537301] scsi0 : sata_sil
[    9.540416] ata_port_schedule_eh: port EH scheduled
[    9.545313] ata_scsi_error: ENTER
[    9.548623] ata_port_flush_task: ENTER
[    9.552375] ata_port_flush_task: flush #1
[    9.556404] ata_eh_autopsy: ENTER
[    9.559716] ata_eh_recover: ENTER
[    9.563038] ata_eh_prep_resume: ENTER
[    9.566693] ata_eh_prep_resume: EXIT
[    9.570262] __ata_port_freeze: ata1 port frozen
[    9.886275] ata_std_softreset: ENTER
[    9.889842] ata_std_softreset: EXIT, classes[0]=5 [1]=0
[    9.895061] ata_std_postreset: ENTER
[    9.898632] ata1: SATA link down (SStatus 0 SControl 310)
[    9.904023] ata_std_postreset: EXIT, no device
[    9.908461] ata_eh_thaw_port: ata1 port thawed
[    9.912896] ata_eh_revalidate_and_attach: ENTER
[    9.917419] ata_eh_revalidate_and_attach: EXIT
[    9.921854] ata_eh_resume: ENTER
[    9.925075] ata_eh_resume: EXIT
[    9.928210] ata_eh_suspend: ENTER
[    9.931518] ata_eh_suspend: EXIT
[    9.934739] ata_eh_recover: EXIT, rc=0
[    9.938485] ata_scsi_error: EXIT
[    9.941709] scsi1 : sata_sil
[    9.944792] ata_port_schedule_eh: port EH scheduled
[    9.949688] ata_scsi_error: ENTER
[    9.952999] ata_port_flush_task: ENTER
[    9.956750] ata_port_flush_task: flush #1
[    9.960778] ata_eh_autopsy: ENTER
[    9.964093] ata_eh_recover: ENTER
[    9.967413] ata_eh_prep_resume: ENTER
[    9.971069] ata_eh_prep_resume: EXIT
[    9.974639] __ata_port_freeze: ata2 port frozen
[   10.290287] ata_std_softreset: ENTER
[   10.293861] ata_std_softreset: about to softreset, devmask=1
[   10.299515] ata_bus_softreset: ata2: bus reset via SRST
[   10.458293] ata_dev_classify: found ATA device by sig
[   10.463338] ata_std_softreset: EXIT, classes[0]=1 [1]=0
[   10.468556] ata_std_postreset: ENTER
[   10.472128] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   10.478303] ata_std_postreset: EXIT
[   10.481784] ata_eh_thaw_port: ata2 port thawed
[   10.486220] ata_eh_revalidate_and_attach: ENTER
[   10.490760] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[   10.496700] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[   10.502654] ata_exec_command_mmio: ata2: cmd 0xEC
[   40.506276] ata_port_flush_task: ENTER
[   40.510020] ata_port_flush_task: flush #1
[   40.514055] __ata_port_freeze: ata2 port frozen
[   40.518576] ata2.00: qc timeout (cmd 0xec)
[   40.522673] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   40.528758] ata_eh_revalidate_and_attach: EXIT
[   41.034273] ata_eh_prep_resume: ENTER
[   41.037925] ata_eh_prep_resume: EXIT
[   41.041495] __ata_port_freeze: ata2 port frozen
[   41.046020] sata_std_hardreset: ENTER
[   41.366292] ata_dev_classify: found ATA device by sig
[   41.371336] sata_std_hardreset: EXIT, class=1
[   41.375686] ata_std_postreset: ENTER
[   41.379258] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   41.385430] ata_std_postreset: EXIT
[   41.388913] ata_eh_thaw_port: ata2 port thawed
[   41.393349] ata_eh_revalidate_and_attach: ENTER
[   41.397887] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[   41.403827] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[   41.409770] ata_exec_command_mmio: ata2: cmd 0xEC
[   71.414275] ata_port_flush_task: ENTER
[   71.418016] ata_port_flush_task: flush #1
[   71.422049] __ata_port_freeze: ata2 port frozen
[   71.426570] ata2.00: qc timeout (cmd 0xec)
[   71.430666] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   71.436751] ata_eh_revalidate_and_attach: EXIT
[   71.942273] ata_eh_prep_resume: ENTER
[   71.945925] ata_eh_prep_resume: EXIT
[   71.949496] __ata_port_freeze: ata2 port frozen
[   71.954021] sata_std_hardreset: ENTER
[   72.274292] ata_dev_classify: found ATA device by sig
[   72.279338] sata_std_hardreset: EXIT, class=1
[   72.283688] ata_std_postreset: ENTER
[   72.287260] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   72.293433] ata_std_postreset: EXIT
[   72.296917] ata_eh_thaw_port: ata2 port thawed
[   72.301353] ata_eh_revalidate_and_attach: ENTER
[   72.305890] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[   72.311831] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[   72.317774] ata_exec_command_mmio: ata2: cmd 0xEC
[  102.322275] ata_port_flush_task: ENTER
[  102.326017] ata_port_flush_task: flush #1
[  102.330051] __ata_port_freeze: ata2 port frozen
[  102.334572] ata2.00: qc timeout (cmd 0xec)
[  102.338668] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  102.344753] ata_eh_revalidate_and_attach: EXIT
[  102.850273] ata_eh_prep_resume: ENTER
[  102.853926] ata_eh_prep_resume: EXIT
[  102.857495] __ata_port_freeze: ata2 port frozen
[  102.862020] sata_std_hardreset: ENTER
[  103.182291] ata_dev_classify: found ATA device by sig
[  103.187335] sata_std_hardreset: EXIT, class=1
[  103.191685] ata_std_postreset: ENTER
[  103.195257] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  103.201431] ata_std_postreset: EXIT
[  103.204915] ata_eh_thaw_port: ata2 port thawed
[  103.209351] ata_eh_revalidate_and_attach: ENTER
[  103.213874] ata_eh_revalidate_and_attach: EXIT
[  103.218311] ata_eh_resume: ENTER
[  103.221529] ata_eh_resume: EXIT
[  103.224664] ata_eh_suspend: ENTER
[  103.227972] ata_eh_suspend: EXIT
[  103.231194] ata_eh_recover: EXIT, rc=0
[  103.234942] ata_scsi_error: EXIT
[  103.238169] scsi2 : sata_sil
[  103.241320] ata_port_schedule_eh: port EH scheduled
[  103.246219] ata_scsi_error: ENTER
[  103.249530] ata_port_flush_task: ENTER
[  103.253282] ata_port_flush_task: flush #1
[  103.257311] ata_eh_autopsy: ENTER
[  103.260623] ata_eh_recover: ENTER
[  103.263944] ata_eh_prep_resume: ENTER
[  103.267600] ata_eh_prep_resume: EXIT
[  103.271171] __ata_port_freeze: ata3 port frozen
[  103.586275] ata_std_softreset: ENTER
[  103.589843] ata_std_softreset: EXIT, classes[0]=5 [1]=0
[  103.595062] ata_std_postreset: ENTER
[  103.598633] ata3: SATA link down (SStatus 0 SControl 310)
[  103.604024] ata_std_postreset: EXIT, no device
[  103.608462] ata_eh_thaw_port: ata3 port thawed
[  103.612898] ata_eh_revalidate_and_attach: ENTER
[  103.617421] ata_eh_revalidate_and_attach: EXIT
[  103.621857] ata_eh_resume: ENTER
[  103.625078] ata_eh_resume: EXIT
[  103.628213] ata_eh_suspend: ENTER
[  103.631521] ata_eh_suspend: EXIT
[  103.634742] ata_eh_recover: EXIT, rc=0
[  103.638489] ata_scsi_error: EXIT
[  103.641714] scsi3 : sata_sil
[  103.644807] ata_port_schedule_eh: port EH scheduled
[  103.649704] ata_scsi_error: ENTER
[  103.653015] ata_port_flush_task: ENTER
[  103.656766] ata_port_flush_task: flush #1
[  103.660796] ata_eh_autopsy: ENTER
[  103.664108] ata_eh_recover: ENTER
[  103.667430] ata_eh_prep_resume: ENTER
[  103.671086] ata_eh_prep_resume: EXIT
[  103.674657] __ata_port_freeze: ata4 port frozen
[  103.990276] ata_std_softreset: ENTER
[  103.993846] ata_std_softreset: EXIT, classes[0]=5 [1]=0
[  103.999066] ata_std_postreset: ENTER
[  104.002638] ata4: SATA link down (SStatus 0 SControl 310)
[  104.008030] ata_std_postreset: EXIT, no device
[  104.012468] ata_eh_thaw_port: ata4 port thawed
[  104.016904] ata_eh_revalidate_and_attach: ENTER
[  104.021427] ata_eh_revalidate_and_attach: EXIT
[  104.025862] ata_eh_resume: ENTER
[  104.029083] ata_eh_resume: EXIT
[  104.032219] ata_eh_suspend: ENTER
[  104.035526] ata_eh_suspend: EXIT
[  104.038748] ata_eh_recover: EXIT, rc=0
[  104.042497] ata_scsi_error: EXIT
[  104.045722] ata_device_add: host probe begin
[  104.049988] ata_device_add: EXIT, returning 4

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
