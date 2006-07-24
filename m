Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWGXXKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWGXXKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 19:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWGXXKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 19:10:44 -0400
Received: from smtp1.Stanford.EDU ([171.67.22.28]:47258 "EHLO
	smtp1.stanford.edu") by vger.kernel.org with ESMTP id S932307AbWGXXKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 19:10:42 -0400
Message-ID: <1153782637.44c5536e013a4@webmail>
Date: Mon, 24 Jul 2006 16:10:38 -0700
From: Tom Walter Dillig <tdillig@stanford.edu>
To: linux-kernel@vger.kernel.org
Cc: w@1wt.eul, kernel_org@digitalpeer.com, security@kernel.org
Subject: Complete report of Null dereference errors in kernel 2.6.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Authenticated-User: tdillig
X-Originating-IP: 128.12.147.42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As promised earlier, here is the full list of errors that the SATURN tool
found on version *2.6.17.1* of the linux kernel. Please note that errors
1-20 were already included in my first email.
I hope this report is useful and please let us know if there is anything
else we can do to help,
-Tom & Isil Dillig

-------------------
Thomas Dillig
tdillig@stanford.edu
PhD Student, Stanford University

Isil Dillig
isil@stanford.edu
PhD Student, Stanford University
http://www.stanford.edu/~isil

------------------

-----------------------------
LINUX kernel version 2.6.17.1
-----------------------------
Full error report:


[1]
790 drivers/video/modedb.c
NULL dereference of variable "best"


[2]
6538 drivers/scsi/aic7xxx/aic7xxx_core.c
Possible null dereference of variable "cur_column" checked for NULL at
(6531:drivers/scsi/aic7xxx/aic7xxx_core.c)


[3]
46 sound/isa/sb/sb8_midi.c
NULL dereference of variable "chip" (inside macro SBP() )


[4]
239 drivers/usb/misc/usblcd.c
NULL dereference of variable "urb".


[5]
916 drivers/char/specialix.c
Possible null dereference of "bp" checked for NULL at
(917:drivers/char/specialix.c). Dereferenced through call chain
(drivers/char/specialix.c:sx_get_port, drivers/char/specialix.c:sx_in)


[6]
1196, 1201, 1204,... drivers/net/irda/donauboe.c
Possible null dereference of variable "self" checked for NULL at
(1170:drivers/net/irda/donauboe.c)


[7]
144 drivers/char/agp/ati-agp.c
NULL dereference of variable "ati_generic_private.gatt_pages" in function
call (drivers/char/agp/ati-agp.c:ati_free_gatt_pages).


[8]
816 net/decnet/dn_route.c
Possible null dereference of variable "rt->u.dst.dev" checked for NULL at
(809:net/decnet/dn_route.c) and aliased as variable "dev".


[9]
100 drivers/mtd/maps/ts5500_flash.c
NULL dereference of variable of "mymtd" in function call (map_destroy).


[10]
1092, 1093, 1115 drivers/net/bonding/bond_sysfs.c
Possible null dereference of variable "slave" checked for NULL at
(1097:drivers/net/bonding/bond_sysfs.c), aliased as variable "new_active".


[11]
512, 513 fs/ntfs/attrib.c
Possible null dereference of variable "ctx" checked for NULL at
(474:fs/ntfs/attrib.c).


[12]
562, 563 drivers/ide/pci/pdc202xx_old.c
Possible null dereference of variable "hwif" checked for NULL at
(565:drivers/ide/pci/pdc202xx_old.c).


[13]
1176, 1180 drivers/char/isicom.c
Possible null dereference of variable "tty" checked for NULL at
(1183:drivers/char/isicom.c).


[14]
1230, 1232 drivers/scsi/tmscsim.c
Possible null dereference of variable "psgl" checked for NULL at
(1249:drivers/scsi/tmscsim.c), aliased as "pcmd->request_buffer".


[15]
680 drivers/net/3c505.c
Possible null dereference  of variable "adapter->current_dma.skb" in
function call (include/linux/netdevice.h:dev_kfree_skb_irq) checked at
(688:drivers/net/3c505.c), aliased as variable "skb".


[16]
965 drivers/net/tulip/dmfe.c
NULL dereference of variable "skb".


[17]
730 drivers/net/hamradio/6pack.c
Possible null dereference of variable "sp" checked for NULL at
(733:drivers/net/hamradio/6pack.c).


[18]
405 drivers/acpi/dispatcher/dswload.c
Possible null dereference of variable "op->common.value.arg" checked for
NULL at (418:drivers/acpi/dispatcher/dswload.c).

[19]
639 fs/cifs/readdir.c
Possible null dereference of variable "cifsFile->srch_inf.ntwrk_buf_start"
in function call (smbCalcSize), checked for NULL at
(610:fs/cifs/readdir.c).


[20]
197, 198 fs/ocfs2/aops.c
Possible null dereference of variable "page" checked for NULL at
(201:fs/ocfs2/aops.c).

----------------------------------------------------------------------

[21]
618, 619, 620, 623, 624 drivers/isdn/hardware/eicon/message.c
Possible null dereference of variable "parms" checked at
(602:drivers/isdn/hardware/eicon/message.c,
631:drivers/isdn/hardware/eicon/message.c)

[22]
607 drivers/net/wireless/strip.c
Possible null dereference of variable "code_ptr" checked at
(565:drivers/net/wireless/strip.c)

[23]
819 drivers/net/sk98lin/skge.c
NULL dereference of variable "pPrevDescr" (if loop never executes).

[24]
268 lib/zlib_inflate/inftrees.c
NULL dereference of variable "q" (if loop never executes).

[25]
397 drivers/media/video/cpia_usb.c
Possible null dereference of variable "ucpia->curbuff" aliased as "mybuff"
checked at (404:drivers/media/video/cpia_usb.c).

[26]
1140 drivers/char/isicom.c
Possible null dereference of variable "tty" checked at
(1148:drivers/char/isicom.c).

[27]
1364 drivers/net/ixgb/ixgb_main.c
NULL dereference of variable "tx_desc" (if loop never executes).

[28]
253 drivers/video/cfbimgblt.c
NULL dereference of variable "tab" (switch statement missed default case).

[29]
2668 drivers/net/e1000/e1000_main.c
NULL dereference of variable "tx_desc" (if loop never executes).

[30]
1138 drivers/scsi/scsi_transport_fc.c
NULL dereference of variable "rport"

[31]
1209 drivers/char/esp.c
Possible null dereference of variable "tty" checked at
(1215:drivers/char/esp.c)

[32]
577, 578 drivers/serial/jsm/jsm_neo.c
Possible null dereference of variable "ch" checked at
(580:drivers/serial/jsm/jsm_neo.c).

[33]
394, 395, 398, 399, ... arch/i386/kernel/efi.c
Possible null dereference of variable "config_tables" checked at
(381:arch/i386/kernel/efi.c).

[34]
342, 344, ... arch/i386/kernel/efi.c
Possible null dereference of variable "efi.systab" checked at
(340:arch/i386/kernel/efi.c)

[35]
1574 drivers/char/pcmcia/synclink_cs.c
Possible null dereference of variable "tty" checked at
(1585:drivers/char/pcmcia/synclink_cs.c)

[36]
8798 drivers/scsi/aic7xxx/aic79xx_core.c
Possible null dereference of variable "cur_column" checked at
(8791:drivers/scsi/aic7xxx/aic79xx_core.c).

[37]
515 drivers/isdn/gigaset/i4l.c
Possible null dereference of variable "bcs" checked at
(499:drivers/isdn/gigaset/i4l.c).

[38]
2041 drivers/char/synclink.c
Possible null dereference of variable "tty" checked at
(2052:drivers/char/synclink.c).

[39]
1059 drivers/char/synclinkmp.c
Possible null dereference of variable "tty" checked at
(1070:drivers/char/synclinkmp.c).

[40]
348 drivers/scsi/sd.c
Possible null dereference of variable "sdp" checked at
(354:drivers/scsi/sd.c).

[41]
921 drivers/char/synclink_gt.c
Possible null dereference of variable "tty" checked at
(927:drivers/char/synclink_gt.c).

[42]
5655 drivers/scsi/ncr53c8xx.c
Possible null dereference of variable "sdev" checked at
(5663:drivers/scsi/ncr53c8xx.c).

[43]
1386 fs/nfsd/nfs4state.c
Possible null dereference of variable "dp" checked at
(1388:fs/nfsd/nfs4state.c).

[44]
223 include/linux/nfsd/nfsfh.h
NULL dereference of variable "scr->fh_dentry" aliased as "dentry".

[45]
284 fs/efs/inode.c
Possible null dereference of variable "bh" checked at (273:fs/efs/inode.c).

[46]
2414, 2422 fs/jffs/intrep.c
Possible null dereference of variable "f->range_head" aliased as "n" checked
at (2398:fs/jffs/intrep.c).

[47]
2476, 2482 fs/jffs/intrep.c
Possible null dereference of variable "f->range_tail" aliased as
"node->range_prev" checked at (2393:fs/jffs/intrep.c).

[48]
1075 fs/ocfs2/cluster/heartbeat.c
Possible null dereference of variable "p" in function call (simple_strtoul)
checked at (1076:fs/ocfs2/cluster/heartbeat.c).

[49]
307 fs/ocfs2/cluster/nodemanager.c
Possible null dereference of variable "p" in function call (simple_strtoul)
checked at (308:fs/ocfs2/cluster/nodemanager.c).

[50]
227 lib/ts_fsm.c
NULL dereference in function call of variable "next" called in
(lib/ts_fsm.c:match_token).

[51]
1162 fs/ocfs2/cluster/heartbeat.c
Possible null dereference of variable "p" checked at
(1163:fs/ocfs2/cluster/heartbeat.c) called in  (simple_strtoul).

[52]
1137 fs/ocfs2/cluster/heartbeat.c
Possible null dereference  with variable "p" checked at
(1138:fs/ocfs2/cluster/heartbeat.c) called in  (simple_strtoull).

[53]
1117 drivers/char/mxser.c
Possible null dereference of variable "tty" checked at
(1120:drivers/char/mxser.c).

[54]
1081 drivers/char/mxser.c
Possible null dereference of variable "tty" checked at
(1084:drivers/char/mxser.c).

[55]
3086 sound/oss/cs46xx.c
Possible null dereference of variable "card" checked at
(3087:sound/oss/cs46xx.c).

[56]
745 drivers/net/sk98lin/skvpd.c
NULL dereference in function call of variable "ip" called in
(drivers/net/sk98lin/skvpd.c:vpd_move_para)

[57]
1023, 1027 sound/oss/emu10k1/audio.c
Possible null dereference of variable "wiinst" checked at
(1013:sound/oss/emu10k1/audio.c).

[58]
2877 drivers/char/cyclades.c
Possible null dereference of variable "tty" checked at
(2887:drivers/char/cyclades.c).

[59]
429 drivers/pci/hotplug/ibmphp_core.c
Possible null dereference of variable "value" checked at
(404:drivers/pci/hotplug/ibmphp_core.c).

[60]
1725 drivers/char/specialix.c
Possible null dereference of variable "tty" checked at
(1736:drivers/char/specialix.c).

[61]
5396 drivers/net/wireless/ipw2200.c
Possible null dereference of variable "match->network" checked at
(5428:drivers/net/wireless/ipw2200.c).

[62]
243, 246 drivers/scsi/lpfc/lpfc_scsi.c
Possible null dereference of variable "scsi_cmnd->request_buffer" aliased as
"sgel" checked at (256:drivers/scsi/lpfc/lpfc_scsi.c).

[63]
713, 716 drivers/usb/host/ehci-sched.c
Possible null dereference of variable "dev->tt" checked at
(720:drivers/usb/host/ehci-sched.c).

[64]
692 drivers/serial/jsm/jsm_tty.c
Possible null dereference of variable "ch" checked at
(693:drivers/serial/jsm/jsm_tty.c).

[65]
240, 307 fs/xfs/xfs_iomap.c
Possible null dereference of variable "niomaps" checked at
(309:fs/xfs/xfs_iomap.c).

[66]
270 net/sctp/output.c
Possible null dereference of variable "packet->transport->asoc" in function
call  (net/sctp/output.c:sctp_packet_append_data [aliased as "asoc"],
include/net/sctp/sctp.h:__sctp_state) checked at (236:net/sctp/output.c).

[67]
934, 989, 1003, 1004, 1006, 1007 drivers/char/rio/rioroute.c
Possible null dereference of variable "pID2" checked at
(901:drivers/char/rio/rioroute.c).

[68]
274 drivers/message/fusion/mptbase.c
NULL dereference of varibel "mf" in function call;  called in
(mpt_free_msg_frame).

[69]
175 drivers/media/video/meye.c
Possible null dereference of variable "meye.mchip_ptable_toc" aliased as
"pt" checked at (183:drivers/media/video/meye.c)

[70]
1253 drivers/char/esp.c
Possible null dereference of variable "tty" checked at
(1259:drivers/char/esp.c).

[71]
1085 drivers/scsi/ultrastor.c
Possible null dereference of variable "mscp->SCint" checked at
(1097:drivers/scsi/ultrastor.c).

[72]
102, 105 lib/reed_solomon/decode_rs.c
Possible null dereference of variable "eras_pos" checked at
(266:lib/reed_solomon/decode_rs.c).

[73]
1673 drivers/char/specialix.c
Possible null dereference of variable "tty" checked at
(1686:drivers/char/specialix.c).

[74]
3297, 3298, 3292, 3301 drivers/scsi/BusLogic.c
Possible null dereference of variable "HostAdapter" checked at
(3306:drivers/scsi/BusLogic.c).

[75]
848 arch/i386/pci/irq.c
Possible null dereference of variable "r->get" checked at
(879:arch/i386/pci/irq.c).

[76]
841 arch/i386/pci/irq.c
Possible null dereference of variable "r->set" checked at
(883:arch/i386/pci/irq.c).

[77]
1144 net/sunrpc/auth_gss/svcauth_gss.c
Possible null dereference of variable "gsd->rsci" checked at
(1168:net/sunrpc/auth_gss/svcauth_gss.c).

[78]
468, 473 drivers/acpi/tables/tbget.c
Possible null dereference of variable
"acpi_gbl_table_lists[table_type].next" aliased as "table_desc" checked at
(446:drivers/acpi/tables/tbget.c).

[79]
780 drivers/acpi/processor_throttling.c
Possib
le null dereference of variable "pr" checked at
(185:drivers/acpi/processor_throttling.c).

[80]
1320 mm/shmem.c
Possible null dereference of variable "user" in function call
(user_shm_lock) checked at (1324:mm/shmem.c).

[81]
10057 drivers/net/wireless/ipw2200.c
Possible null dereference of variable "priv->workqueue" in function call
(queue_work) checked at (10044:drivers/net/wireless/ipw2200.c).

[82]
2132 drivers/char/synclink.c
Possible null dereference of variable "tty" checked at
(2142:drivers/char/synclink.c).

[83]
981 drivers/char/synclinkmp.c
Possible null dereference of variable "tty" checked at
(1041:drivers/char/synclinkmp.c).

[84]
1142 drivers/char/pcmcia/synclink_cs.c
Possible null dereference of variable "info->tty" checked at
(1146:drivers/char/pcmcia/synclink_cs.c).

[85]
866 drivers/char/synclink_gt.c
Possible null dereference of variable "tty" checked at
(873:drivers/char/synclink_gt.c).

[86]
336 include/linux/nfsd/nfsfh.h
Possible null dereference of variable "fhp->fh_dentry" checked at
(331:include/linux/nfsd/nfsfh.h).

[87]
91 sound/isa/gus/gus_mem.c
Possible null dereference of variable "block->prev" checked at
(101:sound/isa/gus/gus_mem.c).

[88]
100 sound/isa/gus/gus_mem.c
Possible null dereference of variable "block->next" checked at
(88:sound/isa/gus/gus_mem.c).

[89]
226 drivers/acpi/dispatcher/dswexec.c
Possible null dereference of variable "out_op" checked at
(248:drivers/acpi/dispatcher/dswexec.c).

[90]
2423, 2430, 2431 drivers/scsi/lpfc/lpfc_sli.c
Possible null dereference of variable "piocb" checked at
(2456:drivers/scsi/lpfc/lpfc_sli.c).

[91]
834 sound/oss/sequencer.c
Possible null dereference of variable "synth_devs[*q+1]" checked at
(747:sound/oss/sequencer.c).

[92]
1659 drivers/ide/ide-tape.c
Possible null dereference of variable "new_last_stage" checked at
(1673:drivers/ide/ide-tape.c).

[93]
598 fs/reiserfs/journal.c
Possible null dereference of variable "jl->j_list_bitmap" aliased as "jb"
checked at (595:fs/reiserfs/journal.c).

[94]
489 drivers/acpi/scan.c
Possible null dereference of variable "driver" checked at
(487:drivers/acpi/scan.c).

[95]
150 sound/core/seq/seq_midi.c
Possible null dereference of variable "msynth->parser" in function call
(snd_midi_event_reset_decode) checked at (152:sound/core/seq/seq_midi.c).

[96]
93, 94 net/sunrpc/xprt.c
Possible null dereference of variable "task" checked at
(99:net/sunrpc/xprt.c)

[97]
604, 337, 622, 317, 316, ... fs/ncpfs/sock.c
Possible null dereference of variable "server->rcv.creq" aliased as "req"
checked at (526:fs/ncpfs/sock.c).

[98]
3275 drivers/net/3c59x.c
NULL dereference in function call of macro "(VORTEX_PCI(vp)" called in
(pci_enable_wake, include/linux/pci.h:pci_read_config_word).

[99]
1161 drivers/pci/hotplug/cpqphp_ctrl.c
Always NULL dereference of "slot->hotplug_slot" (conditinal first part on
line 1161 :"!slot->hotplug_slot" holds and second part executes).

[100]
1374 drivers/pci/hotplug/ibmphp_pci.c
Possible null dereference of variable "bus" checked at
(1376:drivers/pci/hotplug/ibmphp_pci.c).

[101]
333, 345, 357, 363, 368, ... drivers/mtd/chips/cfi_cmdset_0002.c
Possible null dereference of variable "mtd" checked at
(390:drivers/mtd/chips/cfi_cmdset_0002.c).

[102]
322, 341 fs/jffs/jffs_fm.c
Possible null dereference of variable "fmc->tail" checked at
(295:fs/jffs/jffs_fm.c).

[103]
397 drivers/infiniband/core/mad.c
Possible null dereference of variable "qp_info->snoop_table" checked at
(409:drivers/infiniband/core/mad.c).

[104]
526, 538, 553, 567 drivers/usb/host/ehci-dbg.c
Possible null dereference of variable p.qh checked at
(578:drivers/usb/host/ehci-dbg.c).

[105]
1821, 1848 drivers/net/wireless/hostap/hostap_ioctl.c
Possible null dereference of variable "scan" checked at
(1862:drivers/net/wireless/hostap/hostap_ioctl.c).


[106]
401 drivers/serial/jsm/jsm_tty.c
NULL dereference of variable "brd->channels" in function call
(include/asm/string.h:__constant_c_and_count_memset) (memset) [conditional
on line 396 indicates this].

[107]
741 drivers/char/applicom.c
Possible null dereference of variable "apbs[IndexCard].RamIO" aliased as
"pmem"  in function call (include/asm/io.h:readb) checked at
(726:drivers/char/applicom.c).

[108]
126 sound/synth/util_mem.c
Possible null dereference of variable "prev" in function call
(include/linux/list.h:list_add) checked at (119:sound/synth/util_mem.c).

[109]
452 net/ieee80211/softmac/ieee80211softmac_io.c
Possible null dereference of variable "*pkt" in function call
(include/asm/string.h:__constant_c_and_count_memset) checked at
(453:net/ieee80211/softmac/ieee80211softmac_io.c)

[110]
303 drivers/scsi/lpfc/lpfc_sli.c
Possible null dereference of variable "psli->iocbq_lookup" checked at
(333:drivers/scsi/lpfc/lpfc_sli.c).

[111]
448, 451 sound/isa/wavefront/wavefront_synth.c
Can be NULL dereference of variable "rbuf" (set to NULL at line 356).

[112]
146 drivers/ide/pci/hpt34x.c
Possible null dereference of variable "id" checked at
(133:drivers/ide/pci/hpt34x.c).

[113]
227, 244, 259, 267, 232, 220, 258, 269, 260, 274
drivers/isdn/hardware/eicon/io.c
Possible null dereference of variable "IoAdapter" checked at
(295:drivers/isdn/hardware/eicon/io.c).

[114]
247 drivers/isdn/pcbit/layer2.c
Possible null dereference of variable "frame->skb" checked at
(199:drivers/isdn/pcbit/layer2.c).

[115]
189 drivers/ide/pci/slc90e66.c
Possible null dereference of variable "id" checked at
(180:drivers/ide/pci/slc90e66.c)

[116]
473 747 449 472 432 450, ... drivers/mtd/chips/cfi_cmdset_0001.c
Possible null dereference of variable "mtd" checked at
(487:drivers/mtd/chips/cfi_cmdset_0001.c).

[117]
547 drivers/isdn/hisax/hfc_usb.c
NULL dereference of variable "fifo->iso[i].purb" (checked and not retuned at
line 525).

[118]
644, 646, 650, 651 drivers/scsi/ibmmca.c
Possible null dereference of variable "ld(ihost_index)[ldn].cmd" aliased as
"cmd" checked at (553:drivers/scsi/ibmmca.c).

[119]
1706 drivers/scsi/aic7xxx/aic79xx_osm.c
Possible null dereference of variable "ahd->platform_data->host" in function
call (scsi_report_device_reset) checked at
(1711:drivers/scsi/aic7xxx/aic79xx_osm.c).

[120]
1705 drivers/scsi/aic7xxx/aic7xxx_osm.c
Possible null dereference of variable "ahd->platform_data->host" in function
call (scsi_report_device_reset) checked at
(1710:drivers/scsi/aic7xxx/aic79xx_osm.c).

[121]
362 drivers/scsi/aha1740.c
Possible null dereference of variable "done" checked at
(478:drivers/scsi/aha1740.c).

[122]
700 701 690 693 688 695 692 694 691 fs/affs/file.c
Possible null dereference of variable "bh" aliased as "prev_bh" checked at
(728:fs/affs/file.c).

[123]
1477 1476 1466 1429 1446 1456 sound/oss/sequencer.c
Possible null dereference of variable "synth_devs[dev]->ioctl" checked at
(1523:sound/oss/sequencer.c).

[124]
501 drivers/ide/pci/cmd64x.c
Possible null dereference of variable "id" checked at
(492:drivers/ide/pci/cmd64x.c).

[125]
685 drivers/ide/pci/sis5513.c
Possible null dereference of variable "id" checked at
(676:drivers/ide/pci/sis5513.c).

[126]
708 drivers/isdn/hisax/amd7930_fn.c
Possible null dereference of variable "cs->tx_skb" checked at
(722:drivers/isdn/hisax/amd7930_fn.c).

[127]
1567 net/tipc/link.c
Possible null dereference of variable "l_ptr->first_out" in function call
(net/tipc/core.h:buf_msg) checked at (1511:net/tipc/link.c,
1526:net/tipc/link.c) aliased as "buf".

[128]
1820 drivers/scsi/sg.c
Possible null dereference of variable "sfp" checked at
(1824:drivers/scsi/sg.c).

[129]
640, 642 sound/pci/hda/hda_codec.c
Possible null dereference of variable "info" aliased as
"&codec->amp_info[cur]" checked at (655:sound/pci/hda/hda_codec.c)

[130]
800, 816 fs/smbfs/request.c
Always NULL dereference of variable "req"

[131]
540, 545 fs/jffs2/readinode.c
Possible null dereference of variable "valid_ref" in macro "ref_offset"
aliased as "ref"  checked at (493:fs/jffs2/readinode.c).

[132]
986 kernel/kexec.c
NULL dereference of variable "image" in function call
(kernel/kexec.c:kimage_load_segment).

[133]
495 drivers/net/wireless/prism54/oid_mgt.c
Possible null dereference of variable "data" in fcuntion call
(drivers/net/wireless/prism54/oid_mgt.c:mgt_cpu_to_le) checked at
(510:drivers/net/wireless/prism54/oid_mgt.c).

[134]
316 net/sctp/sm_make_chunk.c
Possible null dereference of variable "chunk" checked at
(343:net/sctp/sm_make_chunk.c).

[135]
1291 net/atm/lec.c
Possible null dereference of variable "sizeoftlvs" checked at
(1296:net/atm/lec.c).

[136]
632 drivers/scsi/aha1542.c
Possible null dereference of variable "done" checked at
(765:drivers/scsi/aha1542.c).

[137]
632 drivers/scsi/aha1542.c
Possible null dereference of variable "done" checked at
(765:drivers/scsi/aha1542.c)

[138]
714, 719, 733, 714, 730, 731, 732 drivers/scsi/aha1542.c
Possible null dereference of variable "SCpnt->request_buffer" aliased as
"sgpnt" checked at (747:drivers/scsi/aha1542.c) aliased as "buff".

[139]
282 drivers/usb/storage/jumpshot.c
Possible null dereference of variable "us" checked at
(286:drivers/usb/storage/jumpshot.c).

[140]
280 drivers/usb/storage/datafab.c
Possible null dereference of variable "us" checked at
(284:drivers/usb/storage/datafab.c)

[141]
662 drivers/scsi/atp870u.c
Always NULL dereference of variable "done" (guaranteed by else brach of
conditional in line 655).

[142]
1164, 1165 drivers/atm/horizon.c
Possible null dereference of variable "dev->tx_iovec" checked at
(1147:drivers/atm/horizon.c).

[143]
238 net/irda/irnet/irnet_ppp.c
Possible null dereference of variable "ap->discoveries" checked at
(258:net/irda/irnet/irnet_ppp.c)

[144]
992 net/irda/ircomm/ircomm_tty_attach.c
Possible null dereference of variable "self->tty" in fucntion call
(ircomm_tty_check_modem_status) checked at
(995:net/irda/ircomm/ircomm_tty_attach.c).

[145]
224 fs/nfsd/nfs2acl.c
Possible null dereference of variable dentry checked at
(232:fs/nfsd/nfs2acl.c).

[146]
363, 432, 472 net/ieee80211/ieee80211_tx.c
Possible null dereference of variable "crypt->ops" checked at
(313:net/ieee80211/ieee80211_tx.c).

[147]
189 drivers/usb/storage/shuttle_usbat.c
Possible null dereference of variable "us" checked at
(192:drivers/usb/storage/shuttle_usbat.c).

[148]
345 drivers/usb/storage/datafab.c
Possible null dereference of variable "us" checked at
(349:drivers/usb/storage/datafab.c)

[149]
397, 383, 399 drivers/infiniband/ulp/ipoib/ipoib_main.c
Possible null dereference of variable "pathrec" checked at
(372:drivers/infiniband/ulp/ipoib/ipoib_main.c).

[150]
716 net/irda/irlmp_event.c
Possible null dereference of variable "skb" in function call
(irlmp_data_indication, include/linux/skbuff.h:skb_pull) checked at
(719:net/irda/irlmp_event.c).

[151]
1672, 1687, 1639, 1664, 1654, 1635,... drivers/isdn/gigaset/ev-layer.c
Possible null dereference of variable "at_state" checked at
(1696:drivers/isdn/gigaset/ev-layer.c).

[152]
1910 drivers/media/video/usbvideo/ibmcam.c
Possible null dereference of variable "uvd" checked through macro
"CAMERA_IS_OPERATIONAL" at (1948:drivers/media/video/usbvideo/ibmcam.c).

[153]
164 drivers/usb/serial/ark3116.c
Possible null dereference of variable "port->tty" checked at
(175:drivers/usb/serial/ark3116.c).

[154]
674 drivers/usb/class/cdc-acm.c
Possible null dereference of variable "acm" checked at
(676:drivers/usb/class/cdc-acm.c).

[155]
136, 139 drivers/usb/host/ehci-q.c
Possible null dereference of variable "urb->dev->tt" checked at
(696:drivers/usb/host/ehci-q.c) aliased as "tt".

[156]
802, 803, 808 drivers/acpi/utilities/utcopy.c
Possible null dereference of variable "source_object" checked at
(764:drivers/acpi/utilities/utcopy.c).

[157]
1377 drivers/net/pcmcia/xirc2ps_cs.c
Possible null dereference of variable "skb" in function call
(include/linux/skbuff.h:skb_padto) checked at
(1362:drivers/net/pcmcia/xirc2ps_cs.c).

[158]
822 drivers/net/wireless/hostap/hostap_cs.c
Possible null dereference of variable "dev" in function call 
(drivers/net/wireless/hostap/hostap_hw.c:prism2_hw_shutdown,
drivers/net/wireless/hostap/hostap_hw.c:hfa384x_events_only_cmd) checked at
(814:drivers/net/wireless/hostap/hostap_cs.c).

[159]
899 drivers/usb/storage/sddr55.c
Possible null dereference of variable "info->lba_to_pba" checked at
(789:drivers/usb/storage/sddr55.c).

[160]
431 drivers/scsi/qla2xxx/qla_os.c
Can be NULL dereference of variable "rport" (macro "starget_to_rport" can
return NULL).

[161]
1243 drivers/scsi/lpfc/lpfc_scsi.c
Can be NULL dereference of variable "rport" (macro "starget_to_rport" can
return NULL).

[162]
1090 drivers/scsi/qla2xxx/qla_os.c
Can be NULL dereference of variable "rport" (macro "starget_to_rport" can
return NULL).

[163]
624, 625 drivers/usb/serial/whiteheat.c
Possible null dereference of variable "port->tty" checked at
(607:drivers/usb/serial/whiteheat.c).

[164]
506, 519, 517, 542, 553, 555 drivers/char/ipmi/ipmi_si_intf.c
Possible null dereference of variable "smi_info->curr_msg" (aliased as
"msg") checked at (445:drivers/char/ipmi/ipmi_si_intf.c).

[165]
848 drivers/net/hamradio/mkiss.c
Possible null dereference of variable "ax" checked at
(852:drivers/net/hamradio/mkiss.c).

[166]
267 fs/ocfs2/cluster/nodemanager.c
Possible null dereference of variable "p" in function call (simple_strtoul)
checked at (268:fs/ocfs2/cluster/nodemanager.c).

[167]
486, 496 fs/ext2/balloc.c
Possible null dereference of variable "prealloc_count" checked at
(348:fs/ext2/balloc.c)

[168]
1420, 1424 drivers/atm/zatm.c
NULL dereference of variable "vcc->dev_data" in function call
(drivers/atm/zatm.c:open_rx_second [ZATM_VCC(d) returns d->dev_data]).

[169]
981, 1018, ... drivers/scsi/53c700.c
Possible null dereference of variable "SCp" checked at
(1245:drivers/scsi/53c700.c).

[170]
370 drivers/scsi/qla2xxx/qla_os.c
Can be NULL dereference of variable "rport".

[171]
1561 net/irda/irnet/irnet_irda.c
Possible null dereference of variable "self->discoveries" checked at
(1591:net/irda/irnet/irnet_irda.c).

[172]
988, 991 drivers/char/n_r3964.c
Possible null dereference of variable "pClient->last_msg" checked at
(968:drivers/char/n_r3964.c) [even though the check in 968 reassigns
"pClient->last_msg", the check is inside a conditional and might not
happen].

[173]
2700 drivers/char/tty_io.c
Possible null dereference of variable "disc" in function call
(tty_ldisc_deref) checked at (2698:drivers/char/tty_io.c,
2699:drivers/char/tty_io.c).

[174]
1590 drivers/isdn/hardware/eicon/message.c
 Possible null dereference of variable "appl" checked at
(1627:drivers/isdn/hardware/eicon/message.c).

[175]
748 drivers/scsi/tmscsim.c
Possible null dereference of variable "pACB->pActiveDCB" checked at
(785:drivers/scsi/tmscsim.c) aliased as "pDCB"

[176]
1800, 1853 drivers/media/video/usbvideo/ibmcam.c
Possible null dereference of variable "uvd" checked at
(1896:drivers/media/video/usbvideo/ibmcam.c).

[177]
616 drivers/usb/serial/ti_usb_3410_5052.c
Possible null dereference of variable "port->read_urb" checked at
(639:drivers/usb/serial/ti_usb_3410_5052.c) aliased as "urb".

[178]
807, 815, 826, 828 drivers/char/moxa.c
Possible null dereference of variable "ch" aliasing "tty->driver_data"
checked at (796:drivers/char/moxa.c).

[179]
285 drivers/usb/misc/sisusbvga/sisusb_con.c
NULL dereference of variable "c->vc_uni_pagedir_loc in function call
(con_set_default_unimap) [Conditional on line 284 ensures it's null].

[180]
1326 drivers/video/console/fbcon.c
NULL dereference of variable "svc->vc_uni_pagedir_loc" in function call
(con_set_default_unimap) [Conditional on line 1325 ensures it's null].

[181]
1086 drivers/video/console/fbcon.c
NULL dereference of variable "svc->vc_uni_pagedir_loc" in function call
(con_set_default_unimap) [Conditional on line 1085 ensures it's null].

[182]
1429 sound/pci/nm256/nm256.c
Possible null dereference of variable "chip->cport" in function call
(sound/pci/nm256/nm256.c:snd_nm256_playback_stop,
sound/pci/nm256/nm256.c:snd_nm256_writew, include/asm/io.h:writew) checked
at (1436:sound/pci/nm256/nm256.c).

[183]
541, 544, 545 drivers/media/dvb/bt8xx/bt878.c
Possible null dereference of (global) variable "bt->bt878_mem" in function
call (include/asm/io.h:writel) hecked at
(555:drivers/media/dvb/bt8xx/bt878.c)

[184]
1553 drivers/video/savage/savagefb_driver.c
Possible null dereference of variable "par->mmio.vbase" in function call
(drivers/video/savage/savagefb_driver.c:savage_disable_mmio,
drivers/video/savage/savagefb.h:vga_in8,
drivers/video/savage/savagefb.h:savage_in8, include/asm/io.h:readb) checked
at (1555:drivers/video/savage/savagefb_driver.c).

[185]
278 drivers/net/wan/c101.c
Possible null dereference of variable "card->win0base" in
function(include/asm/io.h:readb)  checked at (283:drivers/net/wan/c101.c).

[186]
169 net/sctp/endpointola.c
Possible null dereference of variable "ep->base.sk" checked at
(186:net/sctp/endpointola.c).

[187]
1661 drivers/isdn/hisax/hfc_usb.c
Possible null dereference of variable context checked at
(1663:drivers/isdn/hisax/hfc_usb.c).

[188]
1529 drivers/net/irda/via-ircc.c
Possible null dereference of variable self checked at
(1530:drivers/net/irda/via-ircc.c).

[189]
1009 net/irda/ircomm/ircomm_tty.c
Possible null dereference of variable tty checked at
(1017:net/irda/ircomm/ircomm_tty.c).

[190]
496 net/irda/ircomm/ircomm_tty.c
Possible null dereference of variable tty checked at
(501:net/irda/ircomm/ircomm_tty.c).

[191]
1588, 1591, 1615, 1630, 1631 drivers/scsi/53c700.c
Can be NULL dereference of variable "slot".

[192]
1079, 1090, 1099, 1131, 1104, ... drivers/scsi/megaraid/megaraid_sas.c
Possible null dereference of variable "cmd->scmd" checked at
(1055:drivers/scsi/megaraid/megaraid_sas.c,
1056:drivers/scsi/megaraid/megaraid_sas.c).

[193]
995 sound/pci/ali5451/ali5451.c
Possible null dereference of variable "pvoice->substream" checked at
(1000:sound/pci/ali5451/ali5451.c).

[194]
1524 sound/pci/rme96.c
Possible null dereference of variable "rme96->iobase" in function call
(sound/pci/rme96.c:snd_rme96_playback_stop, include/asm/io.h:readl) checked
at (1531:sound/pci/rme96.c).

[195]
849 sound/pci/ad1889.c
Possible null dereference of variable "chip->iobase" in function call 
(sound/pci/ad1889.c:ad1889_mute, sound/pci/ad1889.c:ad1889_writew,
include/asm/io.h:writew) checked at (866:sound/pci/ad1889.c).

[196]
1328 sound/pci/rme32.c
Possible null dereference of variable "rme32->iobase" in function call
(sound/pci/rme32.c:snd_rme32_pcm_stop, include/asm/io.h:writel) checked at
(1332:sound/pci/rme32.c).

[197]
1195 sound/pci/atiixp_modem.c
Possible null dereference of variable "chip->remap_addr" in function call
(sound/pci/atiixp_modem.c:snd_atiixp_chip_stop, include/asm/io.h:readl)
checked at (1200:sound/pci/atiixp_modem.c).

[198]
1522 sound/pci/atiixp.c
Possible null dereference of variable "chip->remap_addr" in function call
(sound/pci/atiixp.c:snd_atiixp_chip_stop, include/asm/io.h:writel) checked
at (1527:sound/pci/atiixp.c).

[199]
311 net/ipv4/fib_hash.c
Possible null dereference of variable "res->fi" checked at
(323:net/ipv4/fib_hash.c).

[200]
836 drivers/net/tulip/uli526x.c
Always NULL dereference of variable "skb" [branch on line 828 can fail with
skb == NULL].

[201]
1113, 1117 drivers/net/irda/via-ircc.c
Possible null dereference of variable "self->rx_buff.data" checked at
(1182:drivers/net/irda/via-ircc.c).

[202]
803 drivers/net/wireless/hostap/hostap_cs.c
Possible null dereference of variable "dev" in function call
(drivers/net/wireless/hostap/hostap_hw.c:prism2_suspend,
drivers/net/wireless/hostap/hostap_hw.c:prism2_hw_shutdown,
drivers/net/wireless/hostap/hostap_hw.c:hfa384x_events_only_cmd) checked at
(793:drivers/net/wireless/hostap/hostap_cs.c).

[203]
561 sound/drivers/dummy.c
Possible null dereference of variable "dummy" checked at
(565:sound/drivers/dummy.c).

[204]
371 net/sched/cls_tcindex.c
Possible null dereference of variable "arg" checked at
(375:net/sched/cls_tcindex.c).

[205]
666 drivers/net/tulip/uli526x.c
Possible null dereference of variable "dev" checked at
(669:drivers/net/tulip/uli526x.c)

[206]
610 drivers/net/znet.c
Possible null dereference of variable "dev" checked at
(615:drivers/net/znet.c, 622:drivers/net/znet.c)

[207]
1009 drivers/net/pcmcia/nmclan_cs.c
Possible null dereference of variable "dev" checked at
(1013:drivers/net/pcmcia/nmclan_cs.c).

[208]
401 drivers/acpi/dispatcher/dswload.c
Possible null dereference of variable "op->common.value.arg" checked at
(418:drivers/acpi/dispatcher/dswload.c).

[209]
966, 986 drivers/acpi/dispatcher/dsopcode.c
Possible null dereference of variable "walk_state->control_state" checked at
(1139:drivers/acpi/dispatcher/dsopcode.c).

[210]
1379 sound/pci/hda/hda_intel.c
Possible null dereference of variable "chip->remap_addr" in function call
(sound/pci/hda/hda_intel.c:azx_stream_stop, include/asm/io.h:readb) checked
at (1396:sound/pci/hda/hda_intel.c).

[211]
2396, 2399 sound/pci/intel8x0.c
Possible null dereference of variable "chip->remap_bmaddr" in function call
(sound/pci/intel8x0.c:iputbyte, include/asm/io.h:writeb) checked at
(2419:sound/pci/intel8x0.c).

[212]
1013, 1016 sound/pci/intel8x0m.c
Possible null dereference of variable "chip->remap_bmaddr" in function call
(sound/pci/intel8x0m.c:iputbyte, include/asm/io.h:writeb) checked at
(1024:sound/pci/intel8x0m.c).

[213]
1350, 1351, 1352 drivers/media/video/video-buf.c
Possible null dereference of variable "q->bufs[i]" checked at
(1312:drivers/media/video/video-buf.c).

[214]
355, 356, 488, 489 net/econet/af_econet.c
Possible null dereference of variable "saddr" checked at
(301:net/econet/af_econet.c).

[215]
1077, 1081 sound/core/timer.c
Possible null dereference of variable "timer->card" checked at
(1086:sound/core/timer.c)

[216]
317 sound/core/pcm_memory.c
Possible null dereference of variable "substream" checked at
(318:sound/core/pcm_memory.c).

[217]
331 drivers/infiniband/hw/mthca/mthca_cmd.c
Possible null dereference of variable "out_param" checked at
(312:drivers/infiniband/hw/mthca/mthca_cmd.c)

[218]
3122 drivers/atm/idt77252.c
Possible null dereference of variable card->membase in function call
(include/asm/io.h:writel) checked at (3170:drivers/atm/idt77252.c).

[219]
176 drivers/char/drm/via_mm.c
Possible null dereference of variable "dev->dev_private" aliased as
"dev_priv" in function call (via_release_futex) checked at
(181:drivers/char/drm/via_mm.c).

[220]
156 drivers/mtd/redboot.c
Always NULL dereference of variable "fl" [assuming it is possible that loop
never executes].

[221]
1831 net/ipx/af_ipx.c
Possible null dereference of variable "sk" checked at
(1876:net/ipx/af_ipx.c).

[222]
1850 net/sctp/sm_make_chunk.c
Possible null dereference variable "peer_addr" in function call
(net/sctp/sm_make_chunk.c:sctp_process_param, sctp_scope) checked at
(1842:net/sctp/sm_make_chunk.c).

[223]
358 drivers/pci/hotplug/ibmphp_core.c
Possible null dereference of variable "value" checked at
(345:drivers/pci/hotplug/ibmphp_core.c).

[224]
330 drivers/pci/hotplug/ibmphp_core.c
Possible null dereference of variable "value" checked at
(318:drivers/pci/hotplug/ibmphp_core.c).

[225]
389 drivers/pci/hotplug/ibmphp_core.c
Possible null dereference of variable "value" checked at
(372:drivers/pci/hotplug/ibmphp_core.c).

[226]
305 drivers/pci/hotplug/ibmphp_core.c
Possible null dereference of variable "value" checked at
(288:drivers/pci/hotplug/ibmphp_core.c).

[227]
587 drivers/char/drm/drm_vm.c
Possible null dereference of variable "dev->agp" checked at
(541:drivers/char/drm/drm_vm.c).

[228]
475 drivers/pci/hotplug/ibmphp_core.c
Possible null dereference of variable "value" checked at
(444:drivers/pci/hotplug/ibmphp_core.c).

[229]
221 sound/oss/soundcard.c
Possible null dereference of variable "mixer_devs[dev]" with "dev"=0 checked
at (215:sound/oss/soundcard.c).

[230]
196 drivers/acpi/processor_idle.c
Possible null dereference of variable "old" checked at
(176:drivers/acpi/processor_idle.c).

[231]
469 net/decnet/dn_route.c
Possible null dereference of variable "skb->dev" in funtion call
(net/decnet/dn_route.c:dn_route_input,
net/decnet/dn_route.c:dn_route_input_slow,
include/net/dn_dev.h:dn_dev_islocal) checked at
(473:net/decnet/dn_route.c).

[232]
1785 drivers/infiniband/hw/mthca/mthca_cmd.c
Possible null dereference of variable "mailbox" checked at
(1741:drivers/infiniband/hw/mthca/mthca_cmd.c) [note: the reassignment on
line 1742 does not affect line 1785 since this si in the else block of the
conditional in line 1737].

[233]
574 drivers/media/video/saa7134/saa6752hs.c
Possible null dereference of variable "arg" aliased as "f" checked at
(558:drivers/media/video/saa7134/saa6752hs.c) aliased as "params".

[234]
876 mm/memory.c
Possible null dereference  of variable "tlb" in function call (unmap_vmas)
checked at (877:mm/memory.c).

[235]
183, 184 sound/core/seq/oss/seq_oss_ioctl.c
Possible null dereference of variable "dp->writeq" checked at
(126:sound/core/seq/oss/seq_oss_ioctl.c).

[236]
1842 fs/xfs/xfs_log_recover.c
NULL dereference in function call of variable "data_map" called in
(xfs_next_bit) [default case missing from switch statement].

[237]
295 Possible null dereference of variable "rsdt_info->pointer" in function
call (acpi_tb_get_table_count) checked at
(355:drivers/acpi/tables/tbxfroot.c).

[238]
695, 710
Possible null dereference of variable "pf->disk" in function call
(drivers/block/paride/pf.c:pf_probe, drivers/block/paride/pf.c:pf_identify,
include/linux/genhd.h:get_capacity (set_capacity)) checked at
(695:drivers/block/paride/pf.c, 710:drivers/block/paride/pf.c).

[239]
562 fs/ocfs2/aops.c
Possible null dereference of variable "inode" checked at
(564:fs/ocfs2/aops.c).

[240]
197, 198, ... fs/ocfs2/aops.c
Possible null dereference of variable "page" checked at
(201:fs/ocfs2/aops.c)

[241]
1781 drivers/media/video/tvaudio.c
Possible null dereference of variable "desc->setmode" checked at
(1673:drivers/media/video/tvaudio.c).

[242]
364 s/nfsd/nfsfh.c
Possible null dereference of variable "ref_fh" in function call (fh_put)
checked at (335:fs/nfsd/nfsfh.c).

[243]
579, 602 net/decnet/dn_route.c
Possible null dereference of variable "dev" checked at
(628:net/decnet/dn_route.c)

[244]
377 fs/ocfs2/cluster/nodemanager.c
Possible null dereference of varialbe "p" in function call (simple_strtoul)
checked at (378:fs/ocfs2/cluster/nodemanager.c).

[245]
560, 561, 581, 599, 600 fs/xfs/xfs_trans_buf.c
Possible null dereference of variable "bip" alaised as
"(XFS_BUF_FSPRIVATE(bp, void *)"  checked at (529:fs/xfs/xfs_trans_buf.c).

[246]
1974 drivers/scsi/dpt_i2o.c
Possible null dereference of variable "pHba->host" in function call
(drivers/scsi/dpt_i2o.c:adpt_hba_reset,
drivers/scsi/dpt_i2o.c:adpt_fail_posted_scbs) checked at
(1972:drivers/scsi/dpt_i2o.c).

[247]
839 drivers/acpi/ec.c
Possible null dereference of variable "value" checked at
(845:drivers/acpi/ec.c, 884:drivers/acpi/ec.c)

[248]
512, 513 fs/ntfs/attrib.c
Possible null dereference of variable "ctx" checked at
(474:fs/ntfs/attrib.c)

[249]
1093, 1099, 1086, 1085, ...fs/namei.c
Possible null dereference of variable "nd" checked at (1128:fs/namei.c).

[250]
460 fs/coda/dir.c
Possible null dereference of variable "host_file->f_op" checked at
(468:fs/coda/dir.c).

[251]
433, 460 net/ipv6/reassembly.c
Possible null dereference of variable "skb->dev" in function call
(icmpv6_param_prob, icmpv6_send, include/net/addrconf.h:in6_dev_get)
checked at  (555:net/ipv6/reassembly.c).

[252]
26, 265 net/ipv4/ip_options.c
Possible null dereference of variable "skb" checked at
(255:net/ipv4/ip_options.c).

[253]
5989 drivers/scsi/ipr.c
Possible null dereference of variable "ioa_cfg->ipr_cmd_pool" in function
call (dma_pool_free) checked at (5996:drivers/scsi/ipr.c).

[254]
1234 drivers/scsi/megaraid/megaraid_mbox.c
Possible null dereference of variable "raid_dev->sg_pool_handle" in function
call (dma_pool_free) checked at
(1237:drivers/scsi/megaraid/megaraid_mbox.c).

[255]
2063, 2066, 2069 drivers/scsi/qla2xxx/qla_os.c
Possible null dereference of variable "ha->s_dma_pool" checked at
(2071:drivers/scsi/qla2xxx/qla_os.c).

[256]
1612, 1614 drivers/atm/he.c
Possible null dereference of variable "he_dev->pci_dev" aliased as 
"pci_dev" dereferenced in function call
(include/linux/pci.h:pci_read_config_dword),
(include/linux/pci.h:pci_write_config_dword) checked at
(1713:drivers/atm/he.c).

[257]
NULL dereference of variable "RequestSensePool" in function call
(pci_pool_free).

[258]
Possible null dereference of variable "ScatterGatherPool" in function call
(dma_pool_free) checked at (427:drivers/block/DAC960.c).

[259]
88 fs/aio.c
Possible null dereference of variable "info->ring_pages" checked at
(96:fs/aio.c).

[260]
2111 fs/xfs/xfs_alloc.c
Possible null dereference of variable "agflbp" checked at
(2109:fs/xfs/xfs_alloc.c) [switched && ||].

[261]
1746 fs/nfsd/nfs4xdr.c
Possible null dereference of variable "name" in function call
(fs/nfsd/nfs4xdr.c:nfsd4_encode_dirent_fattr, lookup_one_len) checked at
(1729:fs/nfsd/nfs4xdr.c).

[262]
133, 137 drivers/usb/serial/usb-serial.c
Possible null dereference of variable "serial->port[i]" checked at
(148:drivers/usb/serial/usb-serial.c).

[263]
2102, 2104, 2105 drivers/media/video/stradis.c
Possible null dereference of variable "saa->saa7146_mem" in function call
(include/asm/io.h:writel) checked at (2131:drivers/media/video/stradis.c).

[264]
313 sound/core/sound.c
Possible null dereference of variable "mptr" checked at
(303:sound/core/sound.c).

[265]
765, 766, 767 drivers/media/video/cpia_pp.c
Possible null dereference of variable "cpia->lowlevel_data" alaised as "cam"
checked at (750:drivers/media/video/cpia_pp.c).

[266]
1444 drivers/char/sonypi.c
Possible null dereference of global variable "sonypi_device.dev" in function
call (drivers/char/sonypi.c:sonypi_disable,
drivers/char/sonypi.c:sonypi_type1_dis,
include/linux/pci.h:pci_write_config_dword) checked at
(1460:drivers/char/sonypi.c).

[267]
672 net/decnet/dn_fib.c
Possible null dereference of variable "ifa->ifa_dev" checked at
(677:net/decnet/dn_fib.c).

[268]
691 fs/direct-io.c
Possible null dereference of variable "dio->cur_page" in function call
(fs/direct-io.c:dio_send_cur_page, fs/direct-io.c:dio_bio_add_page,
include/linux/mm.h:get_page) checked at (701:fs/direct-io.c).

[269]
50 drivers/net/phy/mdio_bus.c
Possible null dereference of variable "bus" checked at
(52:drivers/net/phy/mdio_bus.c).

[270]
129 drivers/message/i2o/driver.c
NULL dereference in function call of variable "drv->event_queue" called in
(destroy_workqueue).

[271]
528 drivers/net/wan/wanxl.c
Possible null dereference of variable "card->status" checked at
(537:drivers/net/wan/wanxl.c).

[272]
3152 drivers/net/bonding/bond_main.c
Possible null dereference of variable "bond_dev" checked at
(3156:drivers/net/bonding/bond_main.c).

[273]
1049 drivers/net/tokenring/3c359.c
Possible null dereference of variable "dev" checked at
(1053:drivers/net/tokenring/3c359.c).

[274]
201 drivers/net/pcmcia/com20020_cs.c
Possible null dereference of variable "link->priv" aliased as "info" checked
at (224:drivers/net/pcmcia/com20020_cs.c).

[275]
286 drivers/net/tokenring/olympic.c
Possible null dereference of variable "dev" checked at
(218:drivers/net/tokenring/olympic.c).

[276]
1043, 1051, 1075, 1083, 1091, ... drivers/ieee1394/sbp2.c
Possible null dereference of variable "hi" checked at
(1096:drivers/ieee1394/sbp2.c).

[277]
1394 net/sunrpc/svcsock.c
Possible null dereference of variable "sin" checked at
(1407:net/sunrpc/svcsock.c).

[278]
1509, 1520 drivers/message/fusion/mptsas.c
Possible null dereference of variable "port_info->phy_info" checked at
(1496:drivers/message/fusion/mptsas.c).

[279]
763, 764, 768, 770, 771, 776, 779, 786, ...
drivers/pci/hotplug/pciehp_ctrl.c
Possible null dereference of variable "p_slot" checked at
(793:drivers/pci/hotplug/pciehp_ctrl.c).

[280]
1956 drivers/pci/hotplug/cpqphp_ctrl.c
Possible null dereference of variable "ctrl" in function call
(drivers/pci/hotplug/cpqphp.h:is_slot_enabled) checked at
(1966:drivers/pci/hotplug/cpqphp_ctrl.c,
1990:drivers/pci/hotplug/cpqphp_ctrl.c).

[281]
1344 drivers/message/fusion/mptsas.c
Possible null dereference of variable "hba->phy_info" checked at
(1345:drivers/message/fusion/mptsas.c).

[282]
1208 fs/nfs/inode.c
Possible null dereference of variable inode checked at
(1211:fs/nfs/inode.c).

[283]
28, 37 fs/nfs/nfs3acl.c
fs/nfs/nfs3acl.c
Possible null dereference in macro "output" of variable "buffer" in function
call (include/asm/string.h:__constant_memcpy) checked at
(44:fs/nfs/nfs3acl.c).

[284]
586 fs/xfs/quota/xfs_dquot.c
Possible null dereference of variable "tpp"" checked at
(532:fs/xfs/quota/xfs_dquot.c)

[285]
620 fs/xfs/quota/xfs_dquot.c
Possible null dereference of variable "bp" checked at
(611:fs/xfs/quota/xfs_dquot.c).

[286]
1297 fs/nfs/dir.c
Possible null dereference of variable "dentry->d_inode" checked at
(1285:fs/nfs/dir.c, 1325:fs/nfs/dir.c).


-----------------------------------------------------------------------
POTENTIAL NULL RETURNS:

[R1]
Return value from function
"drivers/media/video/saa7134/saa7134-video.c:ctrl_by_id" may be null.
Not checked:
2343, 2344, 2345, 2347, 2349 drivers/media/video/saa7134/saa7134-video.c

[R2]
Return value from function "__ip_conntrack_expect_find" may be null.
Not checked:
1095 net/ipv4/netfilter/ip_conntrack_helper_h323.c

[R3]
Return value from function "format_by_fourcc" may be null.
Not checked:
607 drivers/media/common/saa7146_hlp.c
868 drivers/media/common/saa7146_hlp.c
711, 722 drivers/media/common/saa7146_hlp.c
601 drivers/media/common/saa7146_video.c
1408 drivers/media/common/saa7146_video.c

[R4]
Return value from function "drivers/net/lp486e.c:pa_to_va" may be null.
Not checked:
478 drivers/net/lp486e.c

[R5]
Return value from function "usb_ifnum_to_if" may be null.
Not checked:
1704 sound/usb/usbmixer.c
1605 sound/usb/usbmixer.c
2570 sound/usb/usbaudio.c
2737 sound/usb/usbaudio.c

[R6]
Return value from function "create_proc_entry" may be null.
Not checked:
4535, ... drivers/net/wireless/airo.c
5621, 5622 drivers/net/wireless/airo.

[R7]
Return value from function include/linux/libata.h:ata_qc_from_tag may be
null.
Not checked:
2046, 2055, 2056 drivers/scsi/sata_mv.c

[R8]
Return value from function "kernel/resource.c:__request_resource" may be
null.
Not checked:
342 kernel/resource.c

[R9]
Return value from function "v9fs_fid_lookup" may be null.
Not checked:
561 fs/9p/vfs_inode.c
485 fs/9p/vfs_inode.c

[R10]
Return value from function "elv_next_request" may be null.
Not checked:
1533 drivers/cdrom/aztcd.c
1078 drivers/cdrom/sjcd.c
1013 drivers/cdrom/optcd.c

[R11]
Return value from function "drivers/telephony/ixj.c:ixj_alloc" may be null.
Not checked:
7091, 7093, 7094, 7095 drivers/telephony/ixj.c

[R12]
Return value from function "fs/ocfs2/cluster/nodemanager.c:to_o2nm_node" may
be null.
Not checked:
578, 590, 594 fs/ocfs2/cluster/nodemanager.c

[R13]
Return value from function "ib_get_client_data" may be null.
Not checked:
1735 drivers/infiniband/ulp/srp/ib_srp.c
1123 drivers/infiniband/ulp/ipoib/ipoib_main.c

[R14]
Return value from function "igrab" may be null.
Not checked:
314 fs/nfs/delegation.c


