Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUGZLqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUGZLqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUGZLqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 07:46:25 -0400
Received: from mail.bbb2.mdc-berlin.de ([141.80.34.25]:33036 "EHLO
	mail.bbb2.mdc-berlin.de") by vger.kernel.org with ESMTP
	id S265212AbUGZLqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 07:46:21 -0400
Message-ID: <4104EF08.4050006@bioinf.cs.uni-potsdam.de>
Date: Mon, 26 Jul 2004 13:46:16 +0200
From: Juergen Rose <rose@bioinf.cs.uni-potsdam.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Oops modprobing snd_intel8x0 with linux-2.6.7-mm7, linux-2.6.8-rc[1-2]
 under Slackware and Gentoo
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if I try to boot Gentoo with the current kernels (linux-2.6.7-mm4, or 
linux-2.6.8-rc[1-2]) patched for VIA which a need at one PC with a ASUS 
P4P800 mainboard, I get kernel Oops.
With linux-2.6.8-rc2 I get the following output:
...
* Starting pci hotplug...
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm snd_page_alloc 
snd_mpu401_uart snd_rawmidi hw_random ehci_hcd uhci intel_mch_agp 
agpgart evdev sk98li
n
CPU:       0
EIP:         0060:[<c01908295>]    Not tainted
EFLAGS: 00018286      (2.6.8-rc2)
EIP is at create_dir+0x16/0x8b
eax: ...
esi:  ...
ds: ...
Process modprobe (pid: 7692, threadinfo=f64c2000 task=f77d62b0)
Stack: ....
         ....
         ....
[<c0106ce9>] show_stack+0x7a/0x90
[<....           >] show_register+0x...
[<....           >] die+0x....
[<....           >] do_page+0x...
[<....           >] error_code+0x...
[<....           >] sysfs_create_dir+0x...
[<....           >] create_dir
[<....           >] kobject_add
[<....           >] class_device_add
[<....           >] class_simple_device_add
[<....           >] snd_register_device
[<....           >] snd_pcm_dev_register
[<....           >] snd_device_register_all
[<....           >] snd_card_register
[<....           >] snd_intel8x0_probe
[<....           >] pci_device_probe_static
[<....           >] __pci_device_probe
[<....           >] pci_device_probe
[<....           >] bus_match
[<....           >] driver_attach
[<....           >] bus_add_driver
[<....           >] pci_register_driver
[<....           >] alsa_card_intel8x0_init
[<....           >] sys_init_modul
[<....           >] sysenter_past_esp+0x52/0x71
Code: 8b 52 0c 8b 7d 80 8d 42 6c 89 c1 f0 ff 4a 6c 0f 88 b5 83 00
/etc/hotplug/pci_agent: line 157:  7692 Segmentation fault   $MODPROBE 
$MODULE >/dev/null 2>&1
... can't load module snd-intel8x0
missing kernel or user mode driver snd-intel8x0

Which stops booting and computer. CRTL-ALT-DEL works until :
...
* Stopping usb hotplugging...

Then I have to use the power switch. Is there anybody, who found the 
same problem or even knows a patch?

   Regards  Juergen

PS. Please send your answers also to my email address.

