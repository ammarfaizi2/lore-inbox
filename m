Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271513AbRHPHsr>; Thu, 16 Aug 2001 03:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271515AbRHPHsi>; Thu, 16 Aug 2001 03:48:38 -0400
Received: from N23ch-01p18.ppp11.odn.ad.jp ([61.116.127.18]:27126 "HELO
	220fx.luky.org") by vger.kernel.org with SMTP id <S271513AbRHPHsZ>;
	Thu, 16 Aug 2001 03:48:25 -0400
To: axboe@suse.de
Cc: shibata@luky.org, linux-kernel@vger.kernel.org
Subject: Re: 4.7GB DVD-RAM geometry wrong?
In-Reply-To: <20010816085025.M4352@suse.de>
In-Reply-To: <20010815233424P.shibata@luky.org>
	<20010816114439K.shibata@luky.org>
	<20010816085025.M4352@suse.de>
X-Face: (p:N+d=)]R.hGpO.WD'FWD}r"'N]'G~TQL>ZMHN6Ev":krdN|{+={]m/yqX7|9Qzu[eX[+}
 ^=d9Vr7#OCKV?ZAYq=#iG2v&fyuJZWeVwGrmTRvpcWiSTzga-$8/W\XR"r]63S56VQ@[8w}/;iq)sm
 1=B_r2J$Uf~aN5@8f2Fk$Oa[wZ
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010816165326B.shibata@luky.org>
Date: Thu, 16 Aug 2001 16:53:26 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Axboe-sama,

> > But other problem has come with 4.7GB(9.4GB) ATAPI(IDE) DVD-RAM drive
> > named HITACHI GF-2000.
> > 
> > Here is my dmesg.
> > While I did "cp -auv DIR/ /mnt/floppy/", segv has happend.
> > file system on DVD-RAM is UDF.
> 
> Please run that through ksymoops, the trace is worthless without it. See
> below.
> 
> > Warning only 896MB will be used.
> > Use a HIGHMEM enabled kernel.
> 
> Hint :-)
> 
> > invalid operand: 0000
> > CPU:    0
> > EIP:    0010:[<c01440f8>]
> > EFLAGS: 00010202
> > eax: ffffffff   ebx: d26f53a0   ecx: d26f53a0   edx: 00000001
> > esi: fad31120   edi: de1c96c0   ebp: d26f53a0   esp: de159e60
> > ds: 0018   es: 0018   ss: 0018
> > Process cp (pid: 930, stackpage=de159000)
> > Stack: d26f53a0 de159ed4 fad272e3 d26f53a0 fffffffb f7cd6000 c0143d97 00000000 
> >        f5dbe8a0 de1c96c0 de159f8c 00000000 fad2651d f5dbe8a0 f5dbe8a0 00000000 
> >        c1f22700 00020101 000100a8 00349be2 000c8066 1b000001 00000800 000c82c9 
> > Call Trace: [<fad272e3>] [<c0143d97>] [<fad2651d>] [<c013b585>] [<c013b41a>] 
> >    [<c013b70c>] [<c0130113>] [<c0130026>] [<c0130314>] [<c0106ccb>] 
> > 
> > Code: 0f 0b e9 86 00 00 00 90 39 1b 74 3c f6 83 08 01 00 00 0f 75 
> 
> This part.

I got many warnings. but I dare send this.

I hope it will be your help and mine.



ksymoops 2.4.0 on i686 2.4.8-ac5.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac5/ (default)
     -m /boot/System.map-2.4.8-ac5 (default)

Warning (compare_maps): ksyms_base symbol __journal_abort_R__ver___journal_abort not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol jbd_preclean_buffer_check_R__ver_jbd_preclean_buffer_check not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol jh_splice_lock_R__ver_jh_splice_lock not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_abort_R__ver_journal_abort not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_ack_err_R__ver_journal_ack_err not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_blocks_per_page_R__ver_journal_blocks_per_page not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_bmap_R__ver_journal_bmap not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_check_available_features_R__ver_journal_check_available_features not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_check_used_features_R__ver_journal_check_used_features not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_clear_err_R__ver_journal_clear_err not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_create_R__ver_journal_create not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_destroy_R__ver_journal_destroy not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_dirty_data_R__ver_journal_dirty_data not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_dirty_metadata_R__ver_journal_dirty_metadata not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_enable_debug_R__ver_journal_enable_debug not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_errno_R__ver_journal_errno not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_extend_R__ver_journal_extend not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_flush_R__ver_journal_flush not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_flushpage_R__ver_journal_flushpage not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_force_commit_R__ver_journal_force_commit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_forget_R__ver_journal_forget not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_get_create_access_R__ver_journal_get_create_access not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_get_undo_access_R__ver_journal_get_undo_access not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_get_write_access_R__ver_journal_get_write_access not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_init_dev_R__ver_journal_init_dev not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_init_inode_R__ver_journal_init_inode not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_load_R__ver_journal_load not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_lock_updates_R__ver_journal_lock_updates not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_no_write_R__ver_journal_no_write not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_oom_retry_R__ver_journal_oom_retry not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_recover_R__ver_journal_recover not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_restart_R__ver_journal_restart not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_revoke_R__ver_journal_revoke not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_set_features_R__ver_journal_set_features not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_start_R__ver_journal_start not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_stop_R__ver_journal_stop not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_try_start_R__ver_journal_try_start not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_try_to_free_buffers_R__ver_journal_try_to_free_buffers not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_unlock_updates_R__ver_journal_unlock_updates not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_update_format_R__ver_journal_update_format not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_update_superblock_R__ver_journal_update_superblock not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol journal_wipe_R__ver_journal_wipe not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol log_start_commit_R__ver_log_start_commit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol log_wait_commit_R__ver_log_wait_commit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01cc0e0, System.map says c014bf80.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol r128_cce_buffer  , r128 says f8982560, /lib/modules/2.4.8-ac5/kernel/drivers/char/drm-4.0/r128.o says f8980d40.  Ignoring /lib/modules/2.4.8-ac5/kernel/drivers/char/drm-4.0/r128.o entry
Warning (compare_maps): mismatch on symbol r128_res_ctx  , r128 says f898253c, /lib/modules/2.4.8-ac5/kernel/drivers/char/drm-4.0/r128.o says f8980d1c.  Ignoring /lib/modules/2.4.8-ac5/kernel/drivers/char/drm-4.0/r128.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says f895af54, /lib/modules/2.4.8-ac5/kernel/fs/lockd/lockd.o says f895a8c0.  Ignoring /lib/modules/2.4.8-ac5/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says f895af50, /lib/modules/2.4.8-ac5/kernel/fs/lockd/lockd.o says f895a8bc.  Ignoring /lib/modules/2.4.8-ac5/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says f895af58, /lib/modules/2.4.8-ac5/kernel/fs/lockd/lockd.o says f895a8c4.  Ignoring /lib/modules/2.4.8-ac5/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says f893ea80, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e740.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says f893ea84, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e744.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says f893ea88, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e748.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says f893ea7c, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e73c.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says f893ea5c, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e71c.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says f893ea4c, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e70c.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says f893ea60, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e720.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says f893ea44, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e704.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says f893ea48, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e708.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says f893ea40, /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o says f893e700.  Ignoring /lib/modules/2.4.8-ac5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol raid1_retry_tail  , raid1 says f892e01c, /lib/modules/2.4.8-ac5/kernel/drivers/md/raid1.o says f892dec0.  Ignoring /lib/modules/2.4.8-ac5/kernel/drivers/md/raid1.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says f8929300, /lib/modules/2.4.8-ac5/kernel/drivers/usb/usbcore.o says f89291c0.  Ignoring /lib/modules/2.4.8-ac5/kernel/drivers/usb/usbcore.o entry
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0143c98>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: ffffffff   ebx: ea39b960   ecx: ea39b960   edx: 00000001
esi: f8984120   edi: d0805c20   ebp: ea39b960   esp: f3b8fe60
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 25830, stackpage=f3b8f000)
Stack: ea39b960 f3b8fed4 f897a2e3 ea39b960 fffffffb 000c82f4 00000000 00000000 
       dd8fc540 d0805c20 f3b8ff8c 00000000 f897951d dd8fc540 dd8fc540 00000000 
       c1f8acd0 00020101 000100a8 00349be2 000c8066 1b000001 00000800 000c82c9 
Call Trace: [<f897a2e3>] [<f897951d>] [<c013b125>] [<c013afba>] [<c013b2ac>] 
   [<c012fe63>] [<c012fd76>] [<c0130064>] [<c0106ccb>] 
Code: 0f 0b e9 86 00 00 00 90 39 1b 74 3c f6 83 08 01 00 00 0f 75 

>>EIP; c0143c98 <get_empty_inode+68/80>   <=====
Trace; f897a2e3 <[r128]drm_dma_setup+63/80>
Trace; f897951d <[r128]drm_getunique+cd/f0>
Trace; c013b125 <path_walk+6e5/750>
Trace; c013afba <path_walk+57a/750>
Trace; c013b2ac <set_fs_altroot+3c/50>
Trace; c012fe63 <chown_common+43/f0>
Trace; c012fd76 <sys_fchmod+86/90>
Trace; c0130064 <dentry_open+14/140>
Trace; c0106ccb <system_call+33/38>
Code;  c0143c98 <get_empty_inode+68/80>
00000000 <_EIP>:
Code;  c0143c98 <get_empty_inode+68/80>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0143c9a <get_empty_inode+6a/80>
   2:   e9 86 00 00 00            jmp    8d <_EIP+0x8d> c0143d25 <get_new_inode+75/160>
Code;  c0143c9f <get_empty_inode+6f/80>
   7:   90                        nop    
Code;  c0143ca0 <get_empty_inode+70/80>
   8:   39 1b                     cmp    %ebx,(%ebx)
Code;  c0143ca2 <get_empty_inode+72/80>
   a:   74 3c                     je     48 <_EIP+0x48> c0143ce0 <get_new_inode+30/160>
Code;  c0143ca4 <get_empty_inode+74/80>
   c:   f6 83 08 01 00 00 0f      testb  $0xf,0x108(%ebx)
Code;  c0143cab <get_empty_inode+7b/80>
  13:   75 00                     jne    15 <_EIP+0x15> c0143cad <get_empty_inode+7d/80>


62 warnings issued.  Results may not be reliable.

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata @ Fukuoka, JAPAN
0(mmm)0 IRC: #luky
   ~    http://his.luky.org/ http://hoop.euqset.org/
