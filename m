Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSJPMtk>; Wed, 16 Oct 2002 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbSJPMtk>; Wed, 16 Oct 2002 08:49:40 -0400
Received: from ulima.unil.ch ([130.223.144.143]:1920 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S262452AbSJPMti>;
	Wed, 16 Oct 2002 08:49:38 -0400
Date: Wed, 16 Oct 2002 14:55:32 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.43-mm1 Oops (nfs)
Message-ID: <20021016125532.GA3140@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got this:

dmesg |ksymoops -m /usr/src/linux/System.map -v /usr/src/linux/vmlinux 
ksymoops 2.3.5 on i686 2.5.43.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.43/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): ksyms_base symbol GPLONLY_balance_dirty_pages not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpu_gdt_table not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_notify_transition not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_register not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_cpufreq_unregister not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_create_workqueue not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_def_blk_aops not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_dequeue_signal not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_destroy_workqueue not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_flush_workqueue not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_generic_file_direct_IO not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_build_dmatable not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_destroy_dmatable not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_dma_intr not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_get_best_pio_mode not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_register_driver not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_unregister_driver not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pio_timings not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_dma not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_device not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_devices not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_invalidate_inode_pages2 not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_profile_event_register not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_profile_event_unregister not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_queue_delayed_work not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_queue_work not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_register_profile_notifier not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_set_nmi_callback not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_unregister_profile_notifier not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_unset_nmi_callback not found in vmlinux.  Ignoring ksyms_base entry
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Unable to handle kernel paging request at virtual address 00002004
c018532d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c018532d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00002000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: d14c4400   edi: d1fef4e0   ebp: d0bc2ed0   esp: d0be5d4c
ds: 0068   es: 0068   ss: 0068
Stack: d1ff9a60 d0be5d58 00000000 00000011 d1fef544 d0be5d98 00000000 c015f04c 
       d0c461e0 d0bc2ed0 c030b35c 00000001 00000000 d1fef544 d1fef544 d1fef544 
       c017fe7c d1fef4e0 d1fef544 00002000 00001000 0015fffb 00022b29 00022b29 
Call Trace: [<c015f04c>]  [<c017fe7c>]  [<c0116ff7>]  [<c01172e2>]  [<c01171c0>]  [<c010663c>]  [<c02f5f09>]  [<c01805a9>]  [<c011af08>]  [<c014eabd>]  [<c01821ec>]  [<c014f55b>]  [<c0163a90>]  [<c0163dd1>]  [<c0163c08>]  [<c01641b8>]  [<c0107723>] 
Code: c7 40 04 00 20 00 00 8b 54 24 1c 8b 44 24 4c 89 50 08 8b 54 

>>EIP; c018532d <nfs_proc_fsinfo+6d/110>   <=====
Trace; c015f04c <d_alloc_root+5c/70>
Trace; c017fe7c <nfs_sb_init+11c/530>
Trace; c0116ff7 <do_schedule+1a7/320>
Trace; c01172e2 <__wake_up_locked+22/30>
Trace; c01171c0 <default_wake_function+0/40>
Trace; c010663c <__down_failed+8/c>
Trace; c02f5f09 <.text.lock.sched+19/40>
Trace; c01805a9 <nfs_fill_super+319/3c0>
Trace; c011af08 <printk+118/180>
Trace; c014eabd <sget+11d/160>
Trace; c01821ec <nfs_get_sb+1ac/240>
Trace; c014f55b <do_kern_mount+5b/d0>
Trace; c0163a90 <do_add_mount+90/190>
Trace; c0163dd1 <do_mount+181/1d0>
Trace; c0163c08 <copy_mount_options+78/c0>
Trace; c01641b8 <sys_mount+c8/100>
Trace; c0107723 <syscall_call+7/b>
Code;  c018532d <nfs_proc_fsinfo+6d/110>
00000000 <_EIP>:
Code;  c018532d <nfs_proc_fsinfo+6d/110>   <=====
   0:   c7 40 04 00 20 00 00      movl   $0x2000,0x4(%eax)   <=====
Code;  c0185334 <nfs_proc_fsinfo+74/110>
   7:   8b 54 24 1c               mov    0x1c(%esp,1),%edx
Code;  c0185338 <nfs_proc_fsinfo+78/110>
   b:   8b 44 24 4c               mov    0x4c(%esp,1),%eax
Code;  c018533c <nfs_proc_fsinfo+7c/110>
   f:   89 50 08                  mov    %edx,0x8(%eax)
Code;  c018533f <nfs_proc_fsinfo+7f/110>
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx


31 warnings issued.  Results may not be reliable.

I have already posted several lspci and so one, if needed they could be
found under http://ulima.unil.ch/greg/linux

Have a great day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
