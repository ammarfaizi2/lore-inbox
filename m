Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVCVThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVCVThU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCVTgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:36:21 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:15494 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261691AbVCVTaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:30:25 -0500
Date: Tue, 22 Mar 2005 20:30:14 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
Message-ID: <20050322193014.GD27733@wohnheim.fh-wedel.de>
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050322171340.GE1948@stusta.de> <42405AD6.9010804@namesys.com> <20050322192122.GG1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050322192122.GG1948@stusta.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Pruned Hans&co from Cc: list]

On Tue, 22 March 2005 20:21:22 +0100, Adrian Bunk wrote:
> 
> My plan is to send a patch to Andrew that unconditionally enables 
> 4KSTACKS for shaking out the last bugs before possibly removing
> 8 kB stacks completely.

In that case you might find this output relevant.  It was generated
for 2.6.11 (no -mm).

Without recursions I cannot find a single code path chewing up 3k or
more, so any bugs will likely be somewhere in this list.

WARNING: trivial recursion detected:
     120  find_in_devfs
WARNING: trivial recursion detected:
       0  apm_console_blank
WARNING: trivial recursion detected:
       0  unregister_proc_table
WARNING: trivial recursion detected:
       0  register_proc_table
WARNING: recursion detected:
       0  handle_stop_signal
     128  do_notify_parent_cldstop
       0  __group_send_sig_info
WARNING: trivial recursion detected:
      12  __vmalloc
WARNING: trivial recursion detected:
       0  blkdev_put
WARNING: trivial recursion detected:
      28  remove_tree
WARNING: trivial recursion detected:
      20  find_tree_dqentry
WARNING: trivial recursion detected:
      36  do_insert_tree
WARNING: recursion detected:
      16  affs_get_extblock_slow
       0  affs_get_extblock
WARNING: trivial recursion detected:
      12  _devfs_walk_path
WARNING: trivial recursion detected:
      20  _devfs_unregister
WARNING: trivial recursion detected:
      20  ext2_free_branches
WARNING: trivial recursion detected:
      24  ext3_free_branches
WARNING: trivial recursion detected:
      48  vxfs_bmap_indir
WARNING: trivial recursion detected:
      28  jffs_print_tree
WARNING: trivial recursion detected:
      48  dbAdjCtl
WARNING: recursion detected:
       0  lmGCwrite
      16  lbmWrite
      16  lbmStartIO
      16  lbmIODone
      12  lmPostGC
WARNING: recursion detected:
      16  lbmWrite
      16  lbmStartIO
      16  lbmIODone
      12  lmPostGC
WARNING: trivial recursion detected:
      12  free_branches
WARNING: trivial recursion detected:
      12  free_branches
WARNING: recursion detected:
       0  unhash_stateowner
       0  release_stateid
       0  release_stateid_lockowner
       0  release_stateowner
WARNING: trivial recursion detected:
      44  __ntfs_bitmap_set_bits_in_run
WARNING: trivial recursion detected:
      60  __ntfs_cluster_free
WARNING: recursion detected:
       0  journal_join
      60  do_journal_begin_r
WARNING: recursion detected:
      28  flush_commit_list
      12  flush_older_commits
WARNING: recursion detected:
      40  flush_journal_list
       0  flush_older_journal_lists
WARNING: trivial recursion detected:
      16  free_branches
WARNING: trivial recursion detected:
      40  __udf_read_inode
WARNING: trivial recursion detected:
      16  udf_load_logicalvolint
WARNING: trivial recursion detected:
      44  xfs_attr_node_inactive
WARNING: trivial recursion detected:
      24  xfs_bmap_count_tree
WARNING: recursion detected:
      56  xfs_map_unwritten
      60  xfs_convert_page
WARNING: trivial recursion detected:
      44  qsort
WARNING: trivial recursion detected:
      20  acpi_os_derive_pci_id_2
WARNING: trivial recursion detected:
      32  acpi_ex_dump_operand
WARNING: trivial recursion detected:
       0  aligned_kmalloc
WARNING: recursion detected:
       0  set_dor
       0  floppy_release_irq_and_dma
WARNING: trivial recursion detected:
      36  xd_command
WARNING: trivial recursion detected:
      80  pkt_make_request
WARNING: recursion detected:
      12  read_subcode
      12  check_drive_status
WARNING: recursion detected:
     448  extract_entropy
       0  xfer_secondary_pool
WARNING: recursion detected:
      20  ipmi_heartbeat
       0  ipmi_set_timeout
WARNING: recursion detected:
      16  hd_request
      16  reset_hd
WARNING: trivial recursion detected:
      60  ide_timing_compute
WARNING: trivial recursion detected:
      60  ide_timing_compute
WARNING: trivial recursion detected:
      60  ide_timing_compute
WARNING: trivial recursion detected:
     332  idetape_space_over_filemarks
WARNING: trivial recursion detected:
      40  nodemgr_process_unit_directory
WARNING: trivial recursion detected:
      28  sbp2_parse_unit_directory
WARNING: trivial recursion detected:
      16  protocol_message_2_pars
WARNING: trivial recursion detected:
      16  pars_2_message
WARNING: trivial recursion detected:
       0  message_2_pars
WARNING: recursion detected:
       0  plci_remove
       0  plci_remove_check
       0  CodecIdCheck
WARNING: recursion detected:
      24  Amd7930_new_ph
       0  Amd7930_get_state
WARNING: trivial recursion detected:
      12  isdn_net_realrm
WARNING: trivial recursion detected:
     112  isdn_net_hangup
WARNING: recursion detected:
      52  isdn_tty_modem_result
     116  isdn_tty_cmd_ATA
WARNING: recursion detected:
       0  isdn_wildmat
       0  isdn_star
WARNING: trivial recursion detected:
     112  icn_stopcard
WARNING: trivial recursion detected:
      76  linear_make_request
WARNING: trivial recursion detected:
      76  raid0_make_request
WARNING: trivial recursion detected:
      88  make_request
WARNING: trivial recursion detected:
     132  cinergyt2_ioctl
WARNING: trivial recursion detected:
      60  dib3000mb_set_frontend
WARNING: trivial recursion detected:
      64  dib3000mc_set_frontend
WARNING: trivial recursion detected:
      28  write_ipack
WARNING: trivial recursion detected:
      12  av7110_ipack_instant_repack
WARNING: trivial recursion detected:
      24  do_command
WARNING: trivial recursion detected:
       0  i2o_proc_subdir_remove
WARNING: recursion detected:
       0  exec_next_command
       0  do_exec_command
WARNING: trivial recursion detected:
      48  newpart
WARNING: trivial recursion detected:
     128  put_chip
WARNING: trivial recursion detected:
     500  get_chip
WARNING: trivial recursion detected:
      36  check_sig
WARNING: multiple recursions around check_sig()
WARNING: recursion detected:
      36  check_sig
       0  smc91c92_event
     504  smc91c92_config
WARNING: recursion detected:
       0  tms380tr_exec_cmd
       0  tms380tr_chk_outstanding_cmds
WARNING: recursion detected:
      12  smctr_status_chg
       0  smctr_open_tr
WARNING: trivial recursion detected:
      28  dc2114x_autoconf
WARNING: trivial recursion detected:
      32  dc21140m_autoconf
WARNING: trivial recursion detected:
      16  dc21041_autoconf
WARNING: trivial recursion detected:
      20  dc21040_autoconf
WARNING: trivial recursion detected:
       0  mgt_le_to_cpu
WARNING: trivial recursion detected:
       0  mgt_cpu_to_le
WARNING: recursion detected:
      28  i596_add_cmd
       0  i596_reset
      20  init_i596_mem
WARNING: recursion detected:
       0  i596_add_cmd
       0  i596_reset
       0  init_i596
WARNING: trivial recursion detected:
      24  parport_daisy_init
WARNING: trivial recursion detected:
       0  pci_enable_bridges
WARNING: trivial recursion detected:
       0  pci_bus_add_devices
WARNING: trivial recursion detected:
       0  pci_bus_max_busnr
WARNING: trivial recursion detected:
       0  pci_do_find_bus
WARNING: recursion detected:
      36  configure_new_device
     112  configure_new_function
WARNING: trivial recursion detected:
      28  cpqhp_valid_replace
WARNING: trivial recursion detected:
      36  cpqhp_save_config
WARNING: trivial recursion detected:
      28  cpqhp_save_base_addr_length
WARNING: trivial recursion detected:
      24  cpqhp_configure_board
WARNING: trivial recursion detected:
      84  ibmphp_configure_card
WARNING: trivial recursion detected:
       0  ibmphp_remove_resource
WARNING: recursion detected:
     268  configure_new_device
     372  configure_new_function
WARNING: trivial recursion detected:
     264  shpchp_save_config
WARNING: trivial recursion detected:
       0  shpchprm_free_bridges
WARNING: trivial recursion detected:
      28  print_acpi_resources
WARNING: trivial recursion detected:
       0  get_number_of_slots
WARNING: trivial recursion detected:
       0  get_acpi_slot
WARNING: trivial recursion detected:
       0  find_acpi_bridge_by_bus
WARNING: trivial recursion detected:
       0  pci_rescan_buses
WARNING: trivial recursion detected:
      16  disable_slot
WARNING: trivial recursion detected:
       0  pci_bus_size_bridges
WARNING: trivial recursion detected:
      12  pci_bus_assign_resources
WARNING: trivial recursion detected:
       0  cardbus_assign_irqs
WARNING: trivial recursion detected:
       0  inv_probe
WARNING: recursion detected:
       0  qla1280_rst_aen
       0  qla1280_marker
       0  qla1280_req_pkt
       0  qla1280_poll
WARNING: recursion detected:
       0  qla1280_marker
       0  qla1280_req_pkt
       0  qla1280_poll
       0  qla1280_done
WARNING: recursion detected:
      24  gdth_next
       0  gdth_wait
      12  gdth_interrupt
WARNING: recursion detected:
       0  wait_tulip
       0  int_tul_resel
WARNING: recursion detected:
      12  ipr_initiate_ioa_reset
       0  _ipr_initiate_ioa_reset
      20  ipr_reset_ioa_job
WARNING: trivial recursion detected:
      64  st_int_ioctl
WARNING: recursion detected:
      36  osst_wait_ready
      24  osst_write_error_recovery
      32  osst_set_frame_position
WARNING: trivial recursion detected:
       0  usb_audio_recurseunit
WARNING: recursion detected:
      16  usb_audio_selectorunit
       0  usb_audio_recurseunit
       0  usb_audio_recurseunit
WARNING: multiple recursions around usb_audio_recurseunit()
WARNING: recursion detected:
       0  usb_audio_recurseunit
       0  usb_audio_processingunit
WARNING: trivial recursion detected:
      20  match_device
WARNING: trivial recursion detected:
      16  usb_disconnect
WARNING: trivial recursion detected:
       0  recursively_mark_NOTATTACHED
WARNING: trivial recursion detected:
       0  locktree
WARNING: trivial recursion detected:
      48  usb_device_dump
WARNING: recursion detected:
       0  start_unlink_async
       0  end_unlink_async
WARNING: recursion detected:
       0  unlink_async
       0  start_unlink_async
       0  end_unlink_async
      44  qh_completions
WARNING: trivial recursion detected:
      40  uhci_show_qh
WARNING: trivial recursion detected:
      12  read_frame
WARNING: trivial recursion detected:
       0  auerchain_complete
WARNING: recursion detected:
      28  auerswald_ctrlread_complete
      28  auerswald_ctrlread_wretcomplete
WARNING: trivial recursion detected:
      12  change_mode
WARNING: trivial recursion detected:
      36  fbcon_bmove_rec
WARNING: recursion detected:
       0  fbcon_set_origin
      16  fbcon_scrolldelta
      28  fbcon_cursor
WARNING: recursion detected:
      16  wait_ring
       0  do_flush
WARNING: trivial recursion detected:
       0  snd_pcm_trigger_tstamp
WARNING: recursion detected:
      12  snd_seq_deliver_single_event
      32  bounce_error_event
WARNING: trivial recursion detected:
      12  step_envelope
WARNING: trivial recursion detected:
       0  pas_mixer_set
WARNING: recursion detected:
      32  timer_ext_event
       0  stop_metronome
       0  mpu_cmd
      20  mpu401_command
      16  mpu_input_scanner
WARNING: trivial recursion detected:
       0  ac97_scale_to_oss_val
WARNING: trivial recursion detected:
       0  ac97_scale_from_oss_val
WARNING: recursion detected:
       0  dsp_full_reset
       0  initialize
      24  mixer_setup
       0  chk_send_dsp_cmd
WARNING: recursion detected:
       0  dsp_full_reset
       0  initialize
      28  mixer_setup
       0  chk_send_dsp_cmd
WARNING: recursion detected:
       0  set_recsrc
       0  chk_send_dsp_cmd
       0  dsp_full_reset
       0  force_recsrc
WARNING: trivial recursion detected:
      20  search_zones
WARNING: recursion detected:
       0  snd_usb_create_quirk
       0  create_composite_quirk
WARNING: trivial recursion detected:
       0  check_input_term
WARNING: recursion detected:
       0  parse_audio_unit
      56  parse_audio_selector_unit
WARNING: trivial recursion detected:
      12  pcibios_allocate_bus_resources
WARNING: trivial recursion detected:
      28  atalk_sum_skb
WARNING: recursion detected:
       0  __l2cap_sock_close
       0  l2cap_sock_cleanup_listen
       0  l2cap_sock_close
WARNING: recursion detected:
       0  sco_sock_close
       0  sco_sock_cleanup_listen
WARNING: recursion detected:
       0  __rfcomm_sock_close
       0  rfcomm_sock_cleanup_listen
       0  rfcomm_sock_close
WARNING: trivial recursion detected:
      28  skb_copy_bits
WARNING: trivial recursion detected:
      36  skb_copy_and_csum_bits
WARNING: trivial recursion detected:
      32  skb_checksum
WARNING: trivial recursion detected:
      28  skb_copy_datagram_iovec
WARNING: trivial recursion detected:
      44  skb_copy_and_csum_datagram
WARNING: recursion detected:
      12  inetdev_destroy
      12  inet_del_ifa
WARNING: trivial recursion detected:
       0  ip_vs_sync_conn
WARNING: trivial recursion detected:
     196  dump_packet
WARNING: trivial recursion detected:
     240  dump_packet
WARNING: trivial recursion detected:
       0  irda_task_kick
WARNING: trivial recursion detected:
      16  htb_destroy_class
WARNING: trivial recursion detected:
       0  atm_tc_put
WARNING: trivial recursion detected:
      12  rpc_destroy_client
WARNING: trivial recursion detected:
      16  unix_release_sock
WARNING: trivial recursion detected:
      52  skb_to_sgvec
WARNING: trivial recursion detected:
      48  skb_icv_walk

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
