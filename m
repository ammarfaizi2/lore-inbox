Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWI2AN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWI2AN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161410AbWI2AN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:13:56 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:30657 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1161009AbWI2ANy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:13:54 -0400
X-Sasl-enc: 9DBAIPqZtpvkpgcRerfUw+vQLzZC85eLyzWgSs0YmDX6 1159488834
Message-ID: <451C65A0.1080002@imap.cc>
Date: Fri, 29 Sep 2006 02:15:28 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       jbeulich@novell.com
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc>	<20060924145337.ae152efd.akpm@osdl.org>	<451BFFA9.4030000@imap.cc>	<200609281912.01858.ak@suse.de>	<451C58AC.5060601@imap.cc> <20060928163046.055b3ce0.rdunlap@xenotime.net>
In-Reply-To: <20060928163046.055b3ce0.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBA461B5DC5B271D247CD7AE9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBA461B5DC5B271D247CD7AE9
Content-Type: multipart/mixed;
 boundary="------------070001080605050403010203"

This is a multi-part message in MIME format.
--------------070001080605050403010203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 29.09.2006 01:30 schrieb Randy Dunlap:
> On Fri, 29 Sep 2006 01:20:12 +0200 Tilman Schmidt wrote:
>> Am 28.09.2006 19:12 schrieb Andi Kleen:
>>>
>>> Can you perhaps boot with profile=3D1 and then send readprofile outpu=
t after
>>> boot?
>> I'm afraid I'll need instructions for that. I assume "profile=3D1"
>> is to be appended to the kernel command line; but how do I
>> retrieve that readprofile output you are asking for?
>=20
> Use 'readprofile'.  Usage is described in
> Documentation/basic_profiling.txt in the kernel source tree.

Thanks. Result attached.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)

--------------070001080605050403010203
Content-Type: text/plain;
 name="readprofile.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="readprofile.out"

     4 calibrate_delay                            0.0020
 59946 default_idle                             525.8421
     4 cpu_idle                                   0.0351
     9 sysenter_past_esp                          0.0638
     1 error_code                                 0.0156
     3 sched_clock                                0.0273
     1 page_is_ram                                0.0088
     1 pgd_alloc                                  0.0500
     5 do_page_fault                              0.0043
     1 __wake_up                                  0.0175
     2 add_preempt_count                          0.0213
    24 sub_preempt_count                          0.2243
    11 __might_sleep                              0.0738
     2 requeue_task                               0.0455
     5 task_rq_lock                               0.1667
     4 try_to_wake_up                             0.0153
     1 wake_up_process                            0.0588
     1 free_task                                  0.0278
     8 __put_task_struct                          0.0428
     2 do_fork                                    0.0054
     2 acquire_console_sem                        0.0156
     1 release_console_sem                        0.0021
    28 vprintk                                    0.0367
     2 profile_hit                                0.0364
     2 delayed_put_task_struct                    0.0645
     3 do_wait                                    0.0012
     1 sys_gettimeofday                           0.0109
     1 current_fs_time                            0.0106
    71 tasklet_action                             0.6017
     2 __local_bh_disable                         0.0163
  6212 __do_softirq                              35.7011
     1 local_bh_enable_ip                         0.0047
    89 local_bh_enable                            0.3309
     2 __tasklet_schedule                         0.0187
     1 register_proc_table                        0.0042
     2 lock_timer_base                            0.0392
    74 run_timer_softirq                          0.2202
     2 __mod_timer                                0.0132
     2 mod_timer                                  0.0465
     4 del_timer                                  0.0548
     3 do_gettimeofday                            0.0124
     1 getnstimeofday                             0.0047
    10 free_uid                                   0.0877
     1 sigprocmask                                0.0047
     2 run_workqueue                              0.0103
     1 flush_cpu_workqueue                        0.0071
     1 worker_thread                              0.0036
     1 schedule_work                              0.0588
     6 put_pid                                    0.1714
     1 delayed_put_pid                            0.0769
     1 alloc_pid                                  0.0019
    29 rcu_start_batch                            0.6444
     2 rcu_init_percpu_data                       0.0238
    95 __rcu_process_callbacks                    0.2707
    17 rcu_process_callbacks                      0.4857
     1 call_rcu_bh                                0.0094
     1 sys_clock_gettime                          0.0076
     1 kthread_should_stop                        0.0385
     2 __wake_up_bit                              0.0408
     1 wake_bit_function                          0.0149
     1 init_waitqueue_head                        0.0303
     2 remove_wait_queue                          0.0351
     2 add_wait_queue                             0.0377
   179 hrtimer_run_queues                         0.6047
     1 hrtimer_cancel                             0.0417
     2 sys_nanosleep                              0.0235
     1 down_write_trylock                         0.0200
     1 down_read                                  0.0169
     1 debug_mutex_free_waiter                    0.0152
     1 lockdep_init_map                           0.0061
     8 debug_check_no_locks_freed                 0.0282
    23 lock_release                               0.0821
   996 lock_acquire                               9.1376
     1 drop_key_refs                              0.0227
     1 get_futex_key                              0.0045
     3 do_futex                                   0.0009
     1 sys_futex                                  0.0041
    12 lookup_symbol                              0.2353
     1 page_waitqueue                             0.0222
     1 find_get_page                              0.0161
     1 sys_fadvise64_64                           0.0023
     2 __free_pages_ok                            0.0069
    22 get_page_from_freelist                     0.0263
     1 __alloc_pages                              0.0016
     3 free_hot_cold_page                         0.0098
     2 wb_kupdate                                 0.0096
     1 test_clear_page_writeback                  0.0056
     1 test_set_page_writeback                    0.0045
     1 generic_writepages                         0.0015
     1 force_page_cache_readahead                 0.0090
     1 release_pages                              0.0030
     1 __pagevec_lru_add                          0.0053
     1 lru_add_drain                              0.0115
     1 mark_page_accessed                         0.0200
     1 put_page                                   0.0182
     1 vma_prio_tree_insert                       0.0227
     1 vm_normal_page                             0.0115
     3 unmap_vmas                                 0.0027
     4 do_wp_page                                 0.0049
     1 copy_page_range                            0.0014
     1 __handle_mm_fault                          0.0006
     3 find_vma                                   0.0353
     1 __vm_enough_memory                         0.0046
     1 vma_adjust                                 0.0013
     1 do_munmap                                  0.0023
     2 do_mmap_pgoff                              0.0013
     1 page_remove_rmap                           0.0143
     4 __remove_vm_area                           0.0769
     4 check_irq_on                               0.2000
     7 kmem_flagcheck                             0.1795
     1 kmem_cache_name                            0.1250
     1 dbg_redzone1                               0.0357
    18 poison_obj                                 0.4091
   401 check_poison_obj                           1.1392
    28 drain_array                                0.1667
     1 cache_flusharray                           0.0044
    74 kfree                                      0.3834
   458 kmem_cache_free                            2.5730
     2 kmem_rcu_free                              0.0500
     4 drain_freelist                             0.0263
    53 cache_reap                                 0.2409
     7 cache_alloc_debugcheck_after               0.0219
    44 kmem_cache_alloc                           0.2716
    35 cache_alloc_refill                         0.0233
     1 __kmalloc_track_caller                     0.0046
     3 kmem_cache_zalloc                          0.0152
    15 __kmalloc                                  0.0685
     4 sys_faccessat                              0.0131
     2 sys_access                                 0.1111
     1 __dentry_open                              0.0019
     1 do_sys_open                                0.0055
     1 sys_write                                  0.0104
    10 file_free_rcu                              0.5882
     2 get_max_files                              0.2000
    11 fget_light                                 0.0663
     3 sync_supers                                0.0152
     1 sys_readlinkat                             0.0068
     3 generic_fillattr                           0.0164
     1 vfs_getattr                                0.0059
     1 vfs_lstat                                  0.0526
     2 pipe_readv                                 0.0025
     4 getname                                    0.0217
     1 permission                                 0.0051
     2 __follow_mount                             0.0192
     3 do_lookup                                  0.0097
     6 __link_path_walk                           0.0018
     2 link_path_walk                             0.0101
     2 do_path_lookup                             0.0032
     5 __user_walk_fd                             0.0769
     4 poll_freewait                              0.0444
     1 __pollwait                                 0.0055
    43 do_select                                  0.0341
    22 core_sys_select                            0.0298
    10 sys_select                                 0.0306
    11 do_sys_poll                                0.0109
     3 sys_poll                                   0.0435
     7 d_callback                                 0.1795
     1 _d_rehash                                  0.0156
     1 __d_path                                   0.0029
     5 __d_lookup                                 0.0187
     1 alloc_inode                                0.0024
     1 file_update_time                           0.0076
     1 is_bad_inode                               0.0455
     5 free_fdtable_rcu                           0.0198
     1 sync_sb_inodes                             0.0016
     1 unlock_buffer                              0.0526
     2 alloc_buffer_head                          0.0260
     4 __find_get_block_slow                      0.0145
     1 ll_rw_block                                0.0055
     6 __find_get_block                           0.0134
     2 __getblk                                   0.0037
     2 __block_write_full_page                    0.0026
     1 block_write_full_page                      0.0048
     1 bio_init                                   0.0094
     1 init_once                                  0.0084
     2 do_mpage_readpage                          0.0013
     1 inotify_d_instantiate                      0.0098
     1 proc_readfd                                0.0019
     1 sysfs_get_name                             0.0149
     1 sysfs_release                              0.0066
     2 sysfs_lookup                               0.0045
     1 sysfs_create_link                          0.0032
     1 reiserfs_discard_all_prealloc              0.0167
     1 search_by_entry_key                        0.0017
     1 reiserfs_lookup                            0.0039
     2 _get_block_create_0                        0.0013
     1 reiserfs_read_locked_inode                 0.0008
     1 reiserfs_commit_page                       0.0023
    10 reiserfs_readdir                           0.0088
     2 load_bitmap_info_data                      0.0145
     2 comp_items                                 0.0317
     1 decrement_counters_in_path                 0.0147
    25 search_by_key                              0.0064
     1 flush_commit_list                          0.0007
     4 do_journal_end                             0.0014
     2 do_journal_begin_r                         0.0031
     1 journal_begin                              0.0043
     1 journal_end_sync                           0.0093
     1 reiserfs_commit_for_inode                  0.0026
     1 direntry_create_vi                         0.0030
     2 reiserfs_permission                        0.0556
     1 dummy_inode_alloc_security                 0.1429
     1 dummy_task_free_security                   0.2000
     2 dummy_vm_enough_memory                     0.0625
     1 init_request_from_bio                      0.0076
     3 _atomic_dec_and_lock                       0.0625
     1 prio_tree_replace                          0.0110
     2 prio_tree_insert                           0.0040
     1 radix_tree_preload                         0.0071
     6 memcmp                                     0.1429
     3 number                                     0.0059
   106 delay_tsc                                  4.6087
    15 read_current_timer                         0.5357
     1 __delay                                    0.0909
     3 memcpy                                     0.0698
     7 strncpy_from_user                          0.0875
     1 __copy_from_user_ll                        0.0045
     3 copy_from_user                             0.0278
    18 __copy_to_user_ll                          0.0811
     4 copy_to_user                               0.0488
     1 irqsafe2A_spin_12                          0.0066
     1 irqsafe2A_wlock_12                         0.0066
     1 irqsafe2A_rlock_12                         0.0066
     1 irqsafe2A_spin_21                          0.0066
     1 irqsafe2A_wlock_21                         0.0066
     1 irqsafe2A_rlock_21                         0.0066
    19 dotest                                     0.0206
     1 irqsafe1_hard_spin_12                      0.0067
     1 irqsafe1_hard_wlock_12                     0.0067
     1 irqsafe1_hard_rlock_12                     0.0067
     1 irqsafe1_hard_wlock_21                     0.0067
     1 irqsafe1_hard_rlock_21                     0.0067
     2 irqsafe2B_hard_spin_12                     0.0123
     1 irqsafe2B_hard_wlock_12                    0.0062
     1 irqsafe2B_hard_rlock_12                    0.0062
     1 irqsafe2B_hard_spin_21                     0.0062
     2 irqsafe2B_hard_wlock_21                    0.0123
     2 irqsafe2B_hard_rlock_21                    0.0123
     1 irqsafe3_hard_spin_123                     0.0053
     1 irqsafe3_hard_wlock_123                    0.0053
     1 irqsafe3_hard_rlock_123                    0.0053
     2 irqsafe3_hard_spin_132                     0.0105
     1 irqsafe3_hard_wlock_132                    0.0053
     1 irqsafe3_hard_rlock_132                    0.0053
     1 irqsafe3_hard_wlock_213                    0.0053
     1 irqsafe3_hard_rlock_213                    0.0053
     2 irqsafe3_hard_spin_231                     0.0105
     1 irqsafe3_hard_wlock_231                    0.0053
     1 irqsafe3_hard_rlock_231                    0.0053
     1 irqsafe3_hard_spin_312                     0.0053
     1 irqsafe3_hard_wlock_312                    0.0053
     1 irqsafe3_hard_rlock_312                    0.0053
     1 irqsafe3_hard_spin_321                     0.0053
     1 irqsafe3_hard_wlock_321                    0.0053
     1 irqsafe3_hard_rlock_321                    0.0053
     1 irqsafe4_hard_spin_123                     0.0050
     2 irqsafe4_hard_wlock_123                    0.0099
     2 irqsafe4_hard_rlock_123                    0.0099
     2 irqsafe4_hard_spin_132                     0.0099
     1 irqsafe4_hard_wlock_132                    0.0050
     1 irqsafe4_hard_rlock_132                    0.0050
     1 irqsafe4_hard_wlock_213                    0.0050
     1 irqsafe4_hard_rlock_213                    0.0050
     1 irqsafe4_hard_spin_231                     0.0050
     1 irqsafe4_hard_wlock_231                    0.0050
     1 irqsafe4_hard_rlock_231                    0.0050
     2 irqsafe4_hard_spin_312                     0.0099
     1 irqsafe4_hard_wlock_312                    0.0050
     1 irqsafe4_hard_rlock_312                    0.0050
     1 irqsafe4_hard_spin_321                     0.0050
     1 irqsafe4_hard_wlock_321                    0.0050
     1 irqsafe4_hard_rlock_321                    0.0050
     1 irq_inversion_hard_spin_123                0.0050
     2 irq_inversion_hard_wlock_123               0.0099
     2 irq_inversion_hard_rlock_123               0.0099
     2 irq_inversion_hard_spin_132                0.0099
     1 irq_inversion_hard_wlock_132               0.0050
     1 irq_inversion_hard_rlock_132               0.0050
     1 irq_inversion_hard_wlock_213               0.0050
     1 irq_inversion_hard_rlock_213               0.0050
     1 irq_inversion_hard_spin_231                0.0050
     1 irq_inversion_hard_wlock_231               0.0050
     1 irq_inversion_hard_rlock_231               0.0050
     2 irq_inversion_hard_spin_312                0.0099
     1 irq_inversion_hard_wlock_312               0.0050
     1 irq_inversion_hard_rlock_312               0.0050
     1 irq_inversion_hard_spin_321                0.0050
     1 irq_inversion_hard_wlock_321               0.0050
     1 irq_inversion_hard_rlock_321               0.0050
     1 irq_read_recursion_hard_123                0.0050
     2 irq_read_recursion_hard_132                0.0099
     1 irq_read_recursion_hard_231                0.0050
     2 irq_read_recursion_hard_312                0.0099
     1 irq_read_recursion_hard_321                0.0050
     2 __spin_lock_init                           0.0200
     5 _raw_spin_unlock                           0.0455
     1 _raw_read_lock                             0.0417
     4 _raw_spin_lock                             0.0175
     3 fb_get_color_depth                         0.0517
     1 vgacon_save_screen                         0.0105
     5 cursor_timer_handler                       0.1163
    14 fb_flashcursor                             0.0220
     1 fbcon_cursor                               0.0016
    13 bit_cursor                                 0.0117
     7 bit_putcs                                  0.0063
    20 bitfill_aligned                            0.1010
     9 cfb_copyarea                               0.0042
    56 cfb_imageblit                              0.0399
     1 acpi_os_signal_semaphore                   0.0099
     1 acpi_ns_lookup                             0.0007
     2 acpi_tb_sum_table                          0.0417
     2 acpi_tb_validate_rsdp                      0.0189
     1 scrup                                      0.0053
     1 con_chars_in_buffer                        0.1429
     2 do_con_write                               0.0004
     2 intel_i810_configure                       0.0074
    12 i810_write_dac                             0.2553
    62 i810_read_dac                              1.3478
    26 i810fb_getcolreg                           0.0956
     3 i810_screen_off                            0.0349
     4 i810_enable_cursor                         0.1333
   983 i810fb_cursor                              1.4413
     4 vortex_timer                               0.0049
    14 ide_inb                                    1.2727
     2 ide_outb                                   0.3333
     2 ide_driveid_update                         0.0051
     2 try_to_identify                            0.0019
     1 probe_hwif                                 0.0006
     1 usb_hcd_poll_rh_status                     0.0029
     1 rh_timer_func                              0.1000
     2 usb_hcd_submit_urb                         0.0010
    13 i8042_interrupt                            0.0260
     4 i8042_timer_func                           0.2500
     1 sock_poll                                  0.0476
     1 sock_wfree                                 0.0172
     1 datagram_poll                              0.0045
     1 udp_poll                                   0.0055
     5 unix_poll                                  0.0278
     1 cache_clean                                0.0025
    46 schedule                                   0.0338
     3 preempt_schedule                           0.0361
     2 cond_resched                               0.0408
     3 schedule_timeout                           0.0197
     2 __mutex_unlock_slowpath                    0.0080
     1 mutex_unlock                               0.1000
     9 __mutex_lock_interruptible_slowpath        0.0143
   148 __mutex_lock_slowpath                      0.2814
    11 mutex_lock_nested                          0.0202
     6 _spin_lock                                 0.1200
    26 _write_unlock_irq                          0.3881
     5 _spin_lock_irq                             0.0893
     2 _spin_lock_irqsave                         0.0333
     6 _spin_unlock                               0.0984
   605 _spin_unlock_irqrestore                    6.7978
   700 _spin_unlock_irq                          10.4478
     2 _read_unlock_irqrestore                    0.0225
    19 _read_unlock_irq                           0.2836
    12 _write_unlock_irqrestore                   0.1348
     1 unlock_kernel                              0.0179
     1 __release_kernel_lock                      0.0417
    46 *unknown*
 72643 total                                      0.0308

--------------070001080605050403010203--

--------------enigBA461B5DC5B271D247CD7AE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFHGWgMdB4Whm86/kRAnNFAJ911+qwzYuyC3qs+OZlVyMcXNF2PQCeJ1Hl
FZHPfwOBs2umNYUxIBxWsu4=
=9erU
-----END PGP SIGNATURE-----

--------------enigBA461B5DC5B271D247CD7AE9--
