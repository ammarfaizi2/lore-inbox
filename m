Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUDLF67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 01:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUDLF67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 01:58:59 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:27405 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262606AbUDLF61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 01:58:27 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: List of oversized inlines
Date: Mon, 12 Apr 2004 08:58:15 +0300
User-Agent: KMail/1.5.4
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
References: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua> <200404111951.34734.vda@port.imtp.ilyichevsk.odessa.ua> <20040411133855.31022616.akpm@osdl.org>
In-Reply-To: <20040411133855.31022616.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3/ieA1FnGeFs4yT"
Message-Id: <200404120858.16002.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3/ieA1FnGeFs4yT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 11 April 2004 23:38, Andrew Morton wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> > Basically, you:
> >
> >  * untar linux tree into tree/,
> >  * make allyesconfig
>
> You should disable at least CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_PAGEALLOC
> and CONFIG_DEBUG_SPINLOCK_SLEEP.

I have added this info to the script.
Unfortunately, my night allyesconfig run was done
with those enabled.

Scripts are ready, patch attached below.
Matt, please include in your patchset.

Results of allyesconfig ran are as follows:

Size  Uses Wasted Name and definition
===== ==== ====== ================================================
 5515    2   5495 do_write_buffer	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0001.c
 5049    2   5029 do_write_buffer	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0001.c
 4493    2   4473 do_erase_oneblock	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c
 4245    2   4225 do_erase_oneblock	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c
 3178    3   6316 do_read_onechip	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c drivers/mtd/chips/cfi_cmdset_0001.c
 1282    2   1262 ser12_rx	drivers/net/hamradio/baycom_ser_hdx.c drivers/net/hamradio/baycom_ser_fdx.c
 1216    3   2392 line_info	drivers/char/synclinkmp.c drivers/char/synclink.c drivers/char/pcmcia/synclink_cs.c
 1043    2   1023 wv_mmc_init	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
 1038    2   1018 wv_mmc_init	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  990    2    970 wv_set_frequency	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  982    2    962 wv_set_frequency	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  870    3   1700 check_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  850    3   1660 check_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  794    3   1548 line_info	drivers/char/synclinkmp.c drivers/char/synclink.c drivers/char/pcmcia/synclink_cs.c
  770    3   1500 line_info	drivers/char/synclinkmp.c drivers/char/synclink.c drivers/char/pcmcia/synclink_cs.c
  731    2    711 wv_packet_write	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  650    2    630 ip_vs_control_add	include/net/ip_vs.h
  584    2    564 wv_packet_read	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  553    2    533 wv_packet_read	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  552    2    532 ser12_rx	drivers/net/hamradio/baycom_ser_hdx.c drivers/net/hamradio/baycom_ser_fdx.c
  539    2    519 ahc_queue_scb	drivers/scsi/aic7xxx/aic7xxx_inline.h
  516    2    496 ahd_queue_scb	drivers/scsi/aic7xxx/aic79xx_inline.h
  510   21   9800 sock_queue_rcv_skb	include/net/sock.h
  505    3    970 do_read_onechip	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c drivers/mtd/chips/cfi_cmdset_0001.c
  491    2    471 wv_init_info	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  423    3    806 stop_dac	sound/oss/sonicvibes.c sound/oss/esssolo1.c sound/oss/cmpci.c
  403    3    766 isdn_net_get_locked_lp	drivers/isdn/i4l/isdn_net.h
  402    2    382 ahc_intr	drivers/scsi/aic7xxx/aic7xxx_inline.h
  392    2    372 push_ctxt	fs/intermezzo/intermezzo_fs.h
  392    2    372 hdlc_empty_fifo	drivers/isdn/hisax/hisax_fcpcipnp.c drivers/isdn/hisax/avm_pci.c
  388    2    368 wv_init_info	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  366    3    692 do_read_onechip	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c drivers/mtd/chips/cfi_cmdset_0001.c
  363    3    686 check_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  362    2    342 snd_intel8x0_update	sound/pci/intel8x0m.c sound/pci/intel8x0.c
  360    3    680 prog_dmabuf_adc	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
  357    3    674 hdlcdrv_getbits	include/linux/hdlcdrv.h
  353    2    333 ipq_rcv_skb	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
  342    2    322 ahd_intr	drivers/scsi/aic7xxx/aic79xx_inline.h
  329    2    309 init_rx_bufs	drivers/net/lp486e.c drivers/net/82596.c
  327    2    307 init_stripe	drivers/md/raid6main.c drivers/md/raid5.c
  321    2    301 xdr_encode_sattr	fs/nfs/nfs3xdr.c fs/nfs/nfs2xdr.c
  321    2    301 tcp_prequeue	include/net/tcp.h
  320    4    900 _radeon_engine_idle	drivers/video/aty/radeonfb.h drivers/video/radeonfb.c
  313    2    293 vlan_put_tag	include/linux/if_vlan.h
  313    9   2344 hci_recv_frame	include/net/bluetooth/hci_core.h
  310    2    290 complete_command	drivers/block/cpqarray.c drivers/block/cciss.c
  305    4    855 ahd_unpause	drivers/scsi/aic7xxx/aic79xx_inline.h
  302    2    282 splice_branch	fs/sysv/itree.c fs/minix/itree_common.c
  299    4    837 fh_unlock	include/linux/nfsd/nfsfh.h
  295    4    825 fh_unlock	include/linux/nfsd/nfsfh.h
  291    2    271 pop_ctxt	fs/intermezzo/intermezzo_fs.h
  286    2    266 check_match	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c
  285    2    265 __release_stripe	drivers/md/raid6main.c drivers/md/raid5.c
  277    2    257 sock_queue_err_skb	include/net/sock.h
  277    2    257 __tcp_push_pending_frames	include/net/tcp.h
  271    2    251 init_stripe	drivers/md/raid6main.c drivers/md/raid5.c
  265    2    245 BLEND_OP	crypto/sha512.c crypto/sha256.c
  259    3    478 cls_set_class	include/net/pkt_sched.h
  257    2    237 wv_packet_write	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  256    2    236 sk_dst_check	include/net/sock.h
  254    2    234 xdr_encode_sattr	fs/nfs/nfs3xdr.c fs/nfs/nfs2xdr.c
  252    2    232 isdn_net_rm_from_bundle	drivers/isdn/i4l/isdn_net.h
  245   78  17325 skb_queue_purge	include/linux/skbuff.h
  234    6   1070 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  230    2    210 prog_dmabuf_dac2	sound/oss/es1371.c sound/oss/es1370.c
  230    3    420 prog_dmabuf_adc	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
  229    2    209 fh_lock	include/linux/nfsd/nfsfh.h
  226    3    412 add_to_done_queue	drivers/scsi/qla2xxx/qla_listops.h
  223    2    203 LOAD_OP	crypto/sha512.c crypto/sha256.c
  222    3    404 cleanup_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  221    3    402 cleanup_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  219    2    199 add_to_retry_queue	drivers/scsi/qla2xxx/qla_listops.h
  218    2    198 radeon_engine_flush	drivers/video/radeonfb.c drivers/video/aty/radeonfb.h
  218    2    198 prog_dmabuf_dac1	sound/oss/es1371.c sound/oss/es1370.c
  214    9   1552 skb_unlink	include/linux/skbuff.h
  214    3    388 inet_putpeer	include/net/inetpeer.h
  213    4    579 list_named_insert	include/linux/netfilter_ipv4/listhelp.h
  211    2    191 add_to_scsi_retry_queue	drivers/scsi/qla2xxx/qla_listops.h
  208    5    752 wait_for_ctrl_irq	drivers/pci/hotplug/pciehp.h drivers/pci/hotplug/cpqphp.h drivers/pci/hotplug/shpchp.h
  208    3    376 rxrpc_discard_my_signals	net/rxrpc/internal.h
  208    2    188 isdn_net_add_to_bundle	drivers/isdn/i4l/isdn_net.h
  208    2    188 afs_discard_my_signals	fs/afs/internal.h
  207    2    187 prog_dmabuf_dac2	sound/oss/es1371.c sound/oss/es1370.c
  207    3    374 prog_dmabuf_adc	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
  206    2    186 __ip_vs_wlc_schedule	net/ipv4/ipvs/ip_vs_lblcr.c net/ipv4/ipvs/ip_vs_lblc.c
  205    3    370 ntfs_map_page	fs/ntfs/ntfs.h
  204    2    184 prog_dmabuf_dac1	sound/oss/es1371.c sound/oss/es1370.c
  203  119  21594 skb_dequeue	include/linux/skbuff.h
  202    4    546 find_inlist_lock_noload	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c net/bridge/netfilter/ebtables.c
  201    2    181 hdlc_empty_fifo	drivers/isdn/hisax/hisax_fcpcipnp.c drivers/isdn/hisax/avm_pci.c
  201    5    724 _INPLL	drivers/video/aty/radeonfb.h drivers/video/radeonfb.c
  192   44   7396 skb_queue_head	include/linux/skbuff.h
  191  101  17100 skb_queue_tail	include/linux/skbuff.h
  189    5    676 wait_for_ctrl_irq	drivers/pci/hotplug/pciehp.h drivers/pci/hotplug/cpqphp.h drivers/pci/hotplug/shpchp.h
  188    5    672 skb_append	include/linux/skbuff.h
  188    3    336 hdlcdrv_putbits	include/linux/hdlcdrv.h
  184    3    328 orinoco_lock	drivers/net/wireless/orinoco.h
  183    2    163 vlan_hwaccel_rx	include/linux/if_vlan.h
  183    6    815 vlan_hwaccel_receive_skb	include/linux/if_vlan.h
  183    3    326 snd_gf1_select_voice	include/sound/gus.h
  183    3    326 ip6_dst_store	include/net/ip6_route.h
  182    2    162 wv_frequency_list	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  182    2    162 next_request	drivers/block/paride/pf.c drivers/block/paride/pcd.c
  180    3    320 stop_dac	sound/oss/sonicvibes.c sound/oss/esssolo1.c sound/oss/cmpci.c
  180    6    800 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  179    5    636 tcp_done	include/net/tcp.h
  174    3    308 stop_dac	sound/oss/sonicvibes.c sound/oss/esssolo1.c sound/oss/cmpci.c
  174    6    770 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  172    2    152 qla2x00_enable_intrs	drivers/scsi/qla2xxx/qla_inline.h
  172    2    152 qla2x00_disable_intrs	drivers/scsi/qla2xxx/qla_inline.h
  170    2    150 stop_dac2	sound/oss/es1371.c sound/oss/es1370.c
  170    2    150 stop_dac1	sound/oss/es1371.c sound/oss/es1370.c
  170    6    750 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  166    6    730 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  166    2    146 actcapi_nextsmsg	drivers/isdn/act2000/capi.h
  164    2    144 rdebi	drivers/media/dvb/ttpci/av7110_hw.h
  160    3    280 dealloc_dmabuf	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
  160    2    140 DQUOT_PREALLOC_SPACE	include/linux/quotaops.h
  160    6    700 DQUOT_ALLOC_SPACE	include/linux/quotaops.h
  159    3    278 switch_mm	include/asm/mmu_context.h
  158    4    414 _sv_wait	fs/xfs/linux/sv.h
  156    3    272 show_version	drivers/net/wan/pc300_drv.c drivers/atm/horizon.c drivers/atm/ambassador.c
  152    3    264 tcp_synq_drop	include/net/tcp.h
  152   14   1716 d_drop	include/linux/dcache.h
  151    2    131 tlb_gather_mmu	include/asm-generic/tlb.h
  151    3    262 dealloc_dmabuf	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
  151    6    655 DQUOT_FREE_SPACE	include/linux/quotaops.h
  150    8    910 sk_dst_reset	include/net/sock.h
  149    3    258 DoC_Command	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
  148    2    128 ah_hmac_digest	include/net/ah.h
  147    2    127 tcp_openreq_init	include/net/tcp.h
  146    4    378 tcf_tree_lock	include/net/pkt_sched.h
  146    2    126 ahd_outl	drivers/scsi/aic7xxx/aic79xx_inline.h
  145   77   9500 put_page	include/linux/mm.h
  145    3    250 ntfs_unmap_page	fs/ntfs/ntfs.h
  145    2    125 dir_put_page	fs/sysv/dir.c fs/minix/dir.c
  144    9    992 sch_tree_lock	include/net/pkt_sched.h
  142    2    122 llc_pdu_init_as_test_rsp	include/net/llc_pdu.h
  142    3    244 ahd_set_scbptr	drivers/scsi/aic7xxx/aic79xx_inline.h
  141    3    242 tcp_enter_cwr	include/net/tcp.h
  141    2    121 exit_namespace	include/linux/namespace.h
  141    6    605 clear_advance	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  141    2    121 __start_adc	sound/oss/i810_audio.c sound/oss/ali5455.c
  139    2    119 esp_hmac_digest	include/net/esp.h
  139    2    119 XFS_bwrite	fs/xfs/linux/xfs_buf.h
  136    4    348 netif_rx_schedule	include/linux/netdevice.h
  136    2    116 ahd_get_scbptr	drivers/scsi/aic7xxx/aic79xx_inline.h
  134    2    114 locks_verify_truncate	include/linux/fs.h
  134    2    114 ahd_inw_scbram	drivers/scsi/aic7xxx/aic79xx_inline.h
  134    2    114 ahd_inl	drivers/scsi/aic7xxx/aic79xx_inline.h
  133    3    226 tcp_writequeue_purge	include/net/tcp.h
  132    2    112 fib6_walker_unlink	include/net/ip6_fib.h
  132    7    672 dget_parent	include/linux/dcache.h
  132    4    336 ahd_set_modes	drivers/scsi/aic7xxx/aic79xx_inline.h
  132    3    224 ahd_restore_modes	drivers/scsi/aic7xxx/aic79xx_inline.h
  131   39   4218 netif_device_attach	include/linux/netdevice.h
  131    3    222 ahc_pause	drivers/scsi/aic7xxx/aic7xxx_inline.h
  131    2    111 ahc_outl	drivers/scsi/aic7xxx/aic7xxx_inline.h
  128    2    108 _ubh_find_next_zero_bit_	fs/ufs/util.h
  127   59   6206 dev_kfree_skb_any	include/linux/netdevice.h
  127    2    107 affs_getzeroblk	include/linux/amigaffs.h
  124    3    208 load_LDT	include/asm/desc.h
  123    3    206 sock_graft	include/net/sock.h
  123    4    309 ahd_save_modes	drivers/scsi/aic7xxx/aic79xx_inline.h
  123    4    309 __stop_dac	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
  122    2    102 parport_generic_irq	include/linux/parport.h
  121    2    101 task_sectors	include/linux/ide.h
  121   18   1717 sock_orphan	include/net/sock.h
  121    2    101 fee_wait	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  120    2    100 dump_skb	drivers/atm/horizon.c drivers/atm/ambassador.c
  119    2     99 ahc_inl	drivers/scsi/aic7xxx/aic7xxx_inline.h
  118    2     98 ___add_to_page_cache	include/linux/pagemap.h
  117    2     97 dump_skb	drivers/atm/horizon.c drivers/atm/ambassador.c
  116    4    288 tcf_tree_unlock	include/net/pkt_sched.h
  115    2     95 fee_wait	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  114    9    752 sch_tree_unlock	include/net/pkt_sched.h
  113    2     93 try_address	drivers/i2c/algos/i2c-algo-pcf.c drivers/i2c/algos/i2c-algo-bit.c
  113    6    465 get_task_mm	include/linux/sched.h
  112    2     92 ata_irq_on	include/linux/libata.h
  112    7    552 __netif_rx_schedule	include/linux/netdevice.h
  109    2     89 csr1212_rom_cache_malloc	drivers/ieee1394/csr1212.h
  104    2     84 cleanup_match	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c
  103   10    747 __skb_queue_purge	include/linux/skbuff.h
  102   23   1804 __nlmsg_put	include/linux/netlink.h
  101    3    162 vn_flagset	fs/xfs/linux/xfs_vnode.h
  101    4    243 list_named_insert	include/linux/netfilter_ipv4/listhelp.h
  101    3    162 cleanup_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  101    2     81 __ipq_reset	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
  100    2     80 dn_rt_finish_output	include/net/dn_route.h
  100    4    240 _radeon_engine_idle	drivers/video/aty/radeonfb.h drivers/video/radeonfb.c
   99    4    237 snd_pcm_stream_unlock_irq	include/sound/pcm.h
   99   13    948 parent_ino	include/linux/fs.h
   98  163  12636 unlock_kernel	include/linux/smp_lock.h
   97    4    231 sk_filter	include/net/sock.h
   97  141  10780 netif_wake_queue	include/linux/netdevice.h
   97    5    308 hci_dev_put	include/net/bluetooth/hci_core.h
   96    9    608 list_inlist	include/linux/netfilter_ipv4/listhelp.h
   95    2     75 mmc_encr	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   95    3    150 addQ	drivers/block/cciss.c drivers/block/cpqarray.c
   94    2     74 fat_get_entry	include/linux/msdos_fs.h
   92    9    576 tcf_destroy	include/net/pkt_cls.h
   92    2     72 mmc_in	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   92    2     72 WaitForBusy	drivers/isdn/hisax/hfc_2bs0.c drivers/isdn/hisax/hfc_2bds0.c
   91    2     71 tlb_finish_mmu	include/asm-generic/tlb.h
   91    2     71 llc_pdu_init_as_xid_rsp	include/net/llc_pdu.h
   91    2     71 llc_pdu_init_as_xid_cmd	include/net/llc_pdu.h
   91    2     71 hci_conn_hash_lookup_ba	include/net/bluetooth/hci_core.h
   90   18   1190 sk_del_node_init	include/net/sock.h
   90    2     70 mmc_encr	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   90    2     70 hci_dev_hold	include/net/bluetooth/hci_core.h
   90    2     70 __ipq_enqueue_entry	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   89    2     69 vlan_get_tag	include/linux/if_vlan.h
   89    2     69 WaitForBusy	drivers/isdn/hisax/hfc_2bs0.c drivers/isdn/hisax/hfc_2bds0.c
   88    3    136 nfs_list_remove_request	include/linux/nfs_page.h
   88    2     68 mmc_in	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   88    4    204 __stop_dac	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   87    2     67 scm_recv	include/net/scm.h
   87    6    335 clear_advance	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
   87    3    134 cfi_write	include/linux/mtd/cfi.h
   87    4    201 ahd_lock	drivers/scsi/aic7xxx/aic79xx_osm.h
   87    4    201 ahc_unpause	drivers/scsi/aic7xxx/aic7xxx_inline.h
   87    4    201 ahc_lock	drivers/scsi/aic7xxx/aic7xxx_osm.h
   86    3    132 tcp_prequeue_init	include/net/tcp.h
   86    4    198 snd_i2c_lock	include/sound/i2c.h
   86    3    132 sk_dst_get	include/net/sock.h
   86    2     66 scm_send	include/net/scm.h
   86    3    132 save_init_fpu	include/asm/i387.h
   86    9    528 list_prepend	include/linux/netfilter_ipv4/listhelp.h
   86   12    726 in_dev_get	include/linux/inetdevice.h
   86    7    396 in6_dev_get	include/net/addrconf.h
   86    5    264 ahd_list_lock	drivers/scsi/aic7xxx/aic79xx_osm.h
   86    6    330 ahc_list_lock	drivers/scsi/aic7xxx/aic7xxx_osm.h
   85    4    195 snd_pcm_stream_lock_irq	include/sound/pcm.h
   85    9    520 list_prepend	include/linux/netfilter_ipv4/listhelp.h
   85    5    260 list_append	include/linux/netfilter_ipv4/listhelp.h
   85    2     65 insert_hash	drivers/md/raid6main.c drivers/md/raid5.c
   85    6    325 diva_os_enter_spin_lock	drivers/isdn/hardware/eicon/platform.h
   84   59   3712 seq_puts	include/linux/seq_file.h
   84    5    256 list_append	include/linux/netfilter_ipv4/listhelp.h
   83    2     63 tcp_listen_lock	include/net/tcp.h
   83    2     63 tcp_fast_path_check	include/net/tcp.h
   83    7    378 netif_schedule	include/linux/netdevice.h
   83    4    189 __stop_adc	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   82    9    496 list_inlist	include/linux/netfilter_ipv4/listhelp.h
   81   18   1037 claim_dma_lock	include/asm/dma.h
   81    4    183 baycom_int_freq	drivers/net/hamradio/baycom_ser_hdx.c drivers/net/hamradio/baycom_ser_fdx.c drivers/net/hamradio/baycom_par.c drivers/net/hamradio/baycom_epp.c
   81    2     61 __add_to_done_queue	drivers/scsi/qla2xxx/qla_listops.h
   80    2     60 remove_rx_bufs	drivers/net/lp486e.c drivers/net/82596.c
   80    3    120 orinoco_unlock	drivers/net/wireless/orinoco.h
   80   11    600 kmem_zone_zalloc	fs/xfs/linux/kmem.h
   80    5    240 ahd_list_unlock	drivers/scsi/aic7xxx/aic79xx_osm.h
   80    6    300 ahc_list_unlock	drivers/scsi/aic7xxx/aic7xxx_osm.h
   79    7    354 write_sequnlock	include/linux/seqlock.h
   79    3    118 hci_conn_put	include/net/bluetooth/hci_core.h
   79    4    177 find_inlist_lock_noload	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c net/bridge/netfilter/ebtables.c
   78    5    232 xfs_bawrite	fs/xfs/linux/xfs_buf.h
   78    2     58 xdr_decode_fhandle	fs/nfs/nfs3xdr.c fs/nfs/nfs2xdr.c
   78    2     58 ecp_sync	drivers/scsi/ppa.c drivers/scsi/imm.c
   78    4    174 ahd_unlock	drivers/scsi/aic7xxx/aic79xx_osm.h
   78    4    174 ahc_unlock	drivers/scsi/aic7xxx/aic7xxx_osm.h
   78    2     58 __start_dac	sound/oss/i810_audio.c sound/oss/ali5455.c
   77    2     57 cs46xx_dsp_scb_set_volume	sound/pci/cs46xx/dsp_spos.h
   76   18    952 release_dma_lock	include/asm/dma.h
   76    6    280 diva_os_leave_spin_lock	drivers/isdn/hardware/eicon/platform.h
   76    4    168 cfi_read_query	include/linux/mtd/cfi.h
   76    5    224 cfi_read	include/linux/mtd/cfi.h
   75    9    440 sock_i_uid	include/net/sock.h
   75   10    495 sock_i_ino	include/net/sock.h
   75    2     55 remove_rx_bufs	drivers/net/lp486e.c drivers/net/82596.c
   75   13    660 blkdev_dequeue_request	include/linux/blkdev.h
   75    2     55 ahd_pause	drivers/scsi/aic7xxx/aic79xx_inline.h
   74    2     54 tcp_acceptq_queue	include/net/tcp.h
   74    2     54 nfs_unlock_request	include/linux/nfs_page.h
   74    2     54 get_status	drivers/net/wan/wanxl.c drivers/net/3c505.c
   74    2     54 dn_sk_ports_copy	include/net/dn.h
   74    4    162 ata_wait_idle	include/linux/libata.h
   74    2     54 __ipq_flush	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   73   15    742 task_unlock	include/linux/sched.h
   73    4    159 rpc_call	include/linux/sunrpc/clnt.h
   73   21   1060 mutex_spinunlock	fs/xfs/linux/spin.h
   73    2     53 ecp_sync	drivers/scsi/ppa.c drivers/scsi/imm.c
   73   83   4346 dev_kfree_skb_irq	include/linux/netdevice.h
   72    4    156 tcp_initialize_rcv_mss	include/net/tcp.h
   72    7    312 netif_rx_complete	include/linux/netdevice.h
   72    2     52 ipip_ecn_decapsulate	net/ipv4/xfrm4_input.c net/ipv4/ipip.c
   72    2     52 decode_fh	fs/nfsd/nfsxdr.c fs/nfsd/nfs3xdr.c
   72    4    156 __stop_dac	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   72    4    156 __stop_adc	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   71    5    204 snd_ice1712_restore_gpio_status	sound/pci/ice1712/ice1712.h
   71    2     51 offset_ptr	sound/pci/trident/trident_memory.c sound/pci/emu10k1/memory.c
   71    3    102 context_destroy	security/selinux/ss/context.h
   71    2     51 BLEND_OP	crypto/sha512.c crypto/sha256.c
   70    2     50 ipip_ecn_decapsulate	net/ipv4/xfrm4_input.c net/ipv4/ipip.c
   70    2     50 ipip6_ecn_decapsulate	net/ipv6/xfrm6_input.c net/ipv6/sit.c
   69    2     49 encode_fh	fs/nfsd/nfsxdr.c fs/nfsd/nfs3xdr.c
   69  461  22540 copy_from_user	include/asm/uaccess.h
   69    2     49 __start_adc	sound/oss/i810_audio.c sound/oss/ali5455.c
   68   10    432 skb_cow	include/linux/skbuff.h
   68    2     48 line_set	drivers/i2c/busses/i2c-parport.c drivers/i2c/busses/i2c-parport-light.c
   68   11    480 kmem_zalloc	fs/xfs/linux/kmem.h
   68    3     96 inet_reset_saddr	include/net/ip.h
   68    2     48 fh_copy	include/linux/nfsd/nfsfh.h
   68  824  39504 _raw_spin_lock	include/asm/spinlock.h
   68    4    144 DQUOT_ALLOC_INODE	include/linux/quotaops.h
   67    5    188 snd_ice1712_restore_gpio_status	sound/pci/ice1712/ice1712.h
   67    4    141 llc_pdu_header_init	include/net/llc_pdu.h
   67    3     94 __netif_rx_complete	include/linux/netdevice.h
   66   35   1564 sema_init	include/asm/semaphore.h
   66   30   1334 init_MUTEX_LOCKED	include/asm/semaphore.h
   66  191   8740 init_MUTEX	include/asm/semaphore.h
   66    4    138 get_int	include/linux/sunrpc/cache.h
   66    2     46 ahd_inb_scbram	drivers/scsi/aic7xxx/aic79xx_inline.h
   65    7    270 tulip_restart_rxtx	drivers/net/tulip/tulip.h
   65    4    135 set_le_ih_k_offset	include/linux/reiserfs_fs.h
   65    2     45 next_unix_socket	include/net/af_unix.h
   65    6    225 le_ih_k_type	include/linux/reiserfs_fs.h
   65    2     45 __start_dac	sound/oss/i810_audio.c sound/oss/ali5455.c
   65    2     45 __del_from_retry_queue	drivers/scsi/qla2xxx/qla_listops.h
   65    2     45 RGB24_PUTPIXEL	drivers/usb/media/usbvideo.h
   65    4    135 DQUOT_TRANSFER	include/linux/quotaops.h
   64    2     44 snd_mask_refine	include/sound/pcm_params.h
   64    3     88 cpu_key_k_type	include/linux/reiserfs_fs.h
   64    2     44 WaitNoBusy	drivers/isdn/hisax/hfc_2bs0.c drivers/isdn/hisax/hfc_2bds0.c
   63    2     43 xfrm_sk_free_policy	include/net/xfrm.h
   63    2     43 tcp_select_initial_window	include/net/tcp.h
   63    5    172 jbd_lock_bh_state	include/linux/jbd.h
   63    2     43 bit_spin_lock	include/linux/spinlock.h
   63    2     43 __sk_dst_set	include/net/sock.h
   63    3     86 __sk_dst_reset	include/net/sock.h
   63    2     43 __ipq_find_dequeue_entry	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   62    2     42 snd_vx_outb	include/sound/vx_core.h
   62    6    210 snd_ice1712_save_gpio_status	sound/pci/ice1712/ice1712.h
   62    3     84 skb_unshare	include/linux/skbuff.h
   62    4    126 is_overloaded	net/ipv4/ipvs/ip_vs_sh.c net/ipv4/ipvs/ip_vs_lblcr.c net/ipv4/ipvs/ip_vs_lblc.c net/ipv4/ipvs/ip_vs_dh.c
   62    4    126 cpufreq_verify_within_limits	include/linux/cpufreq.h
   62    3     84 add_entry_to_counter	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
   62    2     42 WaitNoBusy	drivers/isdn/hisax/hfc_2bs0.c drivers/isdn/hisax/hfc_2bds0.c
   61   10    369 sock_recv_timestamp	include/net/sock.h
   61    2     41 elf_core_copy_regs	include/linux/elfcore.h
   61    2     41 decode_fh	fs/nfsd/nfsxdr.c fs/nfsd/nfs3xdr.c
   60   28   1080 writereg	drivers/isdn/hisax/teles3.c drivers/isdn/hisax/sedlbauer.c drivers/isdn/hisax/saphir.c drivers/isdn/hisax/s0box.c drivers/isdn/hisax/niccy.c drivers/isdn/hisax/mic.c drivers/isdn/hisax/ix1_micro.c drivers/isdn/hisax/elsa.c drivers/isdn/hisax/diva.c drivers/isdn/hisax/bkm_a8.c drivers/isdn/hisax/bkm_a4t.c drivers/isdn/hisax/avm_a1.c drivers/isdn/hisax/asuscom.c drivers/isdn/hisax/teleint.c drivers/isdn/hisax/gazel.c
   60    2     40 decode_filename	fs/nfsd/nfsxdr.c fs/nfsd/nfs3xdr.c
   60    3     80 add_counter_to_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
   59    4    117 svc_take_page	include/linux/sunrpc/svc.h
   59    9    312 pskb_trim	include/linux/skbuff.h
   59  165   6396 lock_kernel	include/linux/smp_lock.h
   59    2     39 dev_get_idx	net/core/dev.c net/atm/resources.c
   59    2     39 crypto_cipher_encrypt_iv	include/linux/crypto.h
   59    2     39 crypto_cipher_decrypt_iv	include/linux/crypto.h
   59    2     39 ahc_inw	drivers/scsi/aic7xxx/aic7xxx_inline.h
   59    4    117 add_two_Xsig	arch/i386/math-emu/poly.h
   58    2     38 tcp_may_send_now	include/net/tcp.h
   58    6    190 snd_ice1712_save_gpio_status	sound/pci/ice1712/ice1712.h
   58    5    152 llc_pdu_decode_sa	include/net/llc_pdu.h
   58   20    722 __skb_dequeue	include/linux/skbuff.h
   57    2     37 tcp_sync_left_out	include/net/tcp.h
   57    4    111 tcp_set_state	include/net/tcp.h
   57   75   2738 skb_trim	include/linux/skbuff.h
   57    5    148 jbd_unlock_bh_state	include/linux/jbd.h
   56   96   3420 skb_queue_head_init	include/linux/skbuff.h
   56   28    972 readreg	drivers/isdn/hisax/teles3.c drivers/isdn/hisax/sedlbauer.c drivers/isdn/hisax/saphir.c drivers/isdn/hisax/s0box.c drivers/isdn/hisax/niccy.c drivers/isdn/hisax/mic.c drivers/isdn/hisax/ix1_micro.c drivers/isdn/hisax/elsa.c drivers/isdn/hisax/diva.c drivers/isdn/hisax/bkm_a8.c drivers/isdn/hisax/bkm_a4t.c drivers/isdn/hisax/avm_a1.c drivers/isdn/hisax/asuscom.c drivers/isdn/hisax/teleint.c drivers/isdn/hisax/gazel.c
   56    2     36 percpu_counter_init	include/linux/percpu_counter.h
   56    3     72 load_esp0	include/asm/processor.h
   56    2     36 ipip6_ecn_decapsulate	net/ipv6/xfrm6_input.c net/ipv6/sit.c
   56   22    756 init_rwsem	include/asm/rwsem.h
   56   41   1440 init_completion	include/linux/completion.h
   56    3     72 fs16_add	fs/ufs/swab.h fs/sysv/sysv.h
   56  468  16812 copy_to_user	include/asm/uaccess.h
   56  461  16560 copy_from_user	include/asm/uaccess.h
   56    2     36 __del_from_pending_queue	drivers/scsi/qla2xxx/qla_listops.h
   56    2     36 __INPLL	drivers/video/aty/radeonfb.h
   56    3     72 DoC_Command	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
   55    2     35 wl_spy_gather	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   55    3     70 snd_vx_inb	include/sound/vx_core.h
   55    4    105 llc_pdu_decode_da	include/net/llc_pdu.h
   55   11    350 le_key_k_type	include/linux/reiserfs_fs.h
   54    2     34 vx_reset_dsp	include/sound/vx_core.h
   54    9    272 on_each_cpu	include/linux/smp.h
   54    2     34 mmc_out	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   54    2     34 csum_and_copy_from_user	include/net/checksum.h
   54    2     34 bit_spin_unlock	include/linux/spinlock.h
   54    3     68 DoC_WaitReady	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
   53    4     99 xdr_decode_hyper	include/linux/sunrpc/xdr.h
   53    2     33 tcp_v4_setup_caps	include/net/tcp.h
   53   18    561 sk_add_node	include/net/sock.h
   53   20    627 list_move	include/linux/list.h
   53    2     33 hermes_present	drivers/net/wireless/hermes.h
   53    2     33 context_cpy	security/selinux/ss/context.h
   53    6    165 cache_put	include/linux/sunrpc/cache.h
   53    2     33 LOAD_OP	crypto/sha512.c crypto/sha256.c
   52    2     32 radeon_engine_flush	drivers/video/radeonfb.c drivers/video/aty/radeonfb.h
   52    2     32 mmc_out	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   52    7    192 __d_drop	include/linux/dcache.h
   51    2     31 wr_mem	drivers/atm/horizon.c drivers/atm/ambassador.c
   51   22    651 tty_insert_flip_char	include/linux/tty_flip.h
   51   20    589 skb_share_check	include/linux/skbuff.h
   51    3     62 parport_yield_blocking	include/linux/parport.h
   51    3     62 fs16_add	fs/ufs/swab.h fs/sysv/sysv.h
   51    4     93 __stop_dac	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   51   16    465 __skb_unlink	include/linux/skbuff.h
   51    8    217 __skb_dequeue_tail	include/linux/skbuff.h
   50   12    330 ip_fast_csum	include/asm/checksum.h
   50    4     90 get_expiry	include/linux/sunrpc/cache.h
   50    2     30 dev_is_ethdev	drivers/net/wan/lapbether.c drivers/net/hamradio/bpqether.c
   50 1118  33510 _raw_spin_unlock	include/asm/spinlock.h
   50    7    180 DQUOT_INIT	include/linux/quotaops.h
   49    2     29 tcp_current_mss	include/net/tcp.h
   49  313   9048 skb_put	include/linux/skbuff.h
   49    6    145 read_reg	drivers/net/irda/stir4200.c drivers/block/paride/pt.c drivers/block/paride/pg.c drivers/block/paride/pf.c drivers/block/paride/pd.c drivers/block/paride/pcd.c
   49    4     87 invalidate_remote_inode	include/linux/fs.h
   49    4     87 hlist_del_init	include/linux/list.h
   49    2     29 hci_proto_disconn_ind	include/net/bluetooth/hci_core.h
   49    2     29 crypto_yield	crypto/internal.h
   49    5    116 __pskb_trim	include/linux/skbuff.h
   49    2     29 D_L1L2	drivers/isdn/hisax/st5481_d.c drivers/isdn/hisax/hisax_isac.c
   48    2     28 xdr_decode_fhandle	fs/nfs/nfs3xdr.c fs/nfs/nfs2xdr.c
   48    3     56 print_name	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
   48   21    560 map_bh	include/linux/buffer_head.h
   48    2     28 irdebi	drivers/media/dvb/ttpci/av7110_hw.h
   48    2     28 hci_conn_hash_lookup_handle	include/net/bluetooth/hci_core.h
   48    4     84 fib_res_put	include/net/ip_fib.h
   48    3     56 dn_fib_res_put	include/net/dn_fib.h
   48    2     28 add_page_to_inactive_list	include/linux/mm_inline.h
   48    2     28 add_page_to_active_list	include/linux/mm_inline.h
   48    4     84 __stop_adc	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   47   22    567 wait_ms	include/linux/usb.h include/linux/gameport.h drivers/video/aty/radeonfb.h drivers/media/video/meye.c
   47    2     27 snd_interval_setinteger	include/sound/pcm_params.h
   47    4     81 snd_i2c_unlock	include/sound/i2c.h
   47    3     54 scsi_populate_tag_msg	include/scsi/scsi_tcq.h
   47    2     27 rd_mem	drivers/atm/horizon.c drivers/atm/ambassador.c
   47   45   1188 iget	include/linux/fs.h
   47    2     27 hisax_findcard	drivers/isdn/hisax/config.c drivers/isdn/hisax/callc.c
   47    2     27 frag_kfree_skb	net/ipv6/reassembly.c net/ipv4/ip_fragment.c
   47    2     27 dn_dn2eth	include/net/dn.h
   47    2     27 check_sticky	fs/namei.c fs/intermezzo/vfs.c
   47    3     54 cfi_udelay	include/linux/mtd/cfi.h
   47    3     54 bt_skb_send_alloc	include/net/bluetooth/bluetooth.h
   47    2     27 addrconf_addr_solict_mult	include/net/addrconf.h
   47   11    270 __skb_queue_head	include/linux/skbuff.h
   47    2     27 __ipq_dequeue_entry	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   46    5    104 xfs_buf_undelay	fs/xfs/linux/xfs_buf.h
   46   22    546 wait_ms	include/linux/usb.h include/linux/gameport.h drivers/video/aty/radeonfb.h drivers/media/video/meye.c
   46    2     26 sk_filter_release	include/net/sock.h
   46    2     26 sk_add_bind_node	include/net/sock.h
   46    7    156 set_cpu_key_k_offset	include/linux/reiserfs_fs.h
   46   41   1040 netif_device_detach	include/linux/netdevice.h
   46    2     26 irttp_listen	include/net/irda/irttp.h
   46  259   6708 init_waitqueue_head	include/linux/wait.h
   46  345   8944 init_timer	include/linux/timer.h
   46    7    156 dst_free	include/net/dst.h
   46    2     26 dn_dev_islocal	include/net/dn_dev.h
   46    4     78 __stop_adc	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   46    5    104 __skb_trim	include/linux/skbuff.h
   46   26    650 __skb_queue_tail	include/linux/skbuff.h
   46    2     26 __skb_append	include/linux/skbuff.h
   46    2     26 __sk_add_node	include/net/sock.h
   46    2     26 B_L1L2	drivers/isdn/hisax/st5481_b.c drivers/isdn/hisax/hisax_fcpcipnp.c
   45    7    150 rb_link_node	include/linux/rbtree.h
   45    5    100 qla2x00_debounce_register	drivers/scsi/qla2xxx/qla_inline.h
   45    5    100 nfs_revalidate_inode	include/linux/nfs_fs.h
   45   17    400 list_splice_init	include/linux/list.h
   45    8    175 ld2	sound/oss/trident.h sound/oss/sonicvibes.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c include/sound/pcm_params.h drivers/usb/class/audio.c
   45    2     25 jbd_trylock_bh_state	include/linux/jbd.h
   45    4     75 ipv6_addr_set	include/net/ipv6.h
   45    2     25 ipv6_addr_all_routers	include/net/addrconf.h
   45    2     25 ipv6_addr_all_nodes	include/net/addrconf.h
   45    2     25 init_sigpending	include/linux/signal.h
   45    4     75 ide_init_hwif_ports	include/asm/ide.h
   45    2     25 hlist_del	include/linux/list.h
   45    2     25 bitset_set	sound/core/oss/pcm_plugin.h
   45    4     75 __sk_dst_check	include/net/sock.h
   45    3     50 DoC_WaitReady	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
   44   16    360 usb_serial_debug_data	drivers/usb/serial/usb-serial.h
   44   31    720 skb_set_owner_w	include/net/sock.h
   44    2     24 skb_fill_page_desc	include/linux/skbuff.h
   44    3     48 rxrpc_put_message	include/rxrpc/message.h
   44    2     24 r128_update_ring_snapshot	drivers/char/drm/r128_drv.h
   44   31    720 netif_carrier_on	include/linux/netdevice.h
   44    3     48 jiffies_to_timeval	include/linux/time.h
   44    2     24 ahc_get_scb	drivers/scsi/aic7xxx/aic7xxx_inline.h
   44    2     24 __set_tss_desc	include/asm/desc.h
   43    7    138 write_seqlock	include/linux/seqlock.h
   43    2     23 locks_verify_locked	include/linux/fs.h
   43    2     23 line_set	drivers/i2c/busses/i2c-parport.c drivers/i2c/busses/i2c-parport-light.c
   43   81   1840 down_write	include/linux/rwsem.h
   43    2     23 crypto_cipher_get_iv	include/linux/crypto.h
   42    3     44 snd_power_lock	include/sound/core.h
   42    5     88 smb_lock_server	include/linux/smb_fs_sb.h
   42    2     22 raid6_after_mmx	drivers/md/raid6x86.h
   42   15    308 lock_super	include/linux/fs.h
   42   17    352 lock_buffer	include/linux/buffer_head.h
   42   15    308 list_move_tail	include/linux/list.h
   42    3     44 crypto_comp_decompress	include/linux/crypto.h
   42    3     44 crypto_comp_compress	include/linux/crypto.h
   42    4     66 clear_highpage	include/linux/highmem.h
   42    2     22 chan2dev	drivers/isdn/pcbit/layer2.h
   42   12    242 bt_skb_alloc	include/net/bluetooth/bluetooth.h
   42    2     22 affs_lock_link	include/linux/amigaffs.h
   42    4     66 affs_lock_dir	include/linux/amigaffs.h
   42    8    154 affs_bread	include/linux/amigaffs.h
   42    2     22 __add_wait_queue	include/linux/wait.h
   41   18    357 snd_mask_min	include/sound/pcm_params.h
   41    4     63 secpath_reset	include/net/xfrm.h
   41  111   2310 list_del_init	include/linux/list.h
   41  289   6048 list_del	include/linux/list.h
   41   10    189 hlist_add_head	include/linux/list.h
   41    2     21 first_unix_socket	include/net/af_unix.h
   41   68   1407 down_interruptible	include/asm/semaphore.h
   41    2     21 dirty_sb	fs/sysv/sysv.h
   41    3     42 crypto_cipher_set_iv	include/linux/crypto.h
   41    5     84 ax25_cb_put	include/net/ax25.h
   41    2     21 aac_list_del	drivers/scsi/aacraid/aacraid.h
   41  107   2226 _raw_write_lock	include/asm/spinlock.h
   41    2     21 __remove_wait_queue	include/linux/wait.h
   41    2     21 __add_wait_queue_tail	include/linux/wait.h
   41    4     63 IP_ECN_set_ce	include/net/inet_ecn.h
   41    3     42 DoC_WaitReady	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
   40    4     60 wait_for_idle	drivers/video/aty/atyfb.h drivers/video/riva/fbdev.c
   40    2     20 tcp_listen_unlock	include/net/tcp.h
   40    6    100 snd_seq_oss_fill_addr	sound/core/seq/oss/seq_oss_device.h
   40    2     20 snd_ice1712_gpio_write_bits	sound/pci/ice1712/ice1712.h
   40    2     20 ser12_set_divisor	drivers/net/hamradio/baycom_ser_hdx.c drivers/net/hamradio/baycom_ser_fdx.c
   40    4     60 ntfs_malloc_nofs	fs/ntfs/malloc.h
   40    2     20 ip_vs_check_diff	include/net/ip_vs.h
   40   10    180 ip_select_ident	include/net/ip.h
   40   43    840 cond_resched	include/linux/sched.h
   40    4     60 ahc_is_paused	drivers/scsi/aic7xxx/aic7xxx_inline.h
   40    3     40 ahc_flush_device_writes	drivers/scsi/aic7xxx/aic7xxx_osm.h
           ======
           477320 Total bytes wasted
--
vda


--Boundary-00=_3/ieA1FnGeFs4yT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="inline_hunter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="inline_hunter.patch"

diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/00.driver linux-2.6.5-tiny/scripts/inline_hunter/00.driver
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/00.driver	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/00.driver	Mon Apr 12 08:52:21 2004
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+. ./conf
+
+function doit() {
+    echo "#" "$@"
+    "./$@"
+}
+	
+echo "*** This will take lots of time - kernel compile x3 ***"
+echo
+echo "Please configure kernel in $prefix with MEASURE_INLINES and, optionally,"
+echo "allyesconfig. Please disable CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_PAGEALLOC"
+echo "and CONFIG_DEBUG_SPINLOCK_SLEEP"
+echo
+echo "Make sure you did NOT ran make in the $prefix!"
+echo
+echo -n "Press <Enter> to start or Ctrl-C to exit: "; read junk
+
+{
+doit 10.build_and_log
+doit 15.find_inlines
+doit 20.add_measuring_functions
+doit 30.build_and_find_errors
+doit 40.comment_errors_out
+doit 50.build
+doit 60.calculate_inline_sizes
+doit 70.sort_by_size
+doit 80.match
+} 2>&1 # | tee driver.log
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/10.build_and_log linux-2.6.5-tiny/scripts/inline_hunter/10.build_and_log
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/10.build_and_log	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/10.build_and_log	Sun Apr 11 23:32:42 2004
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+. ./conf
+
+(
+cd $prefix
+$make 2>&1
+) \
+| grep -E '.c:[0-9]+: warning: ' \
+| grep -F ' is deprecated (declared at ' \
+| sed 's/:[0-9]*: warning: `/ /' \
+| sed "s/' is deprecated (declared at / /" \
+| sed 's/:[0-9]*)$//' \
+>make_stage1_temp.log
+# We got here:
+#
+#init/main.c strlen include/asm/string.h
+#init/main.c strncmp include/asm/string.h
+#init/main.c strchr include/asm/string.h
+#init/main.c strchr include/asm/string.h
+#init/main.c unlock_kernel include/linux/smp_lock.h
+#init/main.c lock_kernel include/linux/smp_lock.h
+#init/main.c setup_per_cpu_areas init/main.c
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/15.find_inlines linux-2.6.5-tiny/scripts/inline_hunter/15.find_inlines
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/15.find_inlines	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/15.find_inlines	Mon Apr 12 08:00:26 2004
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+. ./conf
+
+cat make_stage1_temp.log \
+| sort | uniq \
+>make_stage1.log
+# This is used in next stage
+#
+#arch/i386/kernel/acpi/boot.c acpi_blacklisted include/linux/acpi.h
+#arch/i386/kernel/acpi/boot.c acpi_irq_balance_set include/asm/acpi.h
+#arch/i386/kernel/acpi/boot.c acpi_madt_oem_check include/asm-i386/mach-default/mach_mpparse.h
+#arch/i386/kernel/acpi/boot.c acpi_parse_madt_ioapic_entries arch/i386/kernel/acpi/boot.c
+#arch/i386/kernel/acpi/boot.c clustered_apic_check include/asm-i386/mach-default/mach_apic.h
+#arch/i386/kernel/acpi/boot.c disable_acpi include/asm/acpi.h
+#arch/i386/kernel/acpi/boot.c fix_to_virt include/asm/fixmap.h
+#arch/i386/kernel/acpi/boot.c strncmp include/asm/string.h
+
+cat make_stage1.log \
+| cut -d' ' -f2-3 \
+| sort | uniq \
+>inline_defined_in.log
+# FYI only
+#
+#BDEV_I fs/block_dev.c
+#BLEND_OP crypto/sha256.c
+#BLEND_OP crypto/sha512.c
+#CA drivers/net/82596.c
+#CA drivers/net/lp486e.c
+#CIFS_I fs/cifs/cifsglob.h
+#CIFS_SB fs/cifs/cifsglob.h
+
+cat make_stage1.log \
+| cut -d' ' -f2-99 \
+| sort | uniq -c | sort -r \
+| sed $'s/\x9/ /g' \
+| sed 's/^ +//' \
+>inline_count.log
+# Note that there can be different inlines with the same name
+#
+#322 __memset_generic include/asm/string.h
+#322 __constant_c_memset include/asm/string.h
+#322 __constant_c_and_count_memset include/asm/string.h
+#266 kmalloc include/linux/slab.h
+#262 __memcpy include/asm/string.h
+#249 __constant_memcpy include/asm/string.h
+#203 get_current include/asm/current.h
+#150 current_thread_info include/asm/thread_info.h
+#120 variable_test_bit include/asm/bitops.h
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/20.add_measuring_functions linux-2.6.5-tiny/scripts/inline_hunter/20.add_measuring_functions
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/20.add_measuring_functions	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/20.add_measuring_functions	Sun Apr 11 23:37:16 2004
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+. ./conf
+
+function add_test() {
+    echo "void inline_${1}_0(void) { ${1}(); }"
+    echo "void inline_${1}_1(void) { ${1}(0); }"
+    echo "void inline_${1}_2(void) { ${1}(0,0); }"
+    echo "void inline_${1}_3(void) { ${1}(0,0,0); }"
+    echo "void inline_${1}_4(void) { ${1}(0,0,0,0); }"
+    echo "void inline_${1}_5(void) { ${1}(0,0,0,0,0); }"
+    echo "void inline_${1}_6(void) { ${1}(0,0,0,0,0,0); }"
+}
+
+{
+cat make_stage1.log
+echo
+} | {
+old_file=''
+while read file func include junk; do
+    if test "$old_file" != "$file"; then
+	if test "$old_file"; then
+	    echo "void inline_end(void) {}" >>"$prefix$old_file"
+	fi	
+	echo -n "$file "
+	old_file="$file"
+	if test "$file"; then
+	    echo >>"$prefix$file"
+	fi
+    fi
+    if test "$file"; then
+	add_test "$func" >>"$prefix$file"
+    fi
+done
+}
+echo
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/30.build_and_find_errors linux-2.6.5-tiny/scripts/inline_hunter/30.build_and_find_errors
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/30.build_and_find_errors	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/30.build_and_find_errors	Sun Apr 11 22:55:30 2004
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+. ./conf
+
+(
+cd tree
+$make 2>&1
+) \
+| grep -E '.c:[0-9]+: error: too [a-z]* arguments to function `' \
+| sed 's/: error: .*$//' \
+| sed 's/:/ /g' \
+>errors_at.log
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/40.comment_errors_out linux-2.6.5-tiny/scripts/inline_hunter/40.comment_errors_out
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/40.comment_errors_out	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/40.comment_errors_out	Sun Apr 11 23:18:28 2004
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+. ./conf
+
+tmp=/tmp/$$.c
+
+function remove_lines() {
+    local file="$1"
+    shift
+    local cnt=1
+    local line
+
+    # TODO: read -r strips leading spaces. fix this
+    cat "$file" \
+    | while read -r line; do
+	if test "$cnt" = "$1"; then
+	    printf "%s\n" "//$line"
+	    shift
+	    while test "$1" && test "$cnt" -ge "$1"; do
+		shift
+	    done
+	else
+	    printf "%s\n" "$line"
+	fi
+	cnt=$((cnt+1))
+    done >$tmp
+    mv $tmp "$file"
+}
+
+{
+cat errors_at.log
+echo
+} | {
+old_file=''
+lines=''
+while read file line junk; do
+    if test "$old_file" != "$file"; then
+	if test "$old_file"; then
+	    echo -n "$old_file "
+	    remove_lines "$prefix$old_file" $lines
+	fi
+	old_file="$file"
+	lines=''
+    fi
+    lines="$lines$line "
+done
+}
+echo
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/50.build linux-2.6.5-tiny/scripts/inline_hunter/50.build
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/50.build	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/50.build	Sun Apr 11 23:18:38 2004
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+. ./conf
+
+(
+cd tree
+$make
+)
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/60.calculate_inline_sizes linux-2.6.5-tiny/scripts/inline_hunter/60.calculate_inline_sizes
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/60.calculate_inline_sizes	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/60.calculate_inline_sizes	Sun Apr 11 23:21:00 2004
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+. ./conf
+
+find $prefix -name '*.o' \
+| grep -Fv 'built-in.o' \
+| {
+while read file; do
+    echo "$file" >&2
+    nm "$file" | grep ' T inline_' | sort \
+    | while read -r line; do
+	echo "$line $file"
+    done
+done
+} | {
+old_name='inline_end'
+old_addr=0
+old_junk=''
+while read -r addr t name junk; do
+    diff=$(( 0x$addr - 0x$old_addr ))
+    if test "$old_name" != "inline_end"; then
+	#printf "%s %8i %s\n" "$old_addr" "$diff" "$old_name"
+	printf "%i %s %s\n" "$diff" "$old_name" "$old_junk"
+    fi    
+    old_name="$name"
+    old_addr="$addr"
+    old_junk="$junk"
+done
+} \
+| sed 's/ inline_/ /' \
+| sed 's/_[0-9] / /' \
+| sort | uniq \
+> inline_sizes.log
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/70.sort_by_size linux-2.6.5-tiny/scripts/inline_hunter/70.sort_by_size
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/70.sort_by_size	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/70.sort_by_size	Sun Apr 11 23:13:21 2004
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+. ./conf
+
+cat inline_sizes.log \
+| cut -d' ' -f1-2 \
+| sort -nr | uniq \
+>inline_sizes_sorted.log
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/80.match linux-2.6.5-tiny/scripts/inline_hunter/80.match
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/80.match	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/80.match	Mon Apr 12 08:39:25 2004
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+./helper.80 inline_count.log inline_sizes_sorted.log \
+| {
+wasted=0
+# Pretty printing
+echo "Large inlines with multiple callers:"
+echo
+echo "Size  Uses Wasted Name and definition"
+echo "===== ==== ====== ================================================"
+while read -r size count name defined; do
+    if test "$size" -gt 39 && test "$count" -gt 1; then
+	# Formula is a bit arbitrary
+	w=$(( (size-20)*(count-1) ))
+	wasted=$(( wasted + w ))
+	printf "%5i %4i %6i %s\t%s\n" "$size" "$count" "$w" "$name" "$defined"
+    fi
+done
+echo "           ======"
+printf "%5s %4s %6i %s\n" " " " " "$wasted" "Total bytes wasted"
+} \
+>inline_sizes_count_defloc.log
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/conf linux-2.6.5-tiny/scripts/inline_hunter/conf
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/conf	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/conf	Sun Apr 11 23:33:37 2004
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+prefix=tree/
+
+function mk() {
+    CFLAGS=-std=gnu99 \
+    GCC_EXEC_PREFIX=/usr/app/gcc-3.3.3/lib/gcc-lib/ \
+    QTDIR=/usr/app/qt-3.0.3posix \
+    make -k bzImage
+}
+
+make=mk
diff -urN linux-2.6.5-tiny.orig/scripts/inline_hunter/helper.80 linux-2.6.5-tiny/scripts/inline_hunter/helper.80
--- linux-2.6.5-tiny.orig/scripts/inline_hunter/helper.80	Thu Jan  1 03:00:00 1970
+++ linux-2.6.5-tiny/scripts/inline_hunter/helper.80	Mon Apr 12 08:39:06 2004
@@ -0,0 +1,37 @@
+#!/usr/bin/python2.1
+
+import sys, re
+
+count={}
+defined={}
+
+f_count_func_defined = open(sys.argv[1])
+f_size_func = open(sys.argv[2])
+
+count_func_defined = re.compile(r" *(\d+) (\S+) (\S+)")
+size_func = re.compile(r" *(\d+) (\S+)")
+
+for l in f_count_func_defined.xreadlines():
+    g = count_func_defined.match(l)
+    if not g:
+        print "error"
+        sys.exit(1)
+    c, name, d = g.groups()
+    if count.has_key(name):
+	count[name] += int(c)
+	defined[name] += " "+d
+    else:
+	count[name] = int(c)
+	defined[name] = d
+
+while 1:
+    l=f_size_func.readline()
+    if l=='':
+        break
+    l=l[:len(l)-1]
+    g = size_func.match(l)
+    if not g:
+        print "error"
+        sys.exit(1)
+    sz, name = g.groups()
+    print sz, count[name], name, defined[name]

--Boundary-00=_3/ieA1FnGeFs4yT--

