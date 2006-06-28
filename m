Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWF1Xep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWF1Xep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWF1Xep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:34:45 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:31317 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751664AbWF1Xeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:34:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZnfxPOYzUuAbCC5InkrVImsmZXnZ2oImch3lx+yZj5Fsyig6z2jloZKhHzEfnIHKZPRiZ+SqfRdCKjBH4tmFEmIDjLZdLwEx0HZDjHG+qkOCi6YiDM9weLpS5rk0eLqfzXccOMhwZwmDHXv9E0jIjqPGso5hJ6LbtOQMp/UyvJ0=
Message-ID: <a44ae5cd0606281634o45795e89y8789e670448f52e3@mail.gmail.com>
Date: Wed, 28 Jun 2006 16:34:43 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm3 -- NULL pointer dereference at virtual address 00000020 / EIP is at prism2_registers_proc_read+0x22/0x2ff [hostap_cs]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000020
 printing eip:
f8d21f6e
*pde = 00000000
Oops: 0000 [#1]
4K_STACKS PREEMPT
last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed
Modules linked in: sg sd_mod usb_storage libusual pcnet_cs 8390
aha152x_cs scsi_transport_spi ohci_hcd hostap_cs hostap binfmt_misc
i915 drm ipv6 speedstep_centrino cpufreq_powersave cpufreq_performance
cpufreq_conservative video thermal button nls_ascii nls_cp437 vfat fat
nls_utf8 ntfs nls_base md_mod sr_mod sbp2 scsi_mod parport_pc lp
parport snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer ehci_hcd pcspkr evdev iTCO_wdt sdhci
mmc_core uhci_hcd usbcore psmouse snd ipw2200 rtc intel_agp agpgart
ohci1394 ieee1394 soundcore snd_page_alloc 8139too
CPU:    0
EIP:    0060:[<f8d21f6e>]    Not tainted VLI
EFLAGS: 00210246   (2.6.17-mm3miles #15)
EIP is at prism2_registers_proc_read+0x22/0x2ff [hostap_cs]
eax: 00000000   ebx: f8d21f4c   ecx: 00000000   edx: e884ef64
esi: d5bd04e4   edi: db8ce000   ebp: e884ef38   esp: e884ef2c
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 2219, ti=e884e000 task=cdd3e870 task.ti=e884e000)
Stack: f8d21f4c 00000400 db8ce000 e884ef78 c1090c8b 00000400 e884ef68 d5bd04e4
       00000400 0806c000 cac1123c 00000000 00000400 f7b6b838 00000000 00000000
       dc8ff844 c1090b8c 0806c000 e884ef94 c105fe38 e884efa0 00000400 dc8ff844
Call Trace:
 [<c1090c8b>] proc_file_read+0xff/0x218
 [<c105fe38>] vfs_read+0xa9/0x158
 [<c1060207>] sys_read+0x3b/0x60
 [<c1002d6d>] sysenter_past_esp+0x56/0x8d
Code: c8 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 57 56 53 89 c7 8b 75 10 85
c9 74 10 8b 45 0c c7 00 01 00 00 00 31 c0 e9 d8 02 00 00 8b 46 14 <8b>
50 20 66 ed 0f b7 c0 50 68 03 4a d2 f8 57 e8 42 46 3d c8 8d
EIP: [<f8d21f6e>] prism2_registers_proc_read+0x22/0x2ff [hostap_cs]
SS:ESP 0068:e884ef2c
