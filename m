Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWFNVF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWFNVF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWFNVF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:05:58 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:61839 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S932308AbWFNVF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:05:58 -0400
Date: Wed, 14 Jun 2006 23:05:53 +0200
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: alsa 1.0.11, 2.6.17-rc6-mm2, kernel BUG
Message-ID: <20060614210553.GC13054@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I have 2.6.17-rc6-mm2 running, and I wanted to try alsa drivers 1.0.11
final to get my hda-intel sound device running.

I compiled the drivers (changing system_utsname.xxx to utsname()->xxx)
and wanted to load the modules, but when I load the module snd:
BUG: unable to handle kernel paging request at virtual address 07400041
 printing eip:
c01c1509
*pde = 00000000
Oops: 0000 [#1]
8K_STACKS PREEMPT SMP 
last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
Modules linked in: snd_timer snd snd_page_alloc isofs zlib_inflate udf usb_storage ipt_MASQUERADE iptable_nat ip_nat ip_conntrack ip_tables x_tables i2c_i801 joydev i2c_core
CPU:    0
EIP:    0060:[<c01c1509>]    Not tainted VLI
EFLAGS: 00010286   (2.6.17-rc6-mm2 #10) 
EIP is at kref_get+0x6/0x3d
eax: 07400041   ebx: 07400041   ecx: 00000005   edx: 00000000
esi: f6dde604   edi: f6dde60a   ebp: f388af60   esp: d58bbe00
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 11478, threadinfo=d58ba000 task=d95b6000)
Stack: 00000007 d95b6114 e5a63aa0 e5a63aa0 07400029 c01c0b17 f6dde580 c0220966 
       c0220ce9 000000d0 dffff4c0 dfffd2c0 c03634d8 c01c0b17 dfead1c0 c01c0e52 
       d58ba000 f6dde617 d95b6000 00000000 ffffffea f6dde580 fffffff4 dfead1c0 
Call Trace:
 [<c01c0b17>] kobject_get+0xf/0x13
 [<c0220966>] class_device_get+0xe/0x14
 [<c0220ce9>] class_device_add+0x54/0x3a8
 [<c02210cc>] class_device_create+0x7f/0x9f
 [<f899c1cd>] snd_register_device+0x129/0x153 [snd]
 [<f88f3107>] alsa_timer_init+0x107/0x170 [snd_timer]
 [<c0133846>] sys_init_module+0x16b7/0x188d
 [<c02f4c5b>] syscall_call+0x7/0xb
Code: 10 e9 8e 31 c0 89 f0 83 7e 28 00 0f 85 a8 fc ff ff e9 82 fc ff ff 83 c4 3c
 5b 5e 5f 5d c3 c7 00 01 00 00 00 c3 53 83 ec 10 89 c3 <8b> 00 85 c0 75 29 c7 44
 24 0c 11 fc 2f c0 c7 44 24 08 20 00 00 
EIP: [<c01c1509>] kref_get+0x6/0x3d SS:ESP 0068:d58bbe00
 

Does this ring a bell for someone?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SWANIBOST (adj.)
Complete shagged out after a hard day having income tax explained to
you.
			--- Douglas Adams, The Meaning of Liff
