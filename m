Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVFTIAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVFTIAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 04:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVFTIAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 04:00:22 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:41164 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261494AbVFTIAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 04:00:12 -0400
Message-ID: <42B6777F.2050008@ens-lyon.org>
Date: Mon, 20 Jun 2005 09:59:59 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20.06.2005 08:30, Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> 
> 
> - Someone broke /proc/device-tree on ppc64.  It's being looked into.
> 
> - Nothing particularly special here - various fixes and updates.

Hi Andrew,

I got this oops during boot.
I copied it by hand since my machine crashed soon after (because of yenta).
It doesn't occur when snd_maestro3 is skipped by discover.

divide error: 0000 [#1]
PREEMPT
...
CPU: 0
EIP: 0060:[<e8957f9f>] Not tainted VLI
EFLAGS: 00000282 (2.6.12-mm1=LoulousMobiles)
EIP is at and_m3_enable_ints+0x1f/0x40 [snd_maestro3]
eax: 00000050 ebx: 00002400 ecx: 00000050 edx: 00002418
esi: 00002418 edi: 00000000 ebp: 000000f0 esp: e6f5ce54
ds: 007b es: 007b ss: 0068
Process modprobe (pid: 2405, threadinfo=e6f5c000, task=e7a31570)
...
Call trace:
 snd_m3_create+0x303/0x405 [snd_maestro3]
 snd_m3_probe+0xev/0x1c0 [snd_maestro3]
 pci_device_probe_static+0x52/0x70
 __pci_deice_probe+0x3c/0x50
 pci_device_prove+0x2f/0x50
 driver_probe_device+0x38/0xb0
 __driver_attach+0x0/0x50
 __driver_attach+0x47/0x50
 bus_for_each_dev+0x69/0x80
 driver_attach+0x25/0x30
 __driver_attach+0x0/0x50
 bus_add_driver+0x88/0xc0
 pci_device_shutdown+0x0/0x30
 pci_register_driver+0x71/0x90
 alsa_card_m3_init+0xf/0x11 [snd_maestro3]
 sys_init_module+0x165/0x220
 syscall_call+0x7/0xb
...

Regards,
Brice
