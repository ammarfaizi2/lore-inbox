Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbTGOR5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269223AbTGOR45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:56:57 -0400
Received: from tazz.wtf.dk ([80.199.6.58]:20865 "EHLO sokrates")
	by vger.kernel.org with ESMTP id S269325AbTGORsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:48:32 -0400
Date: Tue, 15 Jul 2003 20:03:46 +0200
From: Michael Kristensen <michael@wtf.dk>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Unable to boot linux-2.6-test1
Message-ID: <20030715180346.GB3843@sokrates>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi mailing list. First of all I would like to tell you please to send a
copy of all answers to michael@wtf.dk. Thanks.

This is my first Linux "bug report", and I would like you to tell me if
I did anything wrong, or if you need anymore info. I hope you can use
this for anything. The reason I sent the mail to the mailing list, was
that I wasn't sure where else to send it.

[1.] I'm having problems with booting the linux-2.6-test1.

[2.] I'm not sure if I am messing with two different problems. At
compile-time I get some depmod: Unresolved symbols and later, when I try
to boot the kernel, it simply hangs at "Uncompressing Linux... Ok,
booting the kernel". As I said, I'm not sure if it is two different
problems. I will attach the depmod-errors to this email. I will
also attach my .config.

[3.] Keywords? Booting, kernel, depmod, unresolved symbols.

[4.] $ cat /proc/version 
Linux version 2.4.21 (root@sokrates) (gcc version 3.3 (Debian)) #1 Sat
Jun 28 12:00:48 CEST 2003. NOTE: This is not the kernel I am trying to
compile!

[7.]
 [7.1.] Output from scripts/ver_linux
 Linux sokrates 2.4.21 #1 Sat Jun 28 12:00:48 CEST 2003 i686
 GNU/Linux
  
  Gnu C                  2.95.4
  Gnu make               3.80
  util-linux             2.11z
  mount                  2.11z
  module-init-tools      2.4.21
  e2fsprogs              1.34-WIP
  Linux C Library        2.3.1
  Dynamic linker (ldd)   2.3.1
  Procps                 3.1.9
  Net-tools              1.60
  Console-tools          0.2.3
  Sh-utils               5.0
  Modules Loaded         nls_iso8859-1 nls_cp437 vfat fat emu10k1
  ac97_codec ipv6 nls_cp865 nvidia apm smbfs 8139too mii mousedev hid
  keybdev input usb-uhci rtc

  [7.2.] $ cat /proc/cpuinfo 
  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 6
  model name      : AMD Athlon(tm) XP 1800+
  stepping        : 2
  cpu MHz         : 1533.986
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
  cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
  bogomips        : 3060.53

  [7.3.] $ cat /proc/modules 
  nls_iso8859-1           2876   1 (autoclean)
  nls_cp437               4380   1 (autoclean)
  vfat                   10604   1 (autoclean)
  fat                    32056   0 (autoclean) [vfat]
  emu10k1                55884   0
  ac97_codec             11764   0 [emu10k1]
  ipv6                  155668  -1
  nls_cp865               4380   0 (unused)
  nvidia               1539584  10
  apm                    10248   1
  smbfs                  38704   0 (unused)
  8139too                14824   1
  mii                     2464   0 [8139too]
  mousedev                4180   2
  hid                    13928   0 (unused)
  keybdev                 2052   0 (unused)
  input                   3392   0 [mousedev hid keybdev]
  usb-uhci               23280   0 (unused)
  rtc                     6792   0 (autoclean)

  [7.4.] $ cat /proc/ioports
  0000-001f : dma1
  0020-003f : pic1
  0040-005f : timer
  0060-006f : keyboard
  0070-007f : rtc
  0080-008f : dma page reg
  00a0-00bf : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0170-0177 : ide1
  01f0-01f7 : ide0
  02f8-02ff : serial(set)
  0376-0376 : ide1
  03c0-03df : vga+
  03f6-03f6 : ide0
  03f8-03ff : serial(set)
  0cf8-0cff : PCI conf1
  d000-d0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  d000-d0ff : 8139too
  d400-d41f : Creative Labs SB Live! EMU10k1
  d400-d41f : EMU10K1
  d800-d807 : Creative Labs SB Live! MIDI/Game Port
  dc00-dc0f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  dc00-dc07 : ide0
  dc08-dc0f : ide1
  e000-e01f : VIA Technologies, Inc. USB
  e000-e01f : usb-uhci
  e400-e41f : VIA Technologies, Inc. USB (#2)
  e400-e41f : usb-uhci
  e800-e81f : VIA Technologies, Inc. USB (#3)
  e800-e81f : usb-uhci

  $ cat /proc/iomem 
  00000000-0009ffff : System RAM
  000a0000-000bffff : Video RAM area
  000c0000-000c7fff : Video ROM
  000f0000-000fffff : System ROM
  00100000-1ffeffff : System RAM
  00100000-00243e06 : Kernel code
  00243e07-002c14ff : Kernel data
  1fff0000-1fff2fff : ACPI Non-volatile Storage
  1fff3000-1fffffff : ACPI Tables
  e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : nVidia Corporation NV15 [GeForce2 GTS]
  e8000000-ebffffff : VIA Technologies, Inc. VT8367 [KT266]
  ec000000-edffffff : PCI Bus #01
  ec000000-ecffffff : nVidia Corporation NV15 [GeForce2 GTS]
  ee000000-ee0000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  ee000000-ee0000ff : 8139too
  fec00000-fec00fff : reserved
  fee00000-fee00fff : reserved
  ffff0000-ffffffff : reserved

  [7.5.] Output from "lspci -vvv" as root is attached as a file for simplicity.

  [7.6.] $ cat /proc/scsi/scsi 
  Attached devices: none

[8.] It should be said, that I get some "incomplete pointer"-warnings.
Are they important?

-- 
Med Venlig Hilsen/Best Regards/Mit freundlichen Grüßen
Michael Kristensen <michael@wtf.dk>

--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-modules_install.out"

# make modules_install
  INSTALL drivers/net/8139too.ko
  INSTALL sound/oss/ac97_codec.ko
  INSTALL arch/i386/kernel/apm.ko
  INSTALL net/ipv4/netfilter/arp_tables.ko
  INSTALL net/ipv4/netfilter/arpt_mangle.ko
  INSTALL net/ipv4/netfilter/arptable_filter.ko
  INSTALL drivers/input/keyboard/atkbd.ko
  INSTALL net/sched/cls_fw.ko
  INSTALL net/sched/cls_route.ko
  INSTALL net/sched/cls_rsvp.ko
  INSTALL net/sched/cls_rsvp6.ko
  INSTALL net/sched/cls_tcindex.ko
  INSTALL net/sched/cls_u32.ko
  INSTALL lib/crc32.ko
  INSTALL drivers/usb/host/ehci-hcd.ko
  INSTALL sound/oss/emu10k1/emu10k1.ko
  INSTALL fs/exportfs/exportfs.ko
  INSTALL fs/fat/fat.ko
  INSTALL drivers/char/genrtc.ko
  INSTALL drivers/usb/input/hid.ko
  INSTALL drivers/i2c/i2c-core.ko
  INSTALL drivers/i2c/i2c-dev.ko
  INSTALL drivers/i2c/i2c-sensor.ko
  INSTALL drivers/input/input.ko
  INSTALL net/ipv4/netfilter/ip_conntrack.ko
  INSTALL net/ipv4/netfilter/ip_conntrack_amanda.ko
  INSTALL net/ipv4/netfilter/ip_conntrack_ftp.ko
  INSTALL net/ipv4/netfilter/ip_conntrack_irc.ko
  INSTALL net/ipv4/netfilter/ip_conntrack_tftp.ko
  INSTALL net/ipv4/netfilter/ip_nat_amanda.ko
  INSTALL net/ipv4/netfilter/ip_nat_ftp.ko
  INSTALL net/ipv4/netfilter/ip_nat_irc.ko
  INSTALL net/ipv4/netfilter/ip_nat_tftp.ko
  INSTALL net/ipv4/netfilter/ip_tables.ko
  INSTALL net/ipv4/ipip.ko
  INSTALL net/ipv4/netfilter/ipt_DSCP.ko
  INSTALL net/ipv4/netfilter/ipt_ECN.ko
  INSTALL net/ipv4/netfilter/ipt_LOG.ko
  INSTALL net/ipv4/netfilter/ipt_MARK.ko
  INSTALL net/ipv4/netfilter/ipt_MASQUERADE.ko
  INSTALL net/ipv4/netfilter/ipt_REDIRECT.ko
  INSTALL net/ipv4/netfilter/ipt_REJECT.ko
  INSTALL net/ipv4/netfilter/ipt_TCPMSS.ko
  INSTALL net/ipv4/netfilter/ipt_TOS.ko
  INSTALL net/ipv4/netfilter/ipt_ULOG.ko
  INSTALL net/ipv4/netfilter/ipt_ah.ko
  INSTALL net/ipv4/netfilter/ipt_conntrack.ko
  INSTALL net/ipv4/netfilter/ipt_dscp.ko
  INSTALL net/ipv4/netfilter/ipt_ecn.ko
  INSTALL net/ipv4/netfilter/ipt_esp.ko
  INSTALL net/ipv4/netfilter/ipt_helper.ko
  INSTALL net/ipv4/netfilter/ipt_length.ko
  INSTALL net/ipv4/netfilter/ipt_limit.ko
  INSTALL net/ipv4/netfilter/ipt_mac.ko
  INSTALL net/ipv4/netfilter/ipt_mark.ko
  INSTALL net/ipv4/netfilter/ipt_multiport.ko
  INSTALL net/ipv4/netfilter/ipt_owner.ko
  INSTALL net/ipv4/netfilter/ipt_pkttype.ko
  INSTALL net/ipv4/netfilter/ipt_recent.ko
  INSTALL net/ipv4/netfilter/ipt_state.ko
  INSTALL net/ipv4/netfilter/ipt_tcpmss.ko
  INSTALL net/ipv4/netfilter/ipt_tos.ko
  INSTALL net/ipv4/netfilter/ipt_ttl.ko
  INSTALL net/ipv4/netfilter/ipt_unclean.ko
  INSTALL net/ipv4/netfilter/iptable_filter.ko
  INSTALL net/ipv4/netfilter/iptable_mangle.ko
  INSTALL net/ipv4/netfilter/iptable_nat.ko
  INSTALL net/ipv6/ipv6.ko
  INSTALL fs/lockd/lockd.ko
  INSTALL drivers/net/mii.ko
  INSTALL drivers/input/mousedev.ko
  INSTALL fs/nfs/nfs.ko
  INSTALL fs/nfsd/nfsd.ko
  INSTALL fs/nls/nls_cp437.ko
  INSTALL fs/nls/nls_cp850.ko
  INSTALL fs/nls/nls_cp852.ko
  INSTALL fs/nls/nls_cp865.ko
  INSTALL fs/nls/nls_iso8859-1.ko
  INSTALL fs/nls/nls_iso8859-15.ko
  INSTALL fs/nls/nls_utf8.ko
  INSTALL fs/ntfs/ntfs.ko
  INSTALL drivers/input/mouse/psmouse.ko
  INSTALL drivers/block/rd.ko
  INSTALL drivers/char/rtc.ko
  INSTALL net/sched/sch_cbq.ko
  INSTALL net/sched/sch_gred.ko
  INSTALL net/sched/sch_prio.ko
  INSTALL net/sched/sch_red.ko
  INSTALL net/sched/sch_sfq.ko
  INSTALL net/sched/sch_tbf.ko
  INSTALL net/sched/sch_teql.ko
  INSTALL fs/smbfs/smbfs.ko
  INSTALL sound/pci/ac97/snd-ac97-codec.ko
  INSTALL sound/pci/emu10k1/snd-emu10k1.ko
  INSTALL sound/core/snd-hwdep.ko
  INSTALL sound/core/snd-page-alloc.ko
  INSTALL sound/core/snd-pcm.ko
  INSTALL sound/core/snd-rawmidi.ko
  INSTALL sound/core/snd-rtctimer.ko
  INSTALL sound/core/snd-timer.ko
  INSTALL sound/synth/snd-util-mem.ko
  INSTALL sound/core/snd.ko
  INSTALL net/sunrpc/sunrpc.ko
  INSTALL drivers/usb/host/uhci-hcd.ko
  INSTALL fs/vfat/vfat.ko
  INSTALL drivers/i2c/chips/w83781d.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test1; fi
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/drivers/i2c/chips/w83781d.ko
depmod: 	i2c_detach_client
depmod: 	i2c_check_functionality
depmod: 	i2c_smbus_write_word_data
depmod: 	i2c_smbus_read_word_data
depmod: 	i2c_del_driver
depmod: 	i2c_smbus_read_byte_data
depmod: 	i2c_detect
depmod: 	i2c_smbus_write_byte_data
depmod: 	i2c_adapter_id
depmod: 	i2c_attach_client
depmod: 	i2c_add_driver
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/drivers/i2c/i2c-dev.ko
depmod: 	i2c_master_send
depmod: 	i2c_transfer
depmod: 	i2c_smbus_xfer
depmod: 	i2c_del_driver
depmod: 	i2c_get_functionality
depmod: 	i2c_check_addr
depmod: 	i2c_control
depmod: 	i2c_get_adapter
depmod: 	i2c_put_adapter
depmod: 	i2c_master_recv
depmod: 	i2c_add_driver
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/drivers/i2c/i2c-sensor.ko
depmod: 	i2c_check_functionality
depmod: 	i2c_smbus_xfer
depmod: 	i2c_check_addr
depmod: 	i2c_adapter_id
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/drivers/input/keyboard/atkbd.ko
depmod: 	input_register_device
depmod: 	input_unregister_device
depmod: 	input_event
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/drivers/input/mouse/psmouse.ko
depmod: 	input_register_device
depmod: 	input_unregister_device
depmod: 	input_event
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/drivers/input/mousedev.ko
depmod: 	input_close_device
depmod: 	input_open_device
depmod: 	input_register_handler
depmod: 	input_unregister_handler
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/drivers/net/8139too.ko
depmod: 	mii_ethtool_sset
depmod: 	mii_link_ok
depmod: 	crc32_le
depmod: 	mii_ethtool_gset
depmod: 	generic_mii_ioctl
depmod: 	mii_nway_restart
depmod: 	bitreverse
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/drivers/usb/input/hid.ko
depmod: 	input_register_device
depmod: 	input_unregister_device
depmod: 	input_event
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/fs/lockd/lockd.ko
depmod: 	rpciod_up
depmod: 	rpciod_down
depmod: 	xdr_decode_string_inplace
depmod: 	xdr_encode_string
depmod: 	rpc_restart_call
depmod: 	svc_exit_thread
depmod: 	nlm_debug
depmod: 	svc_wake_up
depmod: 	svc_makesock
depmod: 	svc_destroy
depmod: 	rpc_create_client
depmod: 	svc_create_thread
depmod: 	rpc_call_async
depmod: 	xdr_encode_netobj
depmod: 	svc_recv
depmod: 	svc_process
depmod: 	rpc_delay
depmod: 	rpc_destroy_client
depmod: 	xdr_decode_netobj
depmod: 	svc_create
depmod: 	rpc_call_sync
depmod: 	xprt_set_timeout
depmod: 	xprt_destroy
depmod: 	xprt_create_proto
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/fs/nfs/nfs.ko
depmod: 	rpc_wake_up_task
depmod: 	rpc_killall_tasks
depmod: 	rpc_init_task
depmod: 	xdr_encode_pages
depmod: 	rpc_setbufsize
depmod: 	nlmclnt_proc
depmod: 	rpc_shutdown_client
depmod: 	rpciod_up
depmod: 	rpciod_down
depmod: 	xdr_inline_pages
depmod: 	lockd_down
depmod: 	rpc_clnt_sigmask
depmod: 	lockd_up
depmod: 	rpc_proc_unregister
depmod: 	xdr_encode_array
depmod: 	nfs_debug
depmod: 	rpc_create_client
depmod: 	rpc_sleep_on
depmod: 	rpcauth_lookupcred
depmod: 	rpc_clnt_sigunmask
depmod: 	rpc_call_setup
depmod: 	rpc_call_sync
depmod: 	put_rpccred
depmod: 	xprt_destroy
depmod: 	rpc_execute
depmod: 	rpc_proc_register
depmod: 	xdr_shift_buf
depmod: 	xprt_create_proto
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/fs/nfsd/nfsd.ko
depmod: 	nlmsvc_ops
depmod: 	auth_domain_find
depmod: 	lockd_down
depmod: 	cache_fresh
depmod: 	unix_domain_find
depmod: 	auth_domain_put
depmod: 	xdr_decode_string_inplace
depmod: 	svc_reserve
depmod: 	cache_flush
depmod: 	cache_unregister
depmod: 	svc_exit_thread
depmod: 	svc_proc_unregister
depmod: 	cache_check
depmod: 	lockd_up
depmod: 	svcauth_unix_purge
depmod: 	xdr_encode_array
depmod: 	svc_makesock
depmod: 	svc_destroy
depmod: 	svc_create_thread
depmod: 	svc_recv
depmod: 	cache_purge
depmod: 	svc_process
depmod: 	find_exported_dentry
depmod: 	svc_create
depmod: 	cache_register
depmod: 	auth_unix_lookup
depmod: 	auth_unix_add_addr
depmod: 	qword_add
depmod: 	cache_init
depmod: 	qword_get
depmod: 	auth_unix_forget_old
depmod: 	nfsd_debug
depmod: 	svc_proc_register
depmod: 	export_op_default
depmod: 	qword_addhex
depmod: 	svc_proc_read
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/fs/vfat/vfat.ko
depmod: 	fat_scan
depmod: 	fat_dir_empty
depmod: 	fat_add_entries
depmod: 	fat__get_entry
depmod: 	fat_notify_change
depmod: 	fat_date_unix2dos
depmod: 	fat_build_inode
depmod: 	fat_search_long
depmod: 	fat_detach
depmod: 	fat_attach
depmod: 	fat_new_dir
depmod: 	fat_fill_super
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/arpt_mangle.ko
depmod: 	arpt_unregister_target
depmod: 	arpt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/arptable_filter.ko
depmod: 	arpt_register_table
depmod: 	arpt_do_table
depmod: 	arpt_unregister_table
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ip_conntrack_amanda.ko
depmod: 	ip_conntrack_helper_register
depmod: 	ip_conntrack_expect_related
depmod: 	ip_conntrack_helper_unregister
depmod: 	ip_ct_refresh
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ip_conntrack_ftp.ko
depmod: 	ip_conntrack_helper_register
depmod: 	ip_conntrack_expect_related
depmod: 	ip_conntrack_helper_unregister
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ip_conntrack_irc.ko
depmod: 	ip_conntrack_helper_register
depmod: 	ip_conntrack_expect_related
depmod: 	ip_conntrack_helper_unregister
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ip_conntrack_tftp.ko
depmod: 	ip_conntrack_helper_register
depmod: 	ip_conntrack_expect_related
depmod: 	ip_conntrack_helper_unregister
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ip_nat_amanda.ko
depmod: 	needs_ip_conntrack_amanda
depmod: 	ip_nat_helper_register
depmod: 	ip_conntrack_change_expect
depmod: 	ip_nat_mangle_udp_packet
depmod: 	ip_nat_helper_unregister
depmod: 	ip_nat_setup_info
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ip_nat_ftp.ko
depmod: 	needs_ip_conntrack_ftp
depmod: 	ip_nat_helper_register
depmod: 	ip_conntrack_change_expect
depmod: 	ip_nat_helper_unregister
depmod: 	ip_nat_mangle_tcp_packet
depmod: 	ip_nat_setup_info
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ip_nat_irc.ko
depmod: 	ip_nat_helper_register
depmod: 	ip_conntrack_change_expect
depmod: 	ip_nat_helper_unregister
depmod: 	needs_ip_conntrack_irc
depmod: 	ip_nat_mangle_tcp_packet
depmod: 	ip_nat_setup_info
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ip_nat_tftp.ko
depmod: 	ip_nat_helper_register
depmod: 	ip_conntrack_change_expect
depmod: 	ip_nat_helper_unregister
depmod: 	ip_nat_setup_info
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_DSCP.ko
depmod: 	ipt_unregister_target
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_ECN.ko
depmod: 	ipt_unregister_target
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_LOG.ko
depmod: 	ipt_unregister_target
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_MARK.ko
depmod: 	ipt_unregister_target
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_MASQUERADE.ko
depmod: 	ipt_unregister_target
depmod: 	ip_conntrack_get
depmod: 	ip_ct_selective_cleanup
depmod: 	ip_nat_setup_info
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_REDIRECT.ko
depmod: 	ipt_unregister_target
depmod: 	ip_conntrack_get
depmod: 	ip_nat_setup_info
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_REJECT.ko
depmod: 	ipt_unregister_target
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_TCPMSS.ko
depmod: 	ipt_unregister_target
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_TOS.ko
depmod: 	ipt_unregister_target
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_ULOG.ko
depmod: 	ipt_unregister_target
depmod: 	ipt_register_target
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_ah.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_conntrack.ko
depmod: 	need_ip_conntrack
depmod: 	ipt_register_match
depmod: 	ip_conntrack_get
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_dscp.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_ecn.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_esp.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_helper.ko
depmod: 	need_ip_conntrack
depmod: 	ipt_register_match
depmod: 	ip_conntrack_get
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_length.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_limit.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_mac.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_mark.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_multiport.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_owner.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_pkttype.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_recent.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_state.ko
depmod: 	need_ip_conntrack
depmod: 	ipt_register_match
depmod: 	ip_conntrack_get
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_tcpmss.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_tos.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_ttl.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/ipt_unclean.ko
depmod: 	ipt_register_match
depmod: 	ipt_unregister_match
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/iptable_filter.ko
depmod: 	ipt_unregister_table
depmod: 	ipt_do_table
depmod: 	ipt_register_table
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/iptable_mangle.ko
depmod: 	ipt_unregister_table
depmod: 	ipt_do_table
depmod: 	ipt_register_table
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/net/ipv4/netfilter/iptable_nat.ko
depmod: 	ip_conntrack_destroyed
depmod: 	ipt_unregister_table
depmod: 	need_ip_conntrack
depmod: 	ipt_do_table
depmod: 	ipt_unregister_target
depmod: 	__ip_ct_find_proto
depmod: 	ip_conntrack_get
depmod: 	ipt_register_table
depmod: 	ip_ct_selective_cleanup
depmod: 	ip_conntrack_alter_reply
depmod: 	ip_conntrack_htable_size
depmod: 	ip_ct_gather_frags
depmod: 	ip_conntrack_tuple_taken
depmod: 	ipt_register_target
depmod: 	invert_tuplepr
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/core/snd-hwdep.ko
depmod: 	snd_register_device
depmod: 	snd_kcalloc
depmod: 	snd_info_create_module_entry
depmod: 	snd_info_free_entry
depmod: 	snd_device_new
depmod: 	snd_ctl_unregister_ioctl
depmod: 	snd_unregister_device
depmod: 	snd_iprintf
depmod: 	snd_info_register
depmod: 	snd_ctl_register_ioctl
depmod: 	snd_info_unregister
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/core/snd-pcm.ko
depmod: 	snd_timer_new
depmod: 	snd_dma_free_reserved
depmod: 	snd_free_pages
depmod: 	snd_register_device
depmod: 	snd_timer_notify
depmod: 	snd_dma_alloc_pages
depmod: 	snd_info_get_line
depmod: 	snd_card_file_remove
depmod: 	snd_kcalloc
depmod: 	snd_info_create_module_entry
depmod: 	snd_info_free_entry
depmod: 	snd_card_file_add
depmod: 	snd_info_create_card_entry
depmod: 	snd_dma_set_reserved
depmod: 	snd_device_new
depmod: 	snd_power_wait
depmod: 	snd_ctl_unregister_ioctl
depmod: 	snd_unregister_device
depmod: 	snd_iprintf
depmod: 	snd_device_free
depmod: 	snd_timer_interrupt
depmod: 	snd_info_register
depmod: 	snd_ctl_register_ioctl
depmod: 	snd_device_register
depmod: 	snd_major
depmod: 	snd_dma_get_reserved
depmod: 	snd_malloc_pages
depmod: 	snd_info_get_str
depmod: 	snd_info_unregister
depmod: 	snd_dma_free_pages
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/core/snd-rawmidi.ko
depmod: 	snd_register_device
depmod: 	snd_card_file_remove
depmod: 	snd_kcalloc
depmod: 	snd_info_free_entry
depmod: 	snd_card_file_add
depmod: 	snd_info_create_card_entry
depmod: 	snd_device_new
depmod: 	snd_ctl_unregister_ioctl
depmod: 	snd_unregister_device
depmod: 	snd_iprintf
depmod: 	snd_info_register
depmod: 	snd_ctl_register_ioctl
depmod: 	snd_info_unregister
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/core/snd-rtctimer.ko
depmod: 	rtc_register
depmod: 	snd_timer_global_register
depmod: 	rtc_unregister
depmod: 	snd_timer_global_new
depmod: 	snd_timer_global_unregister
depmod: 	rtc_control
depmod: 	snd_timer_interrupt
depmod: 	snd_timer_global_free
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/core/snd-timer.ko
depmod: 	snd_ecards_limit
depmod: 	snd_register_device
depmod: 	snd_kcalloc
depmod: 	snd_info_create_module_entry
depmod: 	snd_info_free_entry
depmod: 	snd_device_new
depmod: 	snd_unregister_device
depmod: 	snd_iprintf
depmod: 	snd_info_register
depmod: 	snd_kmalloc_strdup
depmod: 	snd_info_unregister
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/oss/emu10k1/emu10k1.ko
depmod: 	ac97_probe_codec
depmod: 	ac97_alloc_codec
depmod: 	ac97_read_proc
depmod: 	ac97_release_codec
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/pci/ac97/snd-ac97-codec.ko
depmod: 	snd_kcalloc
depmod: 	snd_ctl_find_id
depmod: 	snd_ctl_add
depmod: 	snd_device_new
depmod: 	snd_card_proc_new
depmod: 	snd_component_add
depmod: 	snd_iprintf
depmod: 	snd_ctl_remove_id
depmod: 	snd_ctl_new1
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/pci/emu10k1/snd-emu10k1.ko
depmod: 	snd_pcm_new
depmod: 	snd_hwdep_new
depmod: 	snd_ctl_notify
depmod: 	snd_util_memhdr_new
depmod: 	snd_malloc_pci_pages
depmod: 	snd_pcm_format_width
depmod: 	snd_pcm_lib_free_pages
depmod: 	snd_kcalloc
depmod: 	snd_ctl_find_id
depmod: 	__snd_util_memblk_new
depmod: 	__snd_util_mem_free
depmod: 	snd_malloc_pci_page
depmod: 	snd_ctl_add
depmod: 	snd_device_new
depmod: 	snd_rawmidi_receive
depmod: 	snd_pcm_lib_malloc_pages
depmod: 	snd_rawmidi_new
depmod: 	snd_pcm_period_elapsed
depmod: 	snd_card_proc_new
depmod: 	snd_ctl_remove
depmod: 	snd_rawmidi_set_ops
depmod: 	snd_rawmidi_transmit
depmod: 	snd_pcm_hw_constraint_minmax
depmod: 	__snd_util_mem_alloc
depmod: 	snd_iprintf
depmod: 	snd_pcm_lib_preallocate_free_for_all
depmod: 	snd_pcm_set_ops
depmod: 	snd_util_memhdr_free
depmod: 	snd_ac97_mixer
depmod: 	snd_pcm_hw_constraint_integer
depmod: 	snd_pcm_lib_ioctl
depmod: 	snd_card_register
depmod: 	snd_ctl_new1
depmod: 	snd_pcm_lib_preallocate_sg_pages
depmod: 	snd_pcm_lib_preallocate_pci_pages
depmod: 	snd_pcm_sgbuf_ops_page
depmod: 	snd_pcm_hw_constraint_list
depmod: 	snd_pcm_lib_preallocate_pci_pages_for_all
depmod: 	snd_card_free
depmod: 	snd_free_pci_pages
depmod: 	snd_card_new
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test1/kernel/sound/synth/snd-util-mem.ko
depmod: 	snd_kcalloc

--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-vvv.out"

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x2
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Surecom Technology EP-320X-R
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs: Unknown device 8064
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at d400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at d800 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at dc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS/Pro] (rev a4) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 400e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x2


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_TUNNEL is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_CSZ is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_INGRESS is not set
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=m
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m

#
# I2C Hardware Sensors Mainboard support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C Hardware Sensors Chip support
#
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
CONFIG_GEN_RTC=m
# CONFIG_GEN_RTC_X is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_BIOS_REBOOT=y

--DKU6Jbt7q3WqK7+M--
