Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315807AbSEJFBk>; Fri, 10 May 2002 01:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315808AbSEJFBj>; Fri, 10 May 2002 01:01:39 -0400
Received: from zok.SGI.COM ([204.94.215.101]:6852 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315807AbSEJFBe>;
	Fri, 10 May 2002 01:01:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.15 warnings
In-Reply-To: Your message of "Fri, 10 May 2002 13:26:09 +1000."
             <26013.1021001169@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 May 2002 15:01:25 +1000
Message-ID: <26949.1021006885@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002 13:26:09 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>The following config options are broken in 2.5.15 i386.

After suppressing all the broken config options, a full 2.5.15 i386
build (non modular) gets these warnings.  Repeated messages trimmed.
Most of it is fall out from the "bitopts must be long" change.

arch/i386/kernel/mca.c:314: warning: initialization from incompatible pointer type

fs/dnotify.c: In function `__inode_dir_notify':
fs/dnotify.c:139: warning: label `out' defined but not used

fs/coda/dir.c: In function `coda_permission':
fs/coda/dir.c:151: warning: unused variable `mode'

fs/bfs/inode.c: In function `bfs_delete_inode':
fs/bfs/inode.c:165: warning: passing arg 2 of `clear_bit' from incompatible pointer type
fs/bfs/inode.c: In function `bfs_fill_super':
fs/bfs/inode.c:330: warning: passing arg 2 of `set_bit' from incompatible pointer type
fs/bfs/inode.c:356: warning: passing arg 2 of `set_bit' from incompatible pointer type
fs/bfs/dir.c: In function `bfs_create':
fs/bfs/dir.c:93: warning: passing arg 1 of `find_first_zero_bit' from incompatible pointer type
fs/bfs/dir.c:99: warning: passing arg 2 of `set_bit' from incompatible pointer type

fs/devfs/base.c: In function `is_devfsd_or_child':
fs/devfs/base.c:1403: warning: unused variable `p'

fs/nfs/nfsroot.c: In function `root_nfs_parse_addr':
fs/nfs/nfsroot.c:189: warning: implicit declaration of function `in_aton'

fs/reiserfs/namei.c: In function `linear_search_in_dir_item':
fs/reiserfs/namei.c:251: warning: passing arg 2 of `set_bit' from incompatible pointer type
fs/reiserfs/namei.c: In function `reiserfs_add_entry':
fs/reiserfs/namei.c:507: warning: passing arg 1 of `find_first_zero_bit' from incompatible pointer type
fs/reiserfs/journal.c: In function `set_bit_in_list_bitmap':
fs/reiserfs/journal.c:207: warning: passing arg 2 of `set_bit' from incompatible pointer type
fs/reiserfs/journal.c: In function `reiserfs_in_journal':
fs/reiserfs/journal.c:553: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
fs/reiserfs/journal.c:553: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type

drivers/acpi/hardware/hwgpe.c:33: warning: `_THIS_MODULE' defined but not used
drivers/acpi/namespace/nsxfname.c:38: warning: `_THIS_MODULE' defined but not used
drivers/acpi/resources/rsdump.c:31: warning: `_THIS_MODULE' defined but not used
drivers/acpi/utilities/utdebug.c:30: warning: `_THIS_MODULE' defined but not used

drivers/char/mxser.c: In function `mxser_init':
drivers/char/mxser.c:655: warning: suggest parentheses around assignment used as truth value
drivers/char/epca.c: In function `do_softint':
drivers/char/epca.c:3426: warning: passing arg 2 of `test_and_clear_bit' from incompatible pointer type
drivers/char/ip2.c:36: warning: `poll_only' defined but not used
drivers/char/ip2/i2cmd.c:142: warning: `ct89' defined but not used
drivers/char/ip2/i2ellis.c:107: warning: `iiEllisCleanup' defined but not used
drivers/char/specialix.c: In function `sx_mark_event':
drivers/char/specialix.c:613: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/char/specialix.c: In function `do_softint':
drivers/char/specialix.c:2214: warning: passing arg 2 of `test_and_clear_bit' from incompatible pointer type
drivers/char/sx.c: In function `sx_interrupt':
drivers/char/sx.c:1263: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
drivers/char/sx.c:1285: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/char/generic_serial.c: In function `gs_do_softint':
drivers/char/generic_serial.c:579: warning: passing arg 2 of `test_and_clear_bit' from incompatible pointer type
drivers/char/applicom.c:268:2: warning: #warning "LEAK"
drivers/char/applicom.c:532:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"

drivers/char/ftape/zftape/zftape-init.c: In function `zft_open':
drivers/char/ftape/zftape/zftape-init.c:116: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
drivers/char/ftape/zftape/zftape-init.c:122: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/char/ftape/zftape/zftape-init.c:130: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/char/ftape/zftape/zftape-init.c: In function `zft_close':
drivers/char/ftape/zftape/zftape-init.c:149: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/ftape/zftape/zftape-init.c:159: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/char/ftape/zftape/zftape-init.c: In function `zft_ioctl':
drivers/char/ftape/zftape/zftape-init.c:172: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/ftape/zftape/zftape-init.c: In function `zft_mmap':
drivers/char/ftape/zftape/zftape-init.c:192: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/ftape/zftape/zftape-init.c: In function `zft_read':
drivers/char/ftape/zftape/zftape-init.c:222: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/ftape/zftape/zftape-init.c: In function `zft_write':
drivers/char/ftape/zftape/zftape-init.c:245: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type

drivers/char/drm/mga_dma.c: In function `mga_do_dma_wrap_start':
drivers/char/drm/mga_dma.c:244: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/char/drm/mga_dma.c: In function `mga_do_dma_wrap_end':
drivers/char/drm/mga_dma.c:261: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/char/drm/mga_dma.c: In function `mga_dma_flush':
drivers/char/drm/mga_dma.c:710: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_dma.c: In function `mga_dma_buffers':
drivers/char/drm/mga_dma.c:801: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_dispatch_clear':
drivers/char/drm/mga_state.c:598: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_dispatch_swap':
drivers/char/drm/mga_state.c:654: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_dispatch_vertex':
drivers/char/drm/mga_state.c:703: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_dispatch_indices':
drivers/char/drm/mga_state.c:749: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_dispatch_iload':
drivers/char/drm/mga_state.c:806: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_clear':
drivers/char/drm/mga_state.c:893: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_swap':
drivers/char/drm/mga_state.c:917: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_vertex':
drivers/char/drm/mga_state.c:963: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_indices':
drivers/char/drm/mga_state.c:1005: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_iload':
drivers/char/drm/mga_state.c:1046: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/mga_state.c: In function `mga_dma_blit':
drivers/char/drm/mga_state.c:1078: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/char/drm/i810_dma.c: In function `i810_free_page':
drivers/char/drm/i810_dma.c:300: warning: implicit declaration of function `unlock_page'

drivers/block/floppy.c: In function `floppy_revalidate':
drivers/block/floppy.c:3862: warning: unused variable `bh'
drivers/block/cciss.c: In function `cmd_alloc':
drivers/block/cciss.c:281: warning: passing arg 1 of `find_first_zero_bit' from incompatible pointer type
drivers/block/cciss.c:284: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
drivers/block/cciss.c: In function `cmd_free':
drivers/block/cciss.c:330: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/block/cciss.c: In function `cciss_geninit':
drivers/block/cciss.c:341: warning: unused variable `j'

drivers/net/epic100.c: In function `set_rx_mode':
drivers/net/epic100.c:1338: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/sis900.c: In function `set_rx_mode':
drivers/net/sis900.c:2073: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/yellowfin.c: In function `set_rx_mode':
drivers/net/yellowfin.c:1375: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/yellowfin.c:1377: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/yellowfin.c:1379: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/yellowfin.c:1382: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/fealnx.c: In function `set_rx_mode':
drivers/net/fealnx.c:1754: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/setup.c: In function `special_device_init':
drivers/net/setup.c:154: warning: initialization makes integer from pointer without a cast
drivers/net/lance.c: In function `lance_probe1':
drivers/net/lance.c:590: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/lance.c:590: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
drivers/net/at1700.c: In function `set_rx_mode':
drivers/net/at1700.c:838: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/arlan.c:26: warning: `probe' defined but not used
drivers/net/arlan.c:1128: warning: `arlan_find_devices' defined but not used
drivers/net/atp.c: In function `eeprom_op':
drivers/net/atp.c:412: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/atp.c: In function `set_rx_mode_8012':
drivers/net/atp.c:898: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/ni65.c: In function `ni65_probe1':
drivers/net/ni65.c:407: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/ni65.c:418: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/dl2k.c: In function `set_multicast':
drivers/net/dl2k.c:1090: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/dl2k.c:1091: warning: passing arg 2 of `set_bit' from incompatible pointer type

drivers/net/tokenring/ibmtr.c: In function `find_turbo_adapters':
drivers/net/tokenring/ibmtr.c:262: warning: assignment makes integer from pointer without a cast
drivers/net/tokenring/ibmtr.c:303: warning: passing arg 1 of `iounmap' makes pointer from integer without a cast
drivers/net/tokenring/tmsisa.c:44: warning: `portlist' defined but not used

drivers/net/wan/comx-hw-munich.c: In function `MUNICH_close':
drivers/net/wan/comx-hw-munich.c:2011: warning: assignment from incompatible pointer type
drivers/net/wan/comx-hw-munich.c: In function `BOARD_exit':
drivers/net/wan/comx-hw-munich.c:2780: warning: unused variable `hw'
drivers/net/wan/sdlamain.c: In function `check_s508_conflicts':
drivers/net/wan/sdlamain.c:641: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdlamain.c: In function `check_s514_conflicts':
drivers/net/wan/sdlamain.c:735: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdlamain.c: In function `wakeup_sk_bh':
drivers/net/wan/sdlamain.c:1313: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_x25.c: In function `x25api_bh':
drivers/net/wan/sdla_x25.c:4266: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_x25.c: In function `send_delayed_cmd_result':
drivers/net/wan/sdla_x25.c:4775: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_x25.c: In function `send_oob_msg':
drivers/net/wan/sdla_x25.c:4877: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c: In function `new_if':
drivers/net/wan/sdla_chdlc.c:888: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c: In function `if_open':
drivers/net/wan/sdla_chdlc.c:1090: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c: In function `process_route':
drivers/net/wan/sdla_chdlc.c:2857: warning: format argument is not a pointer (arg 3)
drivers/net/wan/sdla_chdlc.c:2857: warning: too many arguments for format
drivers/net/wan/sdla_chdlc.c: In function `chdlc_poll':
drivers/net/wan/sdla_chdlc.c:3662: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c:3695: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c:3712: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c:3713: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c:3719: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c:3748: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c:3749: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_chdlc.c:3755: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c: In function `new_if':
drivers/net/wan/sdla_ppp.c:569: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c: In function `if_open':
drivers/net/wan/sdla_ppp.c:838: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c: In function `event_intr':
drivers/net/wan/sdla_ppp.c:1956: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:2028: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c: In function `timer_intr':
drivers/net/wan/sdla_ppp.c:2101: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:2108: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:2109: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c: In function `ppp_poll':
drivers/net/wan/sdla_ppp.c:3533: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3562: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3577: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3578: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3585: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3612: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3613: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3620: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3625: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/net/wan/sdla_ppp.c:3628: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/net/wan/pc300_tty.c: In function `cpc_tty_rx_task':
drivers/net/wan/pc300_tty.c:735: warning: passing arg 2 of pointer to function discards qualifiers from pointer target type

drivers/net/pcmcia/fmvj18x_cs.c: In function `set_rx_mode':
drivers/net/pcmcia/fmvj18x_cs.c:1281: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/pcmcia/xirc2ps_cs.c:2099:18: warning: extra tokens at end of #undef directive
drivers/net/pcmcia/axnet_cs.c:1119: warning: `ei_close' defined but not used

In file included from drivers/net/wireless/wavelan_cs.c:59:
drivers/net/wireless/wavelan_cs.p.h:495:33: warning: extra tokens at end of #undef directive

drivers/net/tulip/winbond-840.c: In function `__set_rx_mode':
drivers/net/tulip/winbond-840.c:1438: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/net/tulip/winbond-840.c: At top level:
drivers/net/tulip/winbond-840.c:149: warning: `version' defined but not used

drivers/net/hamradio/hdlcdrv.c: In function `hdlcdrv_transmitter':
drivers/net/hamradio/hdlcdrv.c:336: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
drivers/net/hamradio/hdlcdrv.c:341: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/net/hamradio/hdlcdrv.c:350: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/net/hamradio/hdlcdrv.c:362: warning: passing arg 2 of `clear_bit' from incompatible pointer type

drivers/net/irda/w83977af_ir.c:275: warning: `w83977af_close' defined but not used
drivers/net/irda/ali-ircc.c:467: warning: `ali_ircc_probe_43' defined but not used

drivers/media/video/videodev.c: In function `videodev_exit':
drivers/media/video/videodev.c:503: warning: implicit declaration of function `videodev_proc_destroy'
drivers/media/video/msp3400.c: In function `msp_attach':
drivers/media/video/msp3400.c:1237: warning: `rev2' might be used uninitialized in this function
drivers/media/video/w9966.c:642: warning: `w9966_rReg_i2c' defined but not used

drivers/atm/eni.c: In function `eni_close':
drivers/atm/eni.c:1870: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/eni.c:1877: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/eni.c: In function `get_ci':
drivers/atm/eni.c:1895: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/eni.c:1912: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/eni.c: In function `eni_open':
drivers/atm/eni.c:1927: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/eni.c:1934: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/eni.c:1939: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/eni.c:1962: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/zatm.c: In function `zatm_close':
drivers/atm/zatm.c:1561: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/zatm.c:1569: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/zatm.c: In function `zatm_open':
drivers/atm/zatm.c:1581: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/zatm.c:1587: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/zatm.c:1591: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/zatm.c:1594: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/zatm.c:1617: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/zatm.c: In function `zatm_send':
drivers/atm/zatm.c:1751: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/nicstar.c: In function `ns_open':
drivers/atm/nicstar.c:1495: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/nicstar.c:1500: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/nicstar.c:1504: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/nicstar.c:1513: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1514: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1537: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1538: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1546: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1547: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1554: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1555: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1574: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1575: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1587: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1588: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1634: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/nicstar.c: In function `ns_close':
drivers/atm/nicstar.c:1652: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1761: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/nicstar.c:1762: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/idt77252.c: In function `idt77252_open':
drivers/atm/idt77252.c:2466: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/idt77252.c:2539: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/idt77252.c: In function `idt77252_close':
drivers/atm/idt77252.c:2561: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/idt77252.c: In function `idt77252_change_qos':
drivers/atm/idt77252.c:2682: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `make_rate':
drivers/atm/horizon.c:606: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `rx_schedule':
drivers/atm/horizon.c:1075: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `rx_bus_master_complete_handler':
drivers/atm/horizon.c:1095: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `tx_hold':
drivers/atm/horizon.c:1108: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `tx_release':
drivers/atm/horizon.c:1122: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `tx_schedule':
drivers/atm/horizon.c:1158: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/horizon.c:1186: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `tx_bus_master_complete_handler':
drivers/atm/horizon.c:1253: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `rx_data_av_handler':
drivers/atm/horizon.c:1299: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
drivers/atm/horizon.c:1395: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `hrz_open':
drivers/atm/horizon.c:2534: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/horizon.c:2559: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `hrz_close':
drivers/atm/horizon.c:2573: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/horizon.c:2615: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/horizon.c: In function `hrz_probe':
drivers/atm/horizon.c:2869: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/ambassador.c:301:10: warning: pasting "." and "start" does not give a valid preprocessing token
drivers/atm/ambassador.c:305:10: warning: pasting "." and "regions" does not give a valid preprocessing token
drivers/atm/ambassador.c:310:10: warning: pasting "." and "data" does not give a valid preprocessing token
drivers/atm/ambassador.c: In function `command_do':
drivers/atm/ambassador.c:584: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/ambassador.c: In function `tx_give':
drivers/atm/ambassador.c:660: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/ambassador.c: In function `drain_rx_pool':
drivers/atm/ambassador.c:777: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/ambassador.c: In function `fill_rx_pool':
drivers/atm/ambassador.c:817: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/ambassador.c: In function `dont_panic':
drivers/atm/ambassador.c:996: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/ambassador.c: In function `amb_open':
drivers/atm/ambassador.c:1268: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/ambassador.c:1343: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/ambassador.c: In function `amb_close':
drivers/atm/ambassador.c:1358: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/ambassador.c:1423: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/ambassador.c: In function `amb_send':
drivers/atm/ambassador.c:1473: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/atmtcp.c: In function `atmtcp_send_control':
drivers/atm/atmtcp.c:67: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/atmtcp.c:70: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/atmtcp.c: In function `atmtcp_recv_control':
drivers/atm/atmtcp.c:96: warning: passing arg 2 of `change_bit' from incompatible pointer type
drivers/atm/atmtcp.c:99: warning: passing arg 2 of `change_bit' from incompatible pointer type
drivers/atm/atmtcp.c: In function `atmtcp_v_open':
drivers/atm/atmtcp.c:133: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/atmtcp.c:134: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/atmtcp.c: In function `atmtcp_v_close':
drivers/atm/atmtcp.c:149: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/atmtcp.c: In function `atmtcp_v_send':
drivers/atm/atmtcp.c:176: warning: `out_vcc' might be used uninitialized in this function
drivers/atm/atmtcp.c: In function `atmtcp_attach':
drivers/atm/atmtcp.c:372: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/atmtcp.c:373: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/iphase.c: In function `ia_que_tx':
drivers/atm/iphase.c:638: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/iphase.c: In function `ia_close':
drivers/atm/iphase.c:2586: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/iphase.c:2654: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/iphase.c: In function `ia_open':
drivers/atm/iphase.c:2663: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/iphase.c:2680: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/iphase.c:2706: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/iphase.c: In function `ia_send':
drivers/atm/iphase.c:3070: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/firestream.c: In function `fs_open':
drivers/atm/firestream.c:885: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/firestream.c:899: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/firestream.c:911: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/firestream.c:911: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
drivers/atm/firestream.c:1095: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/firestream.c: In function `fs_close':
drivers/atm/firestream.c:1111: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/lanai.c: In function `lanai_close':
drivers/atm/lanai.c:2484: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/lanai.c:2485: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/lanai.c:2510: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/lanai.c: In function `lanai_open':
drivers/atm/lanai.c:2520: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/atm/lanai.c:2528: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/lanai.c:2583: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/fore200e.c: In function `fore200e_open':
drivers/atm/fore200e.c:1420: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/fore200e.c:1479: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/fore200e.c: In function `fore200e_close':
drivers/atm/fore200e.c:1502: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/atm/fore200e.c: In function `fore200e_change_qos':
drivers/atm/fore200e.c:1989: warning: passing arg 2 of `set_bit' from incompatible pointer type

drivers/ide/amd74xx.c:93: warning: `amd_udma2cyc' defined but not used
drivers/ide/hpt366.c:493: warning: `hpt366_proc' defined but not used
drivers/ide/pdcadma.c:63: warning: `pdcadma_dmaproc' defined but not used

drivers/ide/ide-tape.c: In function `idetape_output_buffers':
drivers/ide/ide-tape.c:1533: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_update_buffers':
drivers/ide/ide-tape.c:1563: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_copy_stage_from_user':
drivers/ide/ide-tape.c:2927: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_empty_write_pipeline':
drivers/ide/ide-tape.c:3885: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_pad_zeros':
drivers/ide/ide-tape.c:4160: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_chrdev_read':
drivers/ide/ide-tape.c:4593: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c:4612: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_chrdev_write':
drivers/ide/ide-tape.c:4887: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_setup':
drivers/ide/ide-tape.c:6072: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c:6072: warning: duplicate `const'
drivers/ide/ide-tape.c:6072: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c:6072: warning: comparison of distinct pointer types lacks a cast

drivers/scsi/ultrastor.c: In function `ultrastor_queuecommand':
drivers/scsi/ultrastor.c:791: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/scsi/ultrastor.c: In function `ultrastor_interrupt':
drivers/scsi/ultrastor.c:1102: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/scsi/ultrastor.c:1142: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/scsi/megaraid.c: In function `mega_cmd_done':
drivers/scsi/megaraid.c:1115: warning: passing arg 2 of `__constant_memcpy' makes pointer from integer without a cast
drivers/scsi/megaraid.c:1115: warning: passing arg 2 of `__memcpy' makes pointer from integer without a cast
drivers/scsi/ppa.c: In function `ppa_detect':
drivers/scsi/ppa.c:113: warning: `hreg' might be used uninitialized in this function
drivers/scsi/sd.c:64: warning: `sd_version_str' defined but not used
drivers/scsi/sr.c: In function `sr_init':
drivers/scsi/sr.c:700: warning: unused variable `i'
drivers/scsi/sr.c:727: warning: label `cleanup_sizes' defined but not used

In file included from drivers/ieee1394/hosts.c:19:
drivers/ieee1394/ieee1394_types.h: In function `memcpy_le32':
drivers/ieee1394/ieee1394_types.h:108: warning: implicit declaration of function `memcpy'
In file included from drivers/ieee1394/highlevel.c:14:
drivers/ieee1394/ieee1394_types.h: In function `memcpy_le32':
drivers/ieee1394/ieee1394_types.h:108: warning: implicit declaration of function `memcpy'
drivers/ieee1394/sbp2.c: In function `sbp2scsi_complete_command':
drivers/ieee1394/sbp2.c:2838: warning: passing arg 1 of `_raw_spin_lock' from incompatible pointer type
drivers/ieee1394/sbp2.c:2840: warning: passing arg 1 of `_raw_spin_unlock' from incompatible pointer type
drivers/ieee1394/dv1394.c: In function `dv1394_open':
drivers/ieee1394/dv1394.c:2106: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
drivers/ieee1394/dv1394.c: In function `dv1394_release':
drivers/ieee1394/dv1394.c:2128: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/ieee1394/dv1394.c: In function `dv1394_init':
drivers/ieee1394/dv1394.c:2807: warning: passing arg 2 of `clear_bit' from incompatible pointer type

drivers/cdrom/gscd.c: In function `__do_gscd_request':
drivers/cdrom/gscd.c:293: warning: int format, pointer arg (arg 2)
In file included from drivers/cdrom/mcdx.c:81:
drivers/cdrom/mcdx.h:180:2: warning: #warning You have not edited mcdx.h
drivers/cdrom/mcdx.h:181:2: warning: #warning Perhaps irq and i/o settings are wrong.
drivers/cdrom/sonycd535.c: In function `sony535_init':
drivers/cdrom/sonycd535.c:1555: warning: implicit declaration of function `probe_irq_on'
drivers/cdrom/sonycd535.c:1561: warning: implicit declaration of function `probe_irq_off'

sound/oss/opl3sa2.c: In function `opl3sa2_pm_callback':
sound/oss/opl3sa2.c:981: warning: cast from pointer to integer of different size
sound/oss/ad1816.c:1344: warning: initialization from incompatible pointer type
sound/oss/awe_wave.c:4792: warning: initialization from incompatible pointer type
sound/oss/cmpci.c: In function `cm_release_mixdev':
sound/oss/cmpci.c:1457: warning: unused variable `s'
sound/oss/rme96xx.c: In function `rme96xx_release':
sound/oss/rme96xx.c:1220: warning: unused variable `hwp'
sound/oss/emu10k1/efxmgr.c: In function `emu10k1_find_control_gpr':
sound/oss/emu10k1/efxmgr.c:67: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
sound/oss/emu10k1/efxmgr.c:67: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
sound/oss/emu10k1/main.c: In function `fx_init':
sound/oss/emu10k1/main.c:473: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/oss/emu10k1/main.c:474: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/oss/emu10k1/main.c:475: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/oss/emu10k1/main.c:  and on and on and on ...
sound/oss/cs4281/cs4281m.c:4479: warning: initialization from incompatible pointer type
sound/oss/cs4281/cs4281m.c:4480: warning: initialization from incompatible pointer type

sound/core/pcm_native.c: In function `snd_pcm_playback_drain':
sound/core/pcm_native.c:1047: warning: enumeration value `SNDRV_PCM_STATE_LAST' not handled in switch
sound/core/pcm_native.c: In function `snd_pcm_playback_drop':
sound/core/pcm_native.c:1149: warning: enumeration value `SNDRV_PCM_STATE_LAST' not handled in switch
sound/core/pcm_native.c: In function `snd_pcm_capture_drain':
sound/core/pcm_native.c:1202: warning: enumeration value `SNDRV_PCM_STATE_LAST' not handled in switch
sound/core/pcm_native.c: In function `snd_pcm_capture_drop':
sound/core/pcm_native.c:1244: warning: enumeration value `SNDRV_PCM_STATE_LAST' not handled in switch
sound/core/seq/seq_clientmgr.c: In function `get_event_dest_client':
sound/core/seq/seq_clientmgr.c:472: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
sound/core/seq/seq_queue.c: In function `snd_seq_queue_use':
sound/core/seq/seq_queue.c:547: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
sound/core/seq/seq_queue.c:550: warning: passing arg 2 of `test_and_clear_bit' from incompatible pointer type
sound/core/seq/seq_queue.c: In function `snd_seq_queue_is_used':
sound/core/seq/seq_queue.c:578: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
sound/core/seq/seq_queue.c: In function `snd_seq_queue_client_leave':
sound/core/seq/seq_queue.c:632: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
sound/core/seq/seq_queue.c: In function `snd_seq_queue_remove_cells':
sound/core/seq/seq_queue.c:669: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type

sound/isa/wavefront/wavefront_synth.c:329:9: warning: pasting "(" and ""read timeout.\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:343:9: warning: pasting "(" and ""write timeout.\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:374:9: warning: pasting "(" and ""0x%x [%s] (%d,%d,%d)\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:379:17: warning: pasting "(" and ""cannot request "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:386:17: warning: pasting "(" and ""writing %d bytes "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:392:33: warning: pasting "(" and ""bad write for byte "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:398:25: warning: pasting "(" and ""write[%d] = 0x%x\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:404:17: warning: pasting "(" and ""reading %d ints "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:411:33: warning: pasting "(" and ""bad read for byte "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:421:41: warning: pasting "(" and ""bad read for "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:449:41: warning: pasting "(" and ""error %d (%s) "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:466:25: warning: pasting "(" and ""read[%d] = 0x%x\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:472:17: warning: pasting "(" and ""reading ACK for 0x%x\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:484:33: warning: pasting "(" and ""cannot read ack for "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:495:49: warning: pasting "(" and ""cannot read err "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:502:33: warning: pasting "(" and ""0x%x [%s] "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:511:17: warning: pasting "(" and ""ack received "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:516:17: warning: pasting "(" and ""0x%x [%s] does not need "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:799:9: warning: pasting "(" and ""downloading patch %d\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:823:9: warning: pasting "(" and ""downloading program %d\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:898:9: warning: pasting "(" and ""sample %sdownload for slot %d, "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1003:9: warning: pasting "(" and ""channel selection: %d => "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1178:9: warning: pasting "(" and ""download alias, %d is "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1223:9: warning: pasting "(" and ""multi %d with %d=%d samples\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1229:17: warning: pasting "(" and ""sample[%d] = %d\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1268:9: warning: pasting "(" and ""msample %d has %d samples\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1298:17: warning: pasting "(" and ""msample sample[%d] = %d\n"" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1314:9: warning: pasting "(" and ""downloading edrum for MIDI "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1376:9: warning: pasting "(" and ""download "" does not give a valid preprocessing token
sound/isa/wavefront/wavefront_synth.c:1491:9: warning: pasting "(" and ""synth control with "" does not give a valid preprocessing token

sound/pci/ac97/ac97_codec.c: In function `snd_ac97_write_cache':
sound/pci/ac97/ac97_codec.c:263: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/pci/ac97/ac97_codec.c: In function `snd_ac97_resume':
sound/pci/ac97/ac97_codec.c:2166: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type

sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_write_op':
sound/pci/emu10k1/emufx.c:796: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_audigy_write_op':
sound/pci/emu10k1/emufx.c:808: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_gpr_poke':
sound/pci/emu10k1/emufx.c:833: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_gpr_peek':
sound/pci/emu10k1/emufx.c:844: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_tram_poke':
sound/pci/emu10k1/emufx.c:854: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_tram_peek':
sound/pci/emu10k1/emufx.c:866: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_code_poke':
sound/pci/emu10k1/emufx.c:877: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_code_peek':
sound/pci/emu10k1/emufx.c:889: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `_snd_emu10k1_audigy_init_efx':
sound/pci/emu10k1/emufx.c:1217: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c: In function `_snd_emu10k1_init_efx':
sound/pci/emu10k1/emufx.c:1469: warning: passing arg 2 of `set_bit' from incompatible pointer type
sound/pci/emu10k1/emufx.c:1473: warning: passing arg 2 of `set_bit' from incompatible pointer type

drivers/mtd/devices/doc1000.c:86:2: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.

drivers/video/radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:598: warning: `radeon_read_OF' declared `static' but never defined
drivers/video/radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but not used
drivers/video/sis/init.c: In function `SiS_SetVCLKState':
drivers/video/sis/init.c:2772: warning: comparison is always true due to limited range of data type
drivers/video/sis/init301.c: In function `SiS_GetCRT2Data301':
drivers/video/sis/init301.c:2065: warning: `tempax' might be used uninitialized in this function
drivers/video/sis/init301.c:2065: warning: `tempbx' might be used uninitialized in this function
drivers/video/sis/init301.c: In function `GetRevisionID':
drivers/video/sis/init301.c:5704: warning: control reaches end of non-void function

drivers/block/paride/pd.c: In function `pd_init':
drivers/block/paride/pd.c:385: warning: unused variable `i'
drivers/block/paride/pcd.c: In function `pcd_init':
drivers/block/paride/pcd.c:333: warning: unused variable `i'
drivers/block/paride/pg.c: In function `pg_init_units':
drivers/block/paride/pg.c:279: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/block/paride/pg.c: In function `pg_open':
drivers/block/paride/pg.c:577: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
drivers/block/paride/pg.c:591: warning: passing arg 2 of `clear_bit' from incompatible pointer type
drivers/block/paride/pg.c: In function `pg_release':
drivers/block/paride/pg.c:603: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/block/paride/pg.c:606: warning: passing arg 2 of `clear_bit' from incompatible pointer type

drivers/usb/media/vicamurbs.h:21: warning: `s128x98bw' defined but not used
drivers/usb/net/cdc-ether.c:415: warning: `CDC_SetEthernetPacketFilter' defined but not used

drivers/input/joystick/adi.c: In function `adi_init_input':
drivers/input/joystick/adi.c:429: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/input/joystick/adi.c:432: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/input/joystick/analog.c: In function `analog_cooked_read':
drivers/input/joystick/analog.c:239: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/input/joystick/analog.c:239: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
drivers/input/joystick/analog.c: and on and on and on ....
drivers/input/joystick/iforce.c: In function `iforce_upload_interactive':
drivers/input/joystick/iforce.c:718: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/input/joystick/iforce.c:719: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
drivers/input/joystick/iforce.c:720: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
drivers/input/joystick/magellan.c: In function `magellan_connect':
drivers/input/joystick/magellan.c:159: warning: passing arg 2 of `set_bit' from incompatible pointer type

drivers/isdn/capi/capi.c:1306: warning: `capinc_tty_break_ctl' defined but not used
drivers/isdn/capi/capi.c:1327: warning: `capinc_tty_send_xchar' defined but not used
drivers/isdn/capi/capi.c:1335: warning: `capinc_tty_read_proc' defined but not used

net/sched/sch_atm.c: In function `atm_tc_dump_class':
net/sched/sch_atm.c:646: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type

net/ipv4/ip_gre.c:123: warning: initialization makes integer from pointer without a cast

net/irda/irlmp.c: In function `irlmp_connect_request':
net/irda/irlmp.c:361: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/irda/irlmp.c:450: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/irda/irlmp.c: In function `irlmp_connect_response':
net/irda/irlmp.c:517: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/irda/irlmp.c: In function `irlmp_disconnect_request':
net/irda/irlmp.c:629: warning: passing arg 2 of `test_and_clear_bit' from incompatible pointer type
net/irda/irlmp.c: In function `irlmp_disconnect_indication':
net/irda/irlmp.c:688: warning: passing arg 2 of `test_and_clear_bit' from incompatible pointer type
net/irda/irttp.c: In function `irttp_todo_expired':
net/irda/irttp.c:175: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
net/irda/irttp.c:179: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/irda/irttp.c: In function `irttp_close_tsap':
net/irda/irttp.c:499: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
net/irda/irttp.c: In function `irttp_disconnect_request':
net/irda/irttp.c:1429: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
net/irda/irttp.c:1488: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/irda/irnet/irnet_ppp.c: In function `ppp_irnet_send':
net/irda/irnet/irnet_ppp.c:853: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
net/irda/irnet/irnet_ppp.c:887: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
net/irda/irnet/irnet_irda.c: In function `irnet_connect_tsap':
net/irda/irnet/irnet_irda.c:275: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/irda/irnet/irnet_irda.c:286: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/irda/irnet/irnet_irda.c: more of the same

net/atm/pvc.c: In function `pvc_bind':
net/atm/pvc.c:46: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/pvc.c:47: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/pvc.c: In function `pvc_getname':
net/atm/pvc.c:69: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/signaling.c: In function `modify_qos':
net/atm/signaling.c:73: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/signaling.c:74: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/signaling.c: In function `sigd_send':
net/atm/signaling.c:125: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/signaling.c:126: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/signaling.c:145: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/signaling.c:146: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/signaling.c: In function `sigd_enq2':
net/atm/signaling.c:185: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/signaling.c: In function `purge_vccs':
net/atm/signaling.c:202: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/signaling.c:203: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/signaling.c: In function `sigd_attach':
net/atm/signaling.c:254: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/signaling.c:255: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/svc.c: In function `svc_disconnect':
net/atm/svc.c:67: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:70: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:83: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c:84: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c:85: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c: In function `svc_release':
net/atm/svc.c:97: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c: In function `svc_bind':
net/atm/svc.c:119: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:122: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c:125: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:135: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c:137: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/svc.c: In function `svc_connect':
net/atm/svc.c:162: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:165: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:203: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:208: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c:209: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c:210: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/svc.c: In function `svc_listen':
net/atm/svc.c:245: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:255: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/svc.c: In function `svc_accept':
net/atm/svc.c:281: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:282: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c:302: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/svc.c: In function `svc_change_qos':
net/atm/svc.c:353: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/svc.c: In function `svc_setsockopt':
net/atm/svc.c:374: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/common.c: In function `atm_release_vcc_sk':
net/atm/common.c:139: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/common.c: In function `atm_async_release_vcc':
net/atm/common.c:175: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/common.c: In function `atm_connect_vcc':
net/atm/common.c:288: warning: passing arg 2 of `clear_bit' from incompatible pointer type
net/atm/common.c:289: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/common.c: etc.
net/atm/atm_misc.c: In function `check_ci':
net/atm/atm_misc.c:51: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/resources.c: In function `shutdown_atm_dev':
net/atm/resources.c:153: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/resources.c: In function `unlink_vcc':
net/atm/resources.c:199: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/clip.c: In function `atm_init_atmarp':
net/atm/clip.c:732: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/clip.c:733: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/proc.c: In function `vcc_state':
net/atm/proc.c:201: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/lec.c: In function `lec_send_packet':
net/atm/lec.c:316: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
net/atm/lec.c: In function `lecd_attach':
net/atm/lec.c:807: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/lec.c:808: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/mpc.c: In function `atm_mpoa_mpoad_attach':
net/atm/mpc.c:795: warning: passing arg 2 of `set_bit' from incompatible pointer type
net/atm/mpc.c:796: warning: passing arg 2 of `set_bit' from incompatible pointer type

drivers/net/wan/dscc4.c:1832: warning: `dscc4_setup' defined but not used

