Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTJSW00 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 18:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTJSW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 18:26:26 -0400
Received: from 254.Red-81-38-200.pooles.rima-tde.net ([81.38.200.254]:23847
	"EHLO falafell.ghetto") by vger.kernel.org with ESMTP
	id S262319AbTJSW0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 18:26:10 -0400
Date: Mon, 20 Oct 2003 00:26:04 +0200
From: Pedro Larroy <piotr@member.fsf.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] D-states in test8
Message-ID: <20031019222604.GA1140@81.38.200.176>
Reply-To: piotr@member.fsf.org
References: <20031019205630.GA1153@81.38.200.176> <20031019210308.GC1215@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20031019210308.GC1215@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 19, 2003 at 02:03:08PM -0700, William Lee Irwin III wrote:
> On Sun, Oct 19, 2003 at 10:56:30PM +0200, Pedro Larroy wrote:
> > Process just started to get into D state, all subsequent ps got into D.
> > The first that got into D state was mplayer.
> 
> It would help if you posted the output of sysrq t.
> 
> 
> -- wli
> 

Agh! sorry, I forgot the important stuff!!  ouch ! X-)


Regards

-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=D-states-test8

chedule_timeout+0xb5/0xb7
 [read_chan+1580/1992] read_chan+0x62c/0x7c8
 [write_chan+342/537] write_chan+0x156/0x219
 [handle_mm_fault+293/308] handle_mm_fault+0x125/0x134
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [tty_write+390/467] tty_write+0x186/0x1d3
 [tty_read+204/233] tty_read+0xcc/0xe9
 [tty_write+0/467] tty_write+0x0/0x1d3
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_rt_sigprocmask+255/327] sys_rt_sigprocmask+0xff/0x147
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

kdeinit       S D41D52E0     0  1962   1049  1963    1988  1594 (NOTLB)
c95cfeb0 00000082 00000000 d41d52e0 c03564f4 00000010 c035671c 00000000 
       000000d0 000029e2 b7369101 0000125e d41d52e0 012fc950 c95cfec4 00000011 
       00000011 c012477c c95cfec4 012fc950 c50d491c c0403250 c0403250 012fc950 
Call Trace:
 [schedule_timeout+99/183] schedule_timeout+0x63/0xb7
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_select+371/675] do_select+0x173/0x2a3
 [__pollwait+0/198] __pollwait+0x0/0xc6
 [sys_select+711/1251] sys_select+0x2c7/0x4e3
 [sock_ioctl+192/600] sock_ioctl+0xc0/0x258
 [syscall_call+7/11] syscall_call+0x7/0xb

vim           S C035671C     0  1963   1962          6029       (NOTLB)
d654beb0 00000086 00000010 c035671c 00000000 000000d0 0000005b 000000d0 
       d41d52e0 00001f24 611e0147 00001257 c8d06080 00000000 7fffffff 00000001 
       00000001 c01247ce c01f23c9 cc2ca000 cc2ca91c d654bf40 c5798900 00000001 
Call Trace:
 [schedule_timeout+181/183] schedule_timeout+0xb5/0xb7
 [normal_poll+266/336] normal_poll+0x10a/0x150
 [tty_poll+101/115] tty_poll+0x65/0x73
 [do_select+371/675] do_select+0x173/0x2a3
 [__pollwait+0/198] __pollwait+0x0/0xc6
 [sys_select+711/1251] sys_select+0x2c7/0x4e3
 [syscall_call+7/11] syscall_call+0x7/0xb

kdeinit       S B9E36AF4     4  1988   1049          4349  1962 (NOTLB)
c7b1feb0 00000082 dec3e080 b9e36af4 0000125e 00000010 b9e36af4 0000125e 
       dec3e080 00000a29 b9e36af4 0000125e cda81900 012fa655 c7b1fec4 00000004 
       00000004 c012477c c7b1fec4 012fa655 00000008 de347ec4 c0403338 012fa655 
Call Trace:
 [schedule_timeout+99/183] schedule_timeout+0x63/0xb7
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_select+371/675] do_select+0x173/0x2a3
 [__pollwait+0/198] __pollwait+0x0/0xc6
 [sys_select+711/1251] sys_select+0x2c7/0x4e3
 [syscall_call+7/11] syscall_call+0x7/0xb

bash          S 6694B6CC     0  2065   1287                     (NOTLB)
dcbe3e80 00000082 d5725900 6694b6cc 00001240 00000049 6694b6cc 00001240 
       d5725900 00000885 669d5e83 00001240 d5bb5900 cea6d000 7fffffff dcbe2000 
       00000001 c01247ce 65727030 1b202332 663b305d 66616c61 3a6c6c65 7273752f 
Call Trace:
 [schedule_timeout+181/183] schedule_timeout+0xb5/0xb7
 [read_chan+1580/1992] read_chan+0x62c/0x7c8
 [write_chan+342/537] write_chan+0x156/0x219
 [handle_mm_fault+293/308] handle_mm_fault+0x125/0x134
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [tty_write+390/467] tty_write+0x186/0x1d3
 [tty_read+204/233] tty_read+0xcc/0xe9
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_rt_sigprocmask+255/327] sys_rt_sigprocmask+0xff/0x147
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

kdeinit       S D57246A0     0  4349   1049          4350  1988 (NOTLB)
d3cffeb0 00000082 00000000 d57246a0 c03564f4 00000010 c035671c 00000000 
       000000d0 000003df afb56c69 0000125e d57246a0 012fa5aa d3cffec4 00000004 
       00000004 c012477c d3cffec4 012fa5aa 00000008 c7fbdf68 c812fec4 012fa5aa 
Call Trace:
 [schedule_timeout+99/183] schedule_timeout+0x63/0xb7
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_select+371/675] do_select+0x173/0x2a3
 [__pollwait+0/198] __pollwait+0x0/0xc6
 [sys_select+711/1251] sys_select+0x2c7/0x4e3
 [smp_apic_timer_interrupt+50/238] smp_apic_timer_interrupt+0x32/0xee
 [syscall_call+7/11] syscall_call+0x7/0xb

kdeinit       S AFB4CF87     0  4350   1049          4351  4349 (NOTLB)
c5dcfeb0 00000082 ce6d66a0 afb4cf87 0000125e 00000010 afb4cf87 0000125e 
       ce6d66a0 00000a4a afb4cf87 0000125e c8d072e0 012fa5aa c5dcfec4 00000004 
       00000004 c012477c c5dcfec4 012fa5aa 00000008 c5f6dec4 d37f7ec4 012fa5aa 
Call Trace:
 [schedule_timeout+99/183] schedule_timeout+0x63/0xb7
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_select+371/675] do_select+0x173/0x2a3
 [__pollwait+0/198] __pollwait+0x0/0xc6
 [sys_select+711/1251] sys_select+0x2c7/0x4e3
 [syscall_call+7/11] syscall_call+0x7/0xb

kdeinit       S AFB4F475     0  4351   1049          4352  4350 (NOTLB)
c5f6deb0 00000082 d3d1f900 afb4f475 0000125e 00000010 afb4f475 0000125e 
       d3d1f900 0000041a afb4f475 0000125e ce6d66a0 012fa5aa c5f6dec4 00000004 
       00000004 c012477c c5f6dec4 012fa5aa 00000008 c812fec4 c5dcfec4 012fa5aa 
Call Trace:
 [schedule_timeout+99/183] schedule_timeout+0x63/0xb7
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_select+371/675] do_select+0x173/0x2a3
 [__pollwait+0/198] __pollwait+0x0/0xc6
 [sys_select+711/1251] sys_select+0x2c7/0x4e3
 [syscall_call+7/11] syscall_call+0x7/0xb

kdeinit       S AFB5498B     4  4352   1049                4351 (NOTLB)
c812feb0 00000082 d57246a0 afb5498b 0000125e 00000010 afb5498b 0000125e 
       d57246a0 00000974 afb5498b 0000125e d3d1f900 012fa5aa c812fec4 00000004 
       00000004 c012477c c812fec4 012fa5aa 00000008 d3cffec4 c5f6dec4 012fa5aa 
Call Trace:
 [schedule_timeout+99/183] schedule_timeout+0x63/0xb7
 [process_timeout+0/9] process_timeout+0x0/0x9
 [do_select+371/675] do_select+0x173/0x2a3
 [__pollwait+0/198] __pollwait+0x0/0xc6
 [sys_select+711/1251] sys_select+0x2c7/0x4e3
 [syscall_call+7/11] syscall_call+0x7/0xb

vi            S C035671C     0  4748   1305                     (NOTLB)
ce6a9eb0 00000082 00000010 c035671c 00000000 000000d0 3eec57c5 000000d0 
       cf1a5600 00004f8a 2d31147f 00001240 d3d1e080 00000000 7fffffff 00000001 
       00000001 c01247ce c01f23c9 cd007000 cd00791c ce6a9f40 cf1a5600 00000001 
Call Trace:
 [schedule_timeout+181/183] schedule_timeout+0xb5/0xb7
 [normal_poll+266/336] normal_poll+0x10a/0x150
 [tty_poll+101/115] tty_poll+0x65/0x73
 [do_select+371/675] do_select+0x173/0x2a3
 [__pollwait+0/198] __pollwait+0x0/0xc6
 [sys_select+711/1251] sys_select+0x2c7/0x4e3
 [syscall_call+7/11] syscall_call+0x7/0xb

xmms          D C010E5A9     0  5975   1595                1597 (NOTLB)
d8327ed0 00000082 cbf02560 c010e5a9 00000002 c7ea6000 c7ea6004 df8f9a2c 
       df8e5869 0000433f 1f9dff47 00001244 d2d306a0 c16f7318 d2d306a0 00000246 
       c16f7320 c0107f6f 00000001 d2d306a0 c011a4e5 cdfade2c c16f7320 4095b000 
Call Trace:
 [do_gettimeofday+25/134] do_gettimeofday+0x19/0x86
 [__crc___ndelay+126735/403990] snd_pcm_trigger_tstamp+0x61/0x7e [snd_pcm]
 [__down+113/188] __down+0x71/0xbc
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [unmap_page_range+67/105] unmap_page_range+0x43/0x69
 [__down_failed+8/12] __down_failed+0x8/0xc
 [__crc___ndelay+143015/403990] .text.lock.pcm_native+0xb9/0xc8 [snd_pcm]
 [__fput+221/239] __fput+0xdd/0xef
 [unmap_vma+115/125] unmap_vma+0x73/0x7d
 [unmap_vma_list+28/40] unmap_vma_list+0x1c/0x28
 [do_munmap+301/367] do_munmap+0x12d/0x16f
 [sys_munmap+68/100] sys_munmap+0x44/0x64
 [syscall_call+7/11] syscall_call+0x7/0xb

mplayer       D 00000306     0  6016      1  6018    6028  1574 (NOTLB)
cdfade18 00200082 c7f84a18 00000306 c03564f4 c1254c70 00000000 c7f8498c 
       de7e4cc0 0001033e e7a80ee1 00001245 d5bb46a0 c16f7318 d5bb46a0 00200246 
       c16f7320 c0107f6f 00000001 d5bb46a0 c011a4e5 c16f7320 d8327ee4 c7f84a18 
Call Trace:
 [__down+113/188] __down+0x71/0xbc
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [__down_failed+8/12] __down_failed+0x8/0xc
 [__crc_fs_overflowgid+311048/1150401] .text.lock.pcm_oss+0x2d/0xa1 [snd_pcm_oss]
 [do_lookup+48/161] do_lookup+0x30/0xa1
 [link_path_walk+1391/2011] link_path_walk+0x56f/0x7db
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [vfs_follow_link+51/344] vfs_follow_link+0x33/0x158
 [soundcore_open+195/394] soundcore_open+0xc3/0x18a
 [soundcore_open+0/394] soundcore_open+0x0/0x18a
 [chrdev_open+168/321] chrdev_open+0xa8/0x141
 [devfs_open+165/189] devfs_open+0xa5/0xbd
 [dentry_open+271/403] dentry_open+0x10f/0x193
 [filp_open+98/100] filp_open+0x62/0x64
 [sys_open+91/139] sys_open+0x5b/0x8b
 [syscall_call+7/11] syscall_call+0x7/0xb

mplayer       Z 65D8232A  6788  6018   6016                     (L-TLB)
da449f88 00200046 d41d52e0 65d8232a 0000124f 00000011 65d8232a 0000124f 
       d41d52e0 0002072c 65e6e46d 0000124f d5bb4cc0 c17cc720 da448000 d5bb4cc0 
       00000100 c011f228 d5bb4cc0 c17cc720 c7d01a80 c7d01aa0 00000100 da448000 
Call Trace:
 [do_exit+451/797] do_exit+0x1c3/0x31d
 [do_group_exit+52/114] do_group_exit+0x34/0x72
 [syscall_call+7/11] syscall_call+0x7/0xb

killall       D 00000000     0  6028      1                6016 (NOTLB)
cc027e04 00000082 00000000 00000000 00000000 d3d1e6a0 c03564f4 00000010 
       c035673c 002d6922 964b8213 00001251 d3d1e6a0 d18228a0 d3d1e6a0 cc027e10 
       00000400 c01a96c9 d18228a4 d7fd5e10 d18228a4 d3d1e6a0 00000001 d18228a0 
Call Trace:
 [rwsem_down_read_failed+117/269] rwsem_down_read_failed+0x75/0x10d
 [.text.lock.array+7/69] .text.lock.array+0x7/0x45
 [do_page_fault+288/1264] do_page_fault+0x120/0x4f0
 [pid_revalidate+65/170] pid_revalidate+0x41/0xaa
 [rb_insert_color+200/225] rb_insert_color+0xc8/0xe1
 [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
 [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
 [proc_info_read+84/312] proc_info_read+0x54/0x138
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

bash          S D3D1ECC0    16  6029   1962  6032    6041  1963 (NOTLB)
c7d17f3c 00000082 d1832600 d3d1ecc0 c01188d3 d1822a80 d1832600 080f3adc 
       de498080 00021686 2a8cd411 00001258 d3d1ecc0 fffffe00 d3d1ecc0 d3d1ed68 
       d3d1ed68 c011f96e ffffffff 00000002 de498080 00001791 c7d16000 00000001 
Call Trace:
 [do_page_fault+288/1264] do_page_fault+0x120/0x4f0
 [sys_wait4+391/579] sys_wait4+0x187/0x243
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [sigprocmask+75/179] sigprocmask+0x4b/0xb3
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [syscall_call+7/11] syscall_call+0x7/0xb

ps            D 00000000    16  6032   6029          6033       (NOTLB)
d7fd5e04 00000086 d616b0cb 00000000 ffffffff c01aa3f3 d616b0cb ffffffff 
       de7e4cc0 0004bf08 30595253 00001258 d3d1f2e0 d18228a0 d3d1f2e0 d7fd5e10 
       000003ff c01a96c9 d18228a4 c8323e10 cc027e10 d3d1f2e0 00000001 d18228a0 
Call Trace:
 [vsnprintf+569/1125] vsnprintf+0x239/0x465
 [rwsem_down_read_failed+117/269] rwsem_down_read_failed+0x75/0x10d
 [.text.lock.array+7/69] .text.lock.array+0x7/0x45
 [vsnprintf+569/1125] vsnprintf+0x239/0x465
 [pid_revalidate+40/170] pid_revalidate+0x28/0xaa
 [pid_revalidate+65/170] pid_revalidate+0x41/0xaa
 [do_lookup+104/161] do_lookup+0x68/0xa1
 [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
 [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
 [proc_info_read+84/312] proc_info_read+0x54/0x138
 [filp_open+98/100] filp_open+0x62/0x64
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

grep          S 000000D2     0  6033   6029                6032 (NOTLB)
c5665ee0 00000082 00000000 000000d2 00000000 00000246 c13761a8 de503194 
       d3d1f2e0 0000c884 2d5f4413 00001258 de498080 db4c29e8 db4c2980 c5665f08 
       00007000 c015714b 00000000 de498080 c011b627 c5665f14 c5665f14 12962208 
Call Trace:
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [update_atime+208/213] update_atime+0xd0/0xd5
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+343/565] pipe_read+0x157/0x235
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

bash          S B8AF40F1    16  6041   1962  6044    6045  6029 (NOTLB)
c6dd1f3c 00000082 d41d4080 b8af40f1 00001258 c7d01a80 b8af40f1 00001258 
       d41d4080 0002b27a b8af40f1 00001258 c6dd3900 fffffe00 c6dd3900 c6dd39a8 
       c6dd39a8 c011f96e ffffffff 00000002 c6dd32e0 0000179c c6dd0000 00000001 
Call Trace:
 [sys_wait4+391/579] sys_wait4+0x187/0x243
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [sigprocmask+75/179] sigprocmask+0x4b/0xb3
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [syscall_call+7/11] syscall_call+0x7/0xb

ps            D 00000000     0  6044   6041                     (NOTLB)
c8323e04 00000082 c7e460cb 00000000 ffffffff c01aa3f3 c7e460cb ffffffff 
       00000000 0009ed30 b95f9373 00001258 c6dd32e0 d18228a0 c6dd32e0 c8323e10 
       000003ff c01a96c9 d18228a4 cc18be10 d7fd5e10 c6dd32e0 00000001 d18228a0 
Call Trace:
 [vsnprintf+569/1125] vsnprintf+0x239/0x465
 [rwsem_down_read_failed+117/269] rwsem_down_read_failed+0x75/0x10d
 [.text.lock.array+7/69] .text.lock.array+0x7/0x45
 [vsnprintf+569/1125] vsnprintf+0x239/0x465
 [pid_revalidate+40/170] pid_revalidate+0x28/0xaa
 [pid_revalidate+65/170] pid_revalidate+0x41/0xaa
 [do_lookup+104/161] do_lookup+0x68/0xa1
 [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
 [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
 [proc_info_read+84/312] proc_info_read+0x54/0x138
 [filp_open+98/100] filp_open+0x62/0x64
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

bash          S C6DD2CC0     0  6045   1962  6048    6049  6041 (NOTLB)
d5e19f3c 00000082 ce8656c0 c6dd2cc0 c01188d3 d608ab80 ce8656c0 080f6ff8 
       00000001 00030440 9fb0256b 00001259 c6dd2cc0 fffffe00 c6dd2cc0 c6dd2d68 
       c6dd2d68 c011f96e ffffffff 00000002 c6dd26a0 000017a0 d5e18000 00000001 
Call Trace:
 [do_page_fault+288/1264] do_page_fault+0x120/0x4f0
 [sys_wait4+391/579] sys_wait4+0x187/0x243
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [sigprocmask+75/179] sigprocmask+0x4b/0xb3
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
 [syscall_call+7/11] syscall_call+0x7/0xb

top           D 000000D0     0  6048   6045                     (NOTLB)
cc18be04 00000082 00000001 000000d0 deedb980 0000001b deed7a90 deece780 
       c013b5cd 005ab56e a1cbce69 00001259 c6dd26a0 d18228a0 c6dd26a0 cc18be10 
       000003ff c01a96c9 d18228a4 c93fde10 c8323e10 c6dd26a0 00000001 d18228a0 
Call Trace:
 [cache_alloc_refill+321/474] cache_alloc_refill+0x141/0x1da
 [rwsem_down_read_failed+117/269] rwsem_down_read_failed+0x75/0x10d
 [.text.lock.array+7/69] .text.lock.array+0x7/0x45
 [proc_pid_make_inode+155/206] proc_pid_make_inode+0x9b/0xce
 [proc_pident_lookup+242/533] proc_pident_lookup+0xf2/0x215
 [pid_revalidate+40/170] pid_revalidate+0x28/0xaa
 [pid_revalidate+65/170] pid_revalidate+0x41/0xaa
 [do_lookup+104/161] do_lookup+0x68/0xa1
 [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
 [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
 [proc_info_read+84/312] proc_info_read+0x54/0x138
 [filp_open+98/100] filp_open+0x62/0x64
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

bash          S CF1457C8     0  6049   1962                6045 (NOTLB)
d6461e80 00000082 d6112680 cf1457c8 0000007c c013526d c172ae9c c1428420 
       c01361b5 0000b220 1d4aea7f 0000125a c6dd2080 cf84c000 7fffffff d6460000 
       00000001 c01247ce cc9c7310 00000002 c0140e3c ca9f4900 080c4000 00000000 
Call Trace:
 [find_get_page+26/37] find_get_page+0x1a/0x25
 [filemap_nopage+557/680] filemap_nopage+0x22d/0x2a8
 [schedule_timeout+181/183] schedule_timeout+0xb5/0xb7
 [do_no_page+438/817] do_no_page+0x1b6/0x331
 [read_chan+1580/1992] read_chan+0x62c/0x7c8
 [handle_mm_fault+210/308] handle_mm_fault+0xd2/0x134
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [tty_write+390/467] tty_write+0x186/0x1d3
 [tty_read+204/233] tty_read+0xcc/0xe9
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_rt_sigprocmask+255/327] sys_rt_sigprocmask+0xff/0x147
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

ps            D 00000000  4048  6056   1002                     (NOTLB)
c93fde04 00000082 d041e0c7 00000000 ffffffff c01aa3f3 d041e0c7 ffffffff 
       00000000 001e1e1c 334858f1 0000125d c93ff900 d18228a0 c93ff900 c93fde10 
       000003ff c01a96c9 d18228a4 d18228a4 cc18be10 c93ff900 00000001 d18228a0 
Call Trace:
 [vsnprintf+569/1125] vsnprintf+0x239/0x465
 [rwsem_down_read_failed+117/269] rwsem_down_read_failed+0x75/0x10d
 [.text.lock.array+7/69] .text.lock.array+0x7/0x45
 [vsnprintf+569/1125] vsnprintf+0x239/0x465
 [pid_revalidate+40/170] pid_revalidate+0x28/0xaa
 [pid_revalidate+65/170] pid_revalidate+0x41/0xaa
 [do_lookup+104/161] do_lookup+0x68/0xa1
 [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
 [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
 [proc_info_read+84/312] proc_info_read+0x54/0x138
 [filp_open+98/100] filp_open+0x62/0x64
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

--J2SCkAp4GZ/dPZZf--
