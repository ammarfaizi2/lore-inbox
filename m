Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUIXA21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUIXA21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIXAOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:14:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:49807 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267578AbUIXAL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:11:57 -0400
Subject: 2.6.9-rc2-mm1 BUG() at pageattr:107
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1095984386.3628.405.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Sep 2004 17:06:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I get following BUG() on 2.6.9-rc2-mm1 on AMD64 box.
Is this known/fixed bug ? Any ideas ?

Thanks,
Badari

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at pageattr:107
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in: ohci_hcd hw_random evdev usbcore dm_mod
Pid: 4032, comm: modprobe Not tainted 2.6.9-rc2-mm1n
RIP: 0010:[<ffffffff80123a12>]
<ffffffff80123a12>{__change_page_attr+1074}
RSP: 0018:00000101be65fbe8  EFLAGS: 00010282
RAX: 0000000000000e80 RBX: 8000000000000163 RCX: 000000000000ce80
RDX: 000001000000ce80 RSI: 0000010000000000 RDI: 000001017fffe040
RBP: 8000000000000163 R08: 0000010000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: 00000100010002a0
R13: 00000100fa000000 R14: 000001000000ce80 R15: 0000010000000000
FS:  0000002a9588e6e0(0000) GS:ffffffff806b1780(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a95d18a28 CR3: 00000001c1362000 CR4: 00000000000006e0
Process modprobe (pid: 4032, threadinfo 00000101be65e000, task
000001017a107030)
Stack: 00000100046b0000 0000000000000000 0000000000000000
0000000000000002
       8000000000000163 ffffffff80123afc 000001017aed0180
ffffff0000594000
       000001017aed0180 00000100dfeb8870
Call Trace:<ffffffff80123afc>{change_page_attr+156}
<ffffffff80122f4c>{iounmap+3
64}
       <ffffffffa001b711>{:usbcore:usb_hcd_pci_remove+225}
       <ffffffffa001bcaf>{:usbcore:usb_hcd_pci_probe+1247}
       <ffffffff802d59f9>{pci_device_probe+121}
<ffffffff8032dd27>{bus_match+71}
  
       <ffffffff8032de86>{driver_attach+70}
<ffffffff8032df5d>{bus_add_driver+14
1}
       <ffffffff802d5d21>{pci_register_driver+113}
<ffffffffa0043032>{:ohci_hcd:
ohci_hcd_pci_init+50}
       <ffffffff80152bbf>{sys_init_module+6495}
<ffffffff80173484>{free_pages_an
d_swap_cache+116}
       <ffffffffa0043000>{:ohci_hcd:ohci_hcd_pci_init+0}
<ffffffff8016ea46>{do_m
unmap+918}
       <ffffffff8044e571>{__down_read+49}
<ffffffff802cc840>{__up_write+48}
       <ffffffff8011075e>{system_call+126}
 
Code: 0f 0b c4 4b 47 80 ff ff ff ff 6b 00 48 89 e9 48 b8 ff ff ff
RIP <ffffffff80123a12>{__change_page_attr+1074} RSP <00000101be65fbe8>


