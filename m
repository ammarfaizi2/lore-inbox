Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270158AbSISGsb>; Thu, 19 Sep 2002 02:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270163AbSISGsb>; Thu, 19 Sep 2002 02:48:31 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:8374 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S270158AbSISGs3>;
	Thu, 19 Sep 2002 02:48:29 -0400
Date: Thu, 19 Sep 2002 09:49:38 +0300
From: Dan Aloni <da-x@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.x - Compilation breakage status
Message-ID: <20020919064938.GA14711@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a nightly full kernel build (using 'make allmodconfig'),
I've run the build with 'make -k' (continue on errors) twice, 
and from the output of the second run, made a list of the 
current compilation breakage in the kernel source tree. 
The version of the kernel I used was the latest BitKeeper 
version (2.5.36+).

The full gcc error output was too big to include here, so I've
attached only the last output line (which in most cases won't
give out the problem itself, but will give a slight clue of 
why the file does't compile).

File                                    Last gcc output line
---------------------------------------------------------------------------------
fs/intermezzo/vfs.c                     1935: parse error before string constant
fs/intermezzo/psdev.c                   1223: parse error before `return'
fs/intermezzo/dir.c                     708: structure has no member named `i_zombie'
fs/intermezzo/super.c                   459: warning: initialization from incompatible pointer type
fs/jffs/intrep.c                        3382: too few arguments to function `dequeue_signal_Rsmp_37902d9c'
fs/jffs2/background.c                   118: too few arguments to function `dequeue_signal_Rsmp_37902d9c'
drivers/atm/eni.c                       705: incompatible types in assignment
drivers/atm/nicstar.c                   2557: incompatible types in assignment
drivers/atm/idt77252.c                  1340: incompatible types in assignment
drivers/atm/horizon.c                   2864: warning: passing arg 2 of `set_bit' from incompatible pointer type
drivers/atm/ambassador.c                1473: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
drivers/atm/atmtcp.c                    324: warning: (near initialization for `atmtcp_control_dev.flags')
drivers/atm/firestream.c                2114: parse error before string constant
drivers/atm/lanai.c                     1609: incompatible types in assignment
drivers/atm/fore200e.c                  1137: incompatible types in assignment
drivers/block/DAC960.c                  5385: warning: `ErrorCode' might be used uninitialized in this function
drivers/block/nbd.c                     62: too few arguments to function `bio_endio_Rsmp_0f3ec337'
drivers/char/rio/sx.c                   2639: parse error before string constant
drivers/char/rio/generic_serial.c       950: warning: `flags' might be used uninitialized in this function
drivers/ide/legacy/hd.c                 694: `hd_gendisk' used prior to declaration
drivers/ide/legacy/pdc4030.c            741: warning: unreachable code at beginning of switch statement
drivers/ide/pci/trm290.c                239: too many arguments to function `ide_build_dmatable_Rsmp_f49fb90e'
drivers/ide/ppc/ide-probe.c             1120: warning: implicit declaration of function `ide_unregister_Rsmp_0c486b72'
drivers/ide/ppc/ide.c                   10435: Error: symbol `init_module' is already defined
drivers/isdn/hisax/st5481_init.c        118: warning: return makes integer from pointer without a cast
drivers/md/linear.c                     157: parse error before `)'
drivers/md/raid0.c                      326: parse error before `)'
drivers/md/raid1.c                      1041: warning: assignment from incompatible pointer type
drivers/md/raid5.c                      1261: too few arguments to function
drivers/md/multipath.c                  179: warning: assignment from incompatible pointer type
drivers/md/md.c                         388: warning: assignment from incompatible pointer type
drivers/md/lvm.c                        2658: for each function it appears in.)
drivers/md/lvm-snap.c                   655: incompatible type for argument 1 of `block_size'
drivers/media/video/zr36120.c           2047: warning: implicit declaration of function `i2c_unregister_bus'
drivers/media/video/zr36120_i2c.c       133: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36120_mem.c       101: field `i2c' has incomplete type
drivers/media/video/saa7111.c           444: warning: implicit declaration of function `i2c_unregister_driver'
drivers/media/video/saa7185.c           401: warning: implicit declaration of function `i2c_unregister_driver'
drivers/media/video/adv7175.c           470: warning: implicit declaration of function `i2c_unregister_driver'
drivers/media/video/bt819.c             168: warning: `bt819_attach' defined but not used
drivers/media/video/bt856.c             106: warning: `bt856_attach' defined but not used
drivers/media/video/zr36067.c           4751: warning: implicit declaration of function `i2c_register_bus'
drivers/media/video/stradis.c           245: warning: `detach_inform' defined but not used
drivers/media/video/cpia.c              1924: parse error before string constant
drivers/media/video/cpia_pp.c           695: parse error before string constant
drivers/media/video/cpia_usb.c          544: parse error before string constant
drivers/message/i2o/i2o_block.c         1775: warning: passing arg 1 of `sprintf_Rsmp_1d26aa98' discards qualifiers from pointer target type
drivers/message/i2o/i2o_lan.c           28: #error Please convert me to Documentation/DMA-mapping.txt
drivers/message/i2o/i2o_scsi.c          737: structure has no member named `address'
drivers/mtd/nand/mtdblock.c             407: parse error before string constant
drivers/mtd/nand/mtdblock_ro.c          272: too few arguments to function `blk_init_queue_Rsmp_9b1e0c08'
drivers/mtd/nand/ftl.c                  184: warning: `ftl_reread_partitions' declared `static' but never defined
drivers/mtd/nand/nftlcore.c             943: `nftl_fops' used prior to declaration
drivers/net/fc/iph5526.c                4399: structure has no member named `address'
drivers/net/irda/irtty.c                958: warning: `flags' might be used uninitialized in this function
drivers/net/irda/irport.c               943: warning: `flags' might be used uninitialized in this function
drivers/net/irda/irda-usb.c             1635: parse error before string constant
drivers/net/irda/nsc-ircc.c             1952: warning: `flags' might be used uninitialized in this function
drivers/net/irda/w83977af_ir.c          1326: warning: `flags' might be used uninitialized in this function
drivers/net/irda/toshoboe.c             909: warning: `flags' might be used uninitialized in this function
drivers/net/irda/smc-ircc.c             1215: parse error before string constant
drivers/net/irda/ali-ircc.c             78: warning: `dongle_types' defined but not used
drivers/net/irda/tekram.c               258: parse error before string constant
drivers/net/irda/actisys.c              262: parse error before string constant
drivers/net/irda/girbil.c               224: parse error before string constant
drivers/net/irda/mcp2120.c              215: parse error before string constant
drivers/net/irda/act200l.c              272: parse error before string constant
drivers/net/irda/ma600.c                329: parse error before string constant
drivers/net/pcmcia/aironet4500_cs.c     350: warning: `flags' might be used uninitialized in this function
drivers/net/wan/cycx_x25.c              1449: parse error before string constant
drivers/net/wan/cycx_drv.c              440: parse error before string constant
drivers/net/wireless/rrunner.c          24: #error Please convert me to Documentation/DMA-mapping.txt
drivers/net/wireless/rcpci45.c          47: #error Please convert me to Documentation/DMA-mapping.txt
drivers/net/wireless/acenic.c           2880: too few arguments to function `synchronize_irq_Rsmp_e523ad75'
drivers/net/wireless/defxx.c            7: warning: this is the location of the previous definition
drivers/scsi/ini9100u.c                 503: structure has no member named `address'
drivers/scsi/pci2000.c                  531: structure has no member named `address'
drivers/scsi/pci2220i.c                 2053: structure has no member named `address'
drivers/scsi/dpt_i2o.c                  2141: structure has no member named `address'
drivers/scsi/aha1740.c                  311: warning: `flags' might be used uninitialized in this function
drivers/scsi/fd_mcs.c                   1317: warning: `flags' might be used uninitialized in this function
drivers/scsi/fdomain.c                  1812: warning: `flags' might be used uninitialized in this function
drivers/scsi/in2000.c                   2200: warning: `flags' might be used uninitialized in this function
drivers/scsi/g_NCR5380.c                265: warning: `do_DTC3181E_setup' defined but not used
drivers/scsi/NCR53c406a.c               928: structure has no member named `address'
drivers/scsi/sym53c416.c                640: warning: `flags' might be used uninitialized in this function
drivers/scsi/pas16.c                    403: warning: `NCR5380_print' defined but not used
drivers/scsi/seagate.c                  758: warning: `flags' might be used uninitialized in this function
drivers/scsi/t128.c                     403: warning: `NCR5380_print' defined but not used
drivers/scsi/dmx3191d.c                 685: warning: `NCR5380_probe_irq' defined but not used
drivers/scsi/dtc.c                      403: warning: `NCR5380_print' defined but not used
drivers/scsi/53c7,8xx.c                 6340: warning: `flags' might be used uninitialized in this function
drivers/scsi/eata_dma.c                 989: warning: `flags' might be used uninitialized in this function
drivers/scsi/eata_pio.c                 456: warning: `flags' might be used uninitialized in this function
drivers/scsi/wd7000.c                   1746: parse error before string constant
drivers/scsi/ibmmca.c                   1445: request for member `host_lock' in something not a structure or union
drivers/scsi/tmscsim.c                  2815: request for member `pScsiHost' in something not a structure or union
drivers/scsi/AM53C974.c                 2390: warning: `flags' might be used uninitialized in this function
drivers/scsi/gdth.c                     3346: `dev' undeclared (first use in this function)
drivers/scsi/pcmcia/nsp_cs.c            1031: parse error before string constant
drivers/serial/8250.c                   1908: dereferencing pointer to incomplete type
drivers/telephony/ixj.c                 6756: invalid operands to binary &
drivers/video/pm2fb.c                   2284: warning: implicit declaration of function `fbgen_install_cmap'
drivers/video/pm3fb.c                   3822: warning: passing arg 2 of `__release_region_Rsmp_d49501d4' makes integer from pointer without a cast
drivers/video/aty128fb.c                1384: structure has no member named `line_length'
drivers/video/radeonfb.c                1710: warning: `radeonfb_set_cmap' defined but not used
drivers/video/cyber2000fb.c             933: structure has no member named `ywrapstep'
drivers/video/clgenfb.c                 2818: warning: implicit declaration of function `fbgen_set_disp'
drivers/video/tridentfb.c               1296: (near initialization for `tridentfb_ops')
drivers/video/vga16fb.c                 815: warning: initialization from incompatible pointer type
drivers/video/hgafb.c                   670: structure has no member named `line_length'
drivers/video/sstfb.c                   1877: structure has no member named `blank'
drivers/video/aty/atyfb_base.c          2701: structure has no member named `cursor'
drivers/video/riva/fbdev.c              1749: warning: initialization from incompatible pointer type
drivers/video/riva/accel.c              358: structure has no member named `line_length'
drivers/video/sis/sis_main.c            275: warning: `currcon' defined but not used
drivers/video/sis/init.c                3345: `SIS_650' undeclared (first use in this function)
drivers/video/sis/init301.c             2091: `SIS_650' undeclared (first use in this function)
sound/oss/v_midi.c                      244: structure has no member named `lock'
sound/oss/cs4281/cs4281m.c              4483: warning: initialization from incompatible pointer type
net/bridge/netfilter/ebtables.c         1483: warning: data definition has no type or storage class
net/bridge/netfilter/ebtable_filter.c   88: warning: data definition has no type or storage class
net/bridge/netfilter/ebtable_nat.c      94: warning: data definition has no type or storage class
net/bridge/netfilter/ebtable_broute.c   77: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_ip.c           71: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_arp.c          100: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_vlan.c         316: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_mark_m.c       59: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_log.c          98: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_snat.c         62: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_dnat.c         63: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_redirect.c     69: warning: data definition has no type or storage class
net/bridge/netfilter/ebt_mark.c         64: warning: data definition has no type or storage class
net/irda/iriap.c                        45: warning: `ias_charset_types' defined but not used
net/irda/iriap_event.c                  493: parse error before string constant
net/irda/irlmp.c                        1735: warning: `flags' might be used uninitialized in this function
net/irda/irlmp_event.c                  53: warning: `irlmp_event' defined but not used
net/irda/irlmp_frame.c                  394: parse error before string constant
net/irda/irlap.c                        63: warning: `lap_reasons' defined but not used
net/irda/irlap_event.c                  82: warning: `irlap_event' defined but not used
net/irda/irlap_frame.c                  1299: parse error before string constant
net/irda/qos.c                          720: parse error before string constant
net/irda/irqueue.c                      579: warning: `flags' might be used uninitialized in this function
net/irda/irttp.c                        1719: warning: `flags' might be used uninitialized in this function
net/irda/irda_device.c                  71: warning: `task_state' defined but not used
net/irda/irias_object.c                 532: parse error before string constant
net/irda/wrapper.c                      368: parse error before string constant
net/irda/af_irda.c                      2392: parse error before string constant
net/irda/discovery.c                    147: parse error before string constant
net/irda/parameters.c                   515: parse error before string constant
net/irda/irsyms.c                       254: parse error before string constant
net/irda/ircomm/ircomm_tty.c            1240: parse error before string constant
net/irda/ircomm/ircomm_tty_attach.c     941: parse error before string constant
net/irda/ircomm/ircomm_tty_ioctl.c      428: parse error before string constant
net/irda/ircomm/ircomm_param.c          486: parse error before string constant
net/irda/ircomm/ircomm_core.c           506: warning: `flags' might be used uninitialized in this function
net/irda/ircomm/ircomm_event.c          255: parse error before string constant
net/irda/ircomm/ircomm_lmp.c            333: parse error before string constant
net/irda/ircomm/ircomm_ttp.c            295: parse error before string constant
net/irda/irlan/irlan_common.c           1089: warning: `flags' might be used uninitialized in this function
net/irda/irlan/irlan_eth.c              389: parse error before string constant
net/irda/irlan/irlan_event.c            53: parse error before string constant
net/irda/irlan/irlan_client.c           560: parse error before string constant
net/irda/irlan/irlan_provider.c         403: parse error before string constant
net/irda/irlan/irlan_filter.c           159: parse error before string constant
net/irda/irlan/irlan_provider_event.c   224: parse error before string constant
net/irda/irlan/irlan_client_event.c     514: parse error before string constant
net/irda/irnet/irnet_ppp.c              1069: parse error before string constant
net/irda/irnet/irnet_irda.c             1866: parse error before string constant

-- 
Dan Aloni
da-x@gmx.net
