Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWIKVxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWIKVxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWIKVxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:53:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:30394 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964952AbWIKVxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:53:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SUGG/cLFRsU/GJ37gWzm0mSN9rLcop2yIt0Ga0LuavHzJ/wZXK+HCIdnUXinlxv29pCWYfNJ/csq6VkJ67IxDq735kKqZmF4Vz+AvJkFfZFodVgyN0nLJQYFEp3F1ZIIp7njG1pWfe08sUEXRhcJzdNkOaRqhhVHaNr5qhObvfc=
Message-ID: <a015f9a00609111453r6da1a66fu12e97a028a26d78d@mail.gmail.com>
Date: Mon, 11 Sep 2006 23:53:50 +0200
From: Karthik <molecularbiophysics@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/vmscan.c:606 invalid opcode: 0000 [#1]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the following a problem with memory or a bug?

Linux-2.6.18-rc6 with suspend2 - version - -2.2.7.5

My Pentium M - 1.6GHz HP laptop. X- windows crashed suddenly and login
window came back again. I logged it but after a few minutes the whole
system froze and I had to hard boot..

Many thanks...

Karthik

--------------------------------------------------

Linux-2.6.18-rc6 with suspend2 - version - -2.2.7.5

Sep 11 20:16:47 rishi kernel: ------------[ cut here ]------------
Sep 11 20:16:47 rishi kernel: kernel BUG at mm/vmscan.c:606!
Sep 11 20:16:47 rishi kernel: invalid opcode: 0000 [#1]
Sep 11 20:16:47 rishi kernel: Modules linked in: button fuse radeon
drm cpufreq_ondemand cpufreq_userspace cpufreq_powersave
speedstep_centrino freq_table ipv6 battery ac edd snd_pcm_oss
snd_mixer_oss snd_seq snd_seq_device pcmcia usbhid ide_cd cdrom 8139cp
mii ohci1394 ieee1394 ipw2200 ieee80211 ieee80211_crypt firmware_class
yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec
snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd
i2c_i801 i2c_core generic i8xx_tco intel_agp agpgart uhci_hcd usbcore
shpchp pci_hotplug parport_pc lp parport capability commoncap dm_mod
reiserfs fan thermal processor piix ide_disk ide_core
Sep 11 20:16:47 rishi kernel: CPU:    0
Sep 11 20:16:47 rishi kernel: EIP:    0060:[<c013f06b>]    Not tainted VLI
Sep 11 20:16:47 rishi kernel: EFLAGS: 00010046   (2.6.18-rc6-06SEPT #1)
Sep 11 20:16:47 rishi kernel: EIP is at isolate_lru_pages+0x30/0xa1
Sep 11 20:16:47 rishi kernel: eax: 00000001   ebx: c0314544   ecx:
c031455c   edx: c031455c
Sep 11 20:16:47 rishi kernel: esi: c031455c   edi: 00000000   ebp:
00000000   esp: dfe9fe48
Sep 11 20:16:47 rishi kernel: ds: 007b   es: 007b   ss: 0068
Sep 11 20:16:47 rishi kernel: Process kswapd0 (pid: 616, ti=dfe9e000
task=dfe7ca90 task.ti=dfe9e000)
Sep 11 20:16:47 rishi kernel: Stack: dfe9ff38 00000020 c0314488
0000008b 000000c7 c0314488 c013f681 dfe9ff40
Sep 11 20:16:47 rishi kernel:        dfe9ff90 00000020 00000000
00000000 00000000 00000000 00000004 00000000
Sep 11 20:16:47 rishi kernel:        00000001 00000001 c128dac0
c12a3900 c12a39c0 c12a3b60 c13df820 c13dde40
Sep 11 20:16:47 rishi kernel: Call Trace:
Sep 11 20:16:47 rishi kernel:  [<c013f681>] shrink_inactive_list+0x6e/0x670
Sep 11 20:16:47 rishi kernel:  [<c0118626>] process_timeout+0x0/0x5
Sep 11 20:16:47 rishi kernel:  [<c013e7ce>] __pagevec_release+0x15/0x1d
Sep 11 20:16:47 rishi kernel:  [<c013f5ac>] shrink_active_list+0x2e9/0x2f1
Sep 11 20:16:47 rishi kernel:  [<c013fd23>] shrink_zone+0xa0/0xbd
Sep 11 20:16:47 rishi kernel:  [<c013ffa0>] kswapd+0x260/0x368
Sep 11 20:16:47 rishi kernel:  [<c01204d8>] autoremove_wake_function+0x0/0x2d
Sep 11 20:16:47 rishi kernel:  [<c013fd40>] kswapd+0x0/0x368
Sep 11 20:16:47 rishi kernel:  [<c01204aa>] kthread+0xac/0xda
Sep 11 20:16:47 rishi kernel:  [<c01203fe>] kthread+0x0/0xda
Sep 11 20:16:47 rishi kernel:  [<c0100ae5>] kernel_thread_helper+0x5/0xb
Sep 11 20:16:47 rishi kernel: Code: ff 56 89 d6 53 53 53 89 44 24 04
89 0c 24 eb 73 8b 4e 04 8d 59 e8 8b 43 1c 39 f0 74 07 83 e8 18 8d 74
26 00 8b 41 e8 a8 20 75 08 <0f> 0b 5e 02 6a 3f 2d c0 8b 11 8b 41 04 89
42 04 89 10 c7 41 04
Sep 11 20:16:47 rishi kernel: EIP: [<c013f06b>]
isolate_lru_pages+0x30/0xa1 SS:ESP 0068:dfe9fe48
