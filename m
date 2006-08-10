Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWHJXIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWHJXIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWHJXIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:08:46 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:64595 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932122AbWHJXIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:08:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gYj10p1gu8GO2b+le3Y4OFpnwvsr9BJ5c/wtry5p7nbEjsFbt+s5zPm3GZ/loY0InO2Y4oPvCP+o6WrwotVeoByYSR0mzEoc1PA1zd5LUe08BBDbTT1nMYKLPZGhe3j03Gbnad19QiM/MrSx37FFywH9GIZzpku4DcxW5sH3yBU=
Message-ID: <6bffcb0e0608101608j4fc41945of65173793703a065@mail.gmail.com>
Date: Fri, 11 Aug 2006 01:08:44 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: xfs-masters@oss.sgi.com
Subject: Re: 2.6.18-rc4+ext4 oops while mounting xfs
Cc: nathans@sgi.com, xfs@oss.sgi.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6bffcb0e0608100805k42357f5bxa73189c38fb926df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0608100805k42357f5bxa73189c38fb926df@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> This script is awesome :)
>
> #! /bin/bash
>
> m_fs() {
> #    sudo mount -o loop -t ext2 /home/fs-farm/ext2.img /mnt/fs-farm/ext2/
> #    sudo mount -o loop -t ext3 /home/fs-farm/ext3.img /mnt/fs-farm/ext3/
> #    sudo mount -o loop -t ext3dev /home/fs-farm/ext4.img /mnt/fs-farm/ext4/
> #    sudo mount -o loop -t reiserfs /home/fs-farm/reiser3.img
> /mnt/fs-farm/reiser3/
>     sudo mount -o loop -t xfs /home/fs-farm/xfs.img /mnt/fs-farm/xfs/
> #    sudo mount -o loop -t jfs /home/fs-farm/jfs.img /mnt/fs-farm/jfs/
> }
>
> u_fs() {
> #    sudo umount /mnt/fs-farm/ext2/
> #    sudo umount /mnt/fs-farm/ext3/
> #    sudo umount /mnt/fs-farm/ext4/
> #    sudo umount /mnt/fs-farm/reiser3/
>     sudo umount /mnt/fs-farm/xfs/
> #    sudo umount /mnt/fs-farm/jfs/
> }
>
> while true
> do
> m_fs
> u_fs
> done
>
> Aug 10 16:50:53 ltg01-fedora kernel: BUG: unable to handle kernel
> paging request at virtual address 6b6b6c07
> Aug 10 16:50:53 ltg01-fedora kernel:  printing eip:
> Aug 10 16:50:53 ltg01-fedora kernel: c013551a
> Aug 10 16:50:53 ltg01-fedora kernel: *pde = 00000000
> Aug 10 16:50:53 ltg01-fedora kernel: Oops: 0002 [#1]
> Aug 10 16:50:53 ltg01-fedora kernel: PREEMPT SMP
> Aug 10 16:50:53 ltg01-fedora kernel: Modules linked in: xfs ext3dev
> jbd2 loop ipv6 w83627hf hwmon_vid hwmon i2c_isa af_packe
> t ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink
> xt_tcpudp iptable_filter ip_tables x_tables cpufreq_use
> rspace p4_clockmod speedstep_lib binfmt_misc thermal processor fan
> container evdev snd_intel8x0 snd_ac97_codec snd_ac97_bus
> snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
> snd_pcm_oss snd_mixer_oss snd_pcm sk98lin snd_timer snd
> ide_cd soundcore skge snd_page_alloc cdrom i2c_i801 intel_agp agpgart rtc unix
> Aug 10 16:50:53 ltg01-fedora kernel: CPU:    0
> Aug 10 16:50:53 ltg01-fedora kernel: EIP:    0060:[<c013551a>]    Not
> tainted VLI
> Aug 10 16:50:53 ltg01-fedora kernel: EFLAGS: 00010002   (2.6.18-rc4 #119)
> Aug 10 16:50:53 ltg01-fedora kernel: EIP is at __lock_acquire+0x2ca/0x9b6
> Aug 10 16:50:53 ltg01-fedora kernel: eax: d9c53d4c   ebx: 6b6b6b6b
> ecx: 00000000   edx: 00000000
> Aug 10 16:50:53 ltg01-fedora kernel: esi: 00000002   edi: df966d20
> ebp: e44a8e7c   esp: e44a8e4c
> Aug 10 16:50:53 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
> Aug 10 16:50:53 ltg01-fedora kernel: Process umount (pid: 16133,
> ti=e44a8000 task=df966d20 task.ti=e44a8000)
> Aug 10 16:50:53 ltg01-fedora kernel: Stack: 00000000 00000000 d9c53d4c
> df966d20 00000000 00000378 00000008 df9672f8
> Aug 10 16:50:53 ltg01-fedora kernel:        df966d20 df9672a8 00000002
> df966d20 e44a8eb0 c0135ccb 00000000 00000002
> Aug 10 16:50:53 ltg01-fedora kernel:        00000000 fe5778b7 c02d580c
> 00000003 df967280 00000004 df966d20 f4202a00
> Aug 10 16:50:53 ltg01-fedora kernel: Call Trace:
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0135ccb>]
> lock_release_non_nested+0xc5/0x11d
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0136026>] lock_release+0x12f/0x159
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c02d579e>]
> __mutex_unlock_slowpath+0x99/0xff
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c02d580c>] mutex_unlock+0x8/0xa
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d3b2>]
> generic_shutdown_super+0xbb/0x113
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d42a>] kill_block_super+0x20/0x32
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d4ea>] deactivate_super+0x5d/0x6f
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0180336>] mntput_no_expire+0x42/0x72
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0173147>]
> path_release_on_umount+0x15/0x18
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c018147c>] sys_umount+0x1e7/0x21b
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01814bd>] sys_oldumount+0xd/0xf
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> Aug 10 16:50:53 ltg01-fedora kernel: DWARF2 unwinder stuck at
> sysenter_past_esp+0x56/0x8d
> Aug 10 16:50:53 ltg01-fedora kernel: Leftover inexact backtrace:
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c010418c>] show_stack_log_lvl+0x8c/0x97
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01042e8>] show_registers+0x151/0x1c6
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01044d9>] die+0x17c/0x281
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0116677>] do_page_fault+0x3b3/0x480
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0103b19>] error_code+0x39/0x40
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0135ccb>]
> lock_release_non_nested+0xc5/0x11d
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0136026>] lock_release+0x12f/0x159
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c02d579e>]
> __mutex_unlock_slowpath+0x99/0xff
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c02d580c>] mutex_unlock+0x8/0xa
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d3b2>]
> generic_shutdown_super+0xbb/0x113
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d42a>] kill_block_super+0x20/0x32
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d4ea>] deactivate_super+0x5d/0x6f
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0180336>] mntput_no_expire+0x42/0x72
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0173147>]
> path_release_on_umount+0x15/0x18
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c018147c>] sys_umount+0x1e7/0x21b
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01814bd>] sys_oldumount+0xd/0xf
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> Aug 10 16:50:53 ltg01-fedora kernel: Code: 2a e8 73 94 0a 00 85 c0 74
> 21 68 ab a2 2d c0 68 d5 04 00 00 68 d9 37 2f c0 68 ee
> d0 2e c0 e8 b5 9d fe ff e8 45 f2 fc ff 83 c4 10 <f0> ff 83 9c 00 00 00
> 8b 55 dc 8b 92 5c 05 00 00 89 55 e4 83 fa
> Aug 10 16:50:53 ltg01-fedora kernel: EIP: [<c013551a>]
> __lock_acquire+0x2ca/0x9b6 SS:ESP 0068:e44a8e4c
> Aug 10 16:50:53 ltg01-fedora kernel:  <3>BUG: sleeping function called
> from invalid context at /usr/src/linux-work2/mm/slab.c:2901
> Aug 10 16:50:53 ltg01-fedora kernel: in_atomic():0, irqs_disabled():1
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0104006>] show_trace_log_lvl+0x58/0x152
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01046ad>] show_trace+0xd/0x10
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0104775>] dump_stack+0x19/0x1b
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01181df>] __might_sleep+0x8d/0x95
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0163c61>] kmem_cache_zalloc+0x28/0xcc
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c014b83c>]
> taskstats_exit_alloc+0x32/0x70
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01213e1>] do_exit+0x111/0x7f1
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01045b8>] die+0x25b/0x281
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0116677>] do_page_fault+0x3b3/0x480
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0103b19>] error_code+0x39/0x40
> Aug 10 16:50:53 ltg01-fedora kernel: DWARF2 unwinder stuck at
> error_code+0x39/0x40
> Aug 10 16:50:53 ltg01-fedora kernel: Leftover inexact backtrace:
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01046ad>] show_trace+0xd/0x10
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0104775>] dump_stack+0x19/0x1b
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01181df>] __might_sleep+0x8d/0x95
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0163c61>] kmem_cache_zalloc+0x28/0xcc
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c014b83c>]
> taskstats_exit_alloc+0x32/0x70
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01213e1>] do_exit+0x111/0x7f1
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01045b8>] die+0x25b/0x281
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0116677>] do_page_fault+0x3b3/0x480
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0103b19>] error_code+0x39/0x40
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0135ccb>]
> lock_release_non_nested+0xc5/0x11d
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0136026>] lock_release+0x12f/0x159
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c02d579e>]
> __mutex_unlock_slowpath+0x99/0xff
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c02d580c>] mutex_unlock+0x8/0xa
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d3b2>]
> generic_shutdown_super+0xbb/0x113
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d42a>] kill_block_super+0x20/0x32
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d4ea>] deactivate_super+0x5d/0x6f
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0180336>] mntput_no_expire+0x42/0x72
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0173147>]
> path_release_on_umount+0x15/0x18
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c018147c>] sys_umount+0x1e7/0x21b
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c01814bd>] sys_oldumount+0xd/0xf
> Aug 10 16:50:53 ltg01-fedora kernel:  [<c0102f15>] sysenter_past_esp+0x56/0x8d
> Aug 10 16:50:53 ltg01-fedora kernel: Filesystem "loop2": Disabling
> barriers, not supported by the underlying device
> Aug 10 16:50:53 ltg01-fedora kernel: XFS mounting filesystem loop2
>
> (gdb) list *0xc013551a
> 0xc013551a is in __lock_acquire (include2/asm/atomic.h:96).
> 91       *
> 92       * Atomically increments @v by 1.
> 93       */
> 94      static __inline__ void atomic_inc(atomic_t *v)
> 95      {
> 96              __asm__ __volatile__(
> 97                      LOCK_PREFIX "incl %0"
> 98                      :"+m" (v->counter));
> 99      }
> 100
>
> Here is a config file http://www.stardust.webpages.pl/files/o_bugs/test-config

It's fixed in latest 2.6.18-rc4-git*.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
