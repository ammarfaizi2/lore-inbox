Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVKMXwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKMXwW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 18:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKMXwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 18:52:22 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:30657 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1750795AbVKMXwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 18:52:21 -0500
Message-ID: <4377D1B2.8070003@rtr.ca>
Date: Sun, 13 Nov 2005 18:52:18 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc1: kswapd crash
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth, here's an oops from kswapd.
Lots of stuff was active at the time, so I have no idea
what triggered this.

Cheers
-Mark


Unable to handle kernel paging request at virtual address 0299d2c4
  printing eip:
c014531e
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: michael_mic arc4 ieee80211_crypt_tkip rfcomm l2cap hci_usb usb_storage vmnet vmmon nfs bluetooth speedstep_centrino cpufreq_userspace cpufreq_stats freq_tab
le cpufreq_powersave cpufreq_ondemand cpufreq_conservative pcmcia nfsd exportfs lockd sunrpc video thermal processor fan container button battery ac af_packet sg sr_mod cdrom ieee80211 ieee80211_crypt firmware
_class ohci1394 yenta_socket rsrc_nonstatic pcmcia_core b44 mii snd_intel8x0 snd_ac97_codec snd_ac97_bus usbhid ehci_hcd uhci_hcd usbcore intel_agp agpgart nls_cp437 ntfs eeprom i2c_i801 i2c_core snd_pcm_oss s
nd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore sbp2 ieee1394 psmouse mousedev unix
eax: 0000001b   ebx: d4dec000   ecx: d4dec724   edx: 0299d2c0
esi: c20ddd00   edi: c20e0bc0   ebp: 00000038   esp: c2367de8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 142, threadinfo=c2366000 task=c2357ad0)
Stack: 0000003c c20d9210 c20e0bc0 00000296 d9ea3334 c20debc0 c01453ed 00000000
        c20d9210 c20d9200 0000003c c20d9200 00000296 d9ea3334 c20e8144 c01455bf
        c2366000 c12c0bc0 00000001 c01616fc d9ea3b44 c0161558 d9ea3b44 c12c0bc0
Call Trace:
  [cache_flusharray+93/240] cache_flusharray+0x5d/0xf0
  [kmem_cache_free+63/80] kmem_cache_free+0x3f/0x50
  [free_buffer_head+28/80] free_buffer_head+0x1c/0x50
  [try_to_free_buffers+88/144] try_to_free_buffers+0x58/0x90
  [shrink_list+1017/1184] shrink_list+0x3f9/0x4a0
  [__pagevec_release+21/32] __pagevec_release+0x15/0x20
  [shrink_cache+246/752] shrink_cache+0xf6/0x2f0
  [get_writeback_state+48/64] get_writeback_state+0x30/0x40
  [get_dirty_limits+41/288] get_dirty_limits+0x29/0x120
  [throttle_vm_writeout+53/112] throttle_vm_writeout+0x35/0x70
  [shrink_zone+147/240] shrink_zone+0x93/0xf0
  [balance_pgdat+538/1040] balance_pgdat+0x21a/0x410
  [kswapd+190/256] kswapd+0xbe/0x100
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [kswapd+0/256] kswapd+0x0/0x100
  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Code: 00 8b 44 24 04 8b 15 30 5b 39 c0 8b 0c a8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 10 1c 8b 44 24 1c 8b 13 8b 74 87 14 8b 43 04 <89> 42 04 89 10 31 d2 8b 43 0c c7 03 00
Using ACPI (MADT) for SMP configuration information
  <6>note: kswapd0[142] exited with preempt_count 1
Nov 13 18:45:34 localhost syslogd 1.4.1#17ubuntu3: restart.
