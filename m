Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTFOPva (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTFOPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:51:30 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:52621 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262319AbTFOPuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:50:09 -0400
From: Markus_Preis@t-online.de (Markus Preis)
Reply-To: Markus_Preis@t-online.de
To: linux-kernel@vger.kernel.org
Subject: kernel oops while sending fax with c2faxsend in drivers/isdn/avmb1/kcapi.c
Date: Sun, 15 Jun 2003 18:03:34 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WjJ7+Iw98lmJuU+"
Message-Id: <200306151803.37427.markus_preis@t-online.de>
X-Seen: false
X-ID: S3MyjEZloeKSsGSjOTu34f1Rz08cNsfABrevi2K8f2akfuBeQBuGQh
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WjJ7+Iw98lmJuU+
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

Hello,

since kernel 2.4.20 i've got kernel oops in kcapi.c.

I've wrote some eMail's to Carsten Paeth <calle@calle.in-berlin.de> and=20
Karsten Keil <kkeil@suse.de> and they have send me an patch witch solve the=
=20
problem.
I hope you can work whis that patch and include it in the next kernelreleas.

Markus



--Boundary-00=_WjJ7+Iw98lmJuU+
Content-Type: text/plain;
  charset="iso-8859-15";
  name="ksymoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ksymoops.txt"

ksymoops 2.4.8 on i686 2.4.21-pre7.  Options used
     -V (default)
     -k /tmp/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre7/ (default)
     -m /usr/src/linux/System.map (default)

Warning: kfree_skb passed an skb still on a list (from d88aff73).
kernel BUG at skbuff.c:315!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0212924>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000045   ebx: d7d463b8   ecx: 00000001   edx: d79bc000
esi: d7d463b8   edi: 00000080   ebp: 00000046   esp: c02ddef0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02dd000)
Stack: c028bb80 d88aff73 d7d463b8 00000002 d88aff73 d7d463b8 00000002 c0120afd 
       c02ddf24 c02ddf24 fffffffe c011d64a 00000000 d88b6844 d88b6844 00000000 
       c02f6b60 c012064d c029fae0 c011d582 c011d496 00000009 00000001 c011d2d5 
Call Trace:    [<d88aff73>] [<d88aff73>] [<c0120afd>] [<c011d64a>] [<d88b6844>]
  [<d88b6844>] [<c012064d>] [<c011d582>] [<c011d496>] [<c011d2d5>] [<c0108b1e>]
  [<c010b1b8>] [<c0105383>] [<c0113055>] [<c0112fa0>] [<c0112fa0>] [<c0105412>]
  [<c0105000>]
Code: 0f 0b 3b 01 c7 ad 28 c0 8b 5c 24 14 e9 ce fe ff ff 8d 74 26 


>>EIP; c0212924 <__kfree_skb+134/150>   <=====

>>ebx; d7d463b8 <_end+17a20180/18562e28>
>>edx; d79bc000 <_end+17695dc8/18562e28>
>>esi; d7d463b8 <_end+17a20180/18562e28>
>>esp; c02ddef0 <init_task_union+1ef0/2000>

Trace; d88aff73 <[kernelcapi]recv_handler+1e3/240>
Trace; d88aff73 <[kernelcapi]recv_handler+1e3/240>
Trace; c0120afd <update_process_times+3d/d0>
Trace; c011d64a <__run_task_queue+5a/70>
Trace; d88b6844 <[kernelcapi]tq_recv_notify+0/14>
Trace; d88b6844 <[kernelcapi]tq_recv_notify+0/14>
Trace; c012064d <immediate_bh+1d/20>
Trace; c011d582 <bh_action+22/40>
Trace; c011d496 <tasklet_hi_action+46/70>
Trace; c011d2d5 <do_softirq+95/a0>
Trace; c0108b1e <do_IRQ+be/f0>
Trace; c010b1b8 <call_do_IRQ+5/d>
Trace; c0105383 <default_idle+23/40>
Trace; c0113055 <apm_cpu_idle+b5/150>
Trace; c0112fa0 <apm_cpu_idle+0/150>
Trace; c0112fa0 <apm_cpu_idle+0/150>
Trace; c0105412 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

Code;  c0212924 <__kfree_skb+134/150>
00000000 <_EIP>:
Code;  c0212924 <__kfree_skb+134/150>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0212926 <__kfree_skb+136/150>
   2:   3b 01                     cmp    (%ecx),%eax
Code;  c0212928 <__kfree_skb+138/150>
   4:   c7 ad 28 c0 8b 5c 24      movl   $0xcee91424,0x5c8bc028(%ebp)
Code;  c021292f <__kfree_skb+13f/150>
   b:   14 e9 ce 
Code;  c0212932 <__kfree_skb+142/150>
   e:   fe                        (bad)  
Code;  c0212933 <__kfree_skb+143/150>
   f:   ff                        (bad)  
Code;  c0212934 <__kfree_skb+144/150>
  10:   ff 8d 74 26 00 00         decl   0x2674(%ebp)

 <0>Kernel panic: Aiee, killing interrupt handler!

--Boundary-00=_WjJ7+Iw98lmJuU+
Content-Type: text/plain;
  charset="iso-8859-15";
  name="ksyms"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ksyms"

d8908e40 __insmod_b1isa_S.data_L280	[b1isa]
d8908060 __insmod_b1isa_S.text_L2634	[b1isa]
d8908f58 __insmod_b1isa_S.bss_L4	[b1isa]
d8908d08 __insmod_b1isa_S.rodata_L20	[b1isa]
d8908000 __insmod_b1isa_O/lib/modules/2.4.21-pre7/kernel/drivers/isdn/avmb1/b1isa.o_M3EB9426E_V132117	[b1isa]
d8906660 b1_irq_table_R85f09690	[b1]
d89021a0 b1_detect_Rdfd28376	[b1]
d8902610 b1_getrevision_Rd123cc35	[b1]
d8902630 b1_load_t4file_R8661a4b7	[b1]
d8902870 b1_load_config_R5247a277	[b1]
d8902c30 b1_loaded_Rb7f2a956	[b1]
d8902d70 b1_load_firmware_R0b203520	[b1]
d8903180 b1_reset_ctr_Rc918ba15	[b1]
d89032f0 b1_register_appl_Rdbdcf022	[b1]
d89036f0 b1_release_appl_R7e9d3be3	[b1]
d89037c0 b1_send_message_R64ea3504	[b1]
d8903b70 b1_parse_version_Rc8a47df1	[b1]
d8903ea0 b1_handle_interrupt_Rfadb1bf4	[b1]
d89056b0 b1ctl_read_proc_R4d67ebd3	[b1]
d8902000 __insmod_b1_O/lib/modules/2.4.21-pre7/kernel/drivers/isdn/avmb1/b1.o_M3EB9426E_V132117	[b1]
d8902060 __insmod_b1_S.text_L15595	[b1]
d8906280 __insmod_b1_S.rodata_L208	[b1]
d8906640 __insmod_b1_S.data_L96	[b1]
d88fa060 __insmod_capidrv_S.text_L17770	[capidrv]
d8900260 __insmod_capidrv_S.bss_L1588	[capidrv]
d88fe720 __insmod_capidrv_S.rodata_L600	[capidrv]
d88ffdc0 __insmod_capidrv_S.data_L1164	[capidrv]
d88fa000 __insmod_capidrv_O/lib/modules/2.4.21-pre7/kernel/drivers/isdn/avmb1/capidrv.o_M3EB9426E_V132117	[capidrv]
d88d18c0 isdn_register_divert_Rb7757abb	[isdn]
d88d1950 register_isdn_R8694f31b	[isdn]
d88d6bd0 isdn_ppp_register_compressor_R15b5df5b	[isdn]
d88d6c00 isdn_ppp_unregister_compressor_R5cf721ef	[isdn]
d88c1000 __insmod_isdn_O/lib/modules/2.4.21-pre7/kernel/drivers/isdn/isdn.o_M3EB9426D_V132117	[isdn]
d88c1060 __insmod_isdn_S.text_L101935	[isdn]
d88da0d0 __insmod_isdn_S.rodata_L2508	[isdn]
d88ded00 __insmod_isdn_S.data_L3584	[isdn]
d88dfb00 __insmod_isdn_S.bss_L2336	[isdn]
d88be060 slhc_init_R2e0e927f	[slhc]
d88be1f0 slhc_free_R2894cfb0	[slhc]
d88bed30 slhc_remember_R0bc55868	[slhc]
d88be2e0 slhc_compress_R76135e6c	[slhc]
d88be920 slhc_uncompress_R3bc1319e	[slhc]
d88beef0 slhc_toss_Rf89e3455	[slhc]
d88be000 __insmod_slhc_O/lib/modules/2.4.21-pre7/kernel/drivers/net/slhc.o_M3EB94270_V132117	[slhc]
d88be060 __insmod_slhc_S.text_L4378	[slhc]
d88bf17c __insmod_slhc_S.rodata_L168	[slhc]
d88bb808 capi_rawmajor	[capi]
d88bb940 __insmod_capi_S.bss_L3296	[capi]
d88b8060 __insmod_capi_S.text_L12443	[capi]
d88bb800 __insmod_capi_S.data_L316	[capi]
d88bb804 capi_major	[capi]
d88bb80c capi_ttymajor	[capi]
d88bb610 __insmod_capi_S.rodata_L20	[capi]
d88b8000 __insmod_capi_O/lib/modules/2.4.21-pre7/kernel/drivers/isdn/avmb1/capi.o_M3EB9426E_V132117	[capi]
d88b1840 attach_capi_interface_R5448a06e	[kernelcapi]
d88b18b0 detach_capi_interface_R83c71232	[kernelcapi]
d88b0800 attach_capi_driver_Rafd512d0	[kernelcapi]
d88b08b0 detach_capi_driver_R05715665	[kernelcapi]
d88af000 __insmod_kernelcapi_O/lib/modules/2.4.21-pre7/kernel/drivers/isdn/avmb1/kernelcapi.o_M3EB9426E_V132117	[kernelcapi]
d88af060 __insmod_kernelcapi_S.text_L12039	[kernelcapi]
d88b2010 __insmod_kernelcapi_S.rodata_L132	[kernelcapi]
d88b2de0 __insmod_kernelcapi_S.data_L364	[kernelcapi]
d88b2f60 __insmod_kernelcapi_S.bss_L14592	[kernelcapi]
d88a8b90 capi_cmsg2message_R50b33ca4	[capiutil]
d88a8e10 capi_message2cmsg_R6057c6f3	[capiutil]
d88a8ec0 capi_cmsg_header_Rb60e5e5f	[capiutil]
d88a8f40 capi_cmd2str_Rb19fda8d	[capiutil]
d88a9430 capi_cmsg2str_Rd45b5eb5	[capiutil]
d88a9370 capi_message2str_Ra7abc5e3	[capiutil]
d88a8060 capi_info2str_R47d3fc51	[capiutil]
d88a8000 __insmod_capiutil_O/lib/modules/2.4.21-pre7/kernel/drivers/isdn/avmb1/capiutil.o_M3EB9426E_V132117	[capiutil]
d88a8060 __insmod_capiutil_S.text_L5690	[capiutil]
d88ab210 __insmod_capiutil_S.rodata_L176	[capiutil]
d88ab4c0 __insmod_capiutil_S.data_L1220	[capiutil]
d88ab9a0 __insmod_capiutil_S.bss_L8192	[capiutil]
d88a68b0 capifs_new_ncci_R598f271d	[capifs]
d88a69c0 capifs_free_ncci_R98e7f4b7	[capifs]
d88a6000 __insmod_capifs_O/lib/modules/2.4.21-pre7/kernel/drivers/isdn/avmb1/capifs.o_M3EB9426E_V132117	[capifs]
d88a6060 __insmod_capifs_S.text_L2986	[capifs]
d88a6e24 __insmod_capifs_S.rodata_L20	[capifs]
d88a6e40 __insmod_capifs_S.data_L364	[capifs]
d88a1920 parport_pc_probe_port_R7bf85935	[parport_pc]
d88a2050 parport_pc_unregister_port_R34f4c24e	[parport_pc]
d889f000 __insmod_parport_pc_O/lib/modules/2.4.21-pre7/kernel/drivers/parport/parport_pc.o_M3EB94271_V132117	[parport_pc]
d889f060 __insmod_parport_pc_S.text_L15662	[parport_pc]
d88a3b80 __insmod_parport_pc_S.rodata_L244	[parport_pc]
d88a3e00 __insmod_parport_pc_S.data_L3840	[parport_pc]
d88a4d00 __insmod_parport_pc_S.bss_L8	[parport_pc]
d889c000 __insmod_lp_O/lib/modules/2.4.21-pre7/kernel/drivers/char/lp.o_M3EB94269_V132117	[lp]
d889c060 __insmod_lp_S.text_L5379	[lp]
d889d704 __insmod_lp_S.rodata_L60	[lp]
d889d9e0 __insmod_lp_S.data_L276	[lp]
d889db00 __insmod_lp_S.bss_L612	[lp]
d8894ae0 parport_claim_R91004644	[parport]
d8894c90 parport_claim_or_block_Rde072c31	[parport]
d8894d00 parport_release_Re630d383	[parport]
d8894430 parport_register_port_R6a1aa91f	[parport]
d8894620 parport_announce_port_R9e4a6cda	[parport]
d88946b0 parport_unregister_port_R53435cc1	[parport]
d8894200 parport_register_driver_Re116b39b	[parport]
d88942d0 parport_unregister_driver_Rba018273	[parport]
d8894750 parport_register_device_Rf6150a17	[parport]
d8894960 parport_unregister_device_R76e8567d	[parport]
d8894410 parport_enumerate_Rb019f67c	[parport]
d88943e0 parport_get_port_Rd0bca560	[parport]
d88943f0 parport_put_port_R62c41e4b	[parport]
d8894a40 parport_find_number_Rf018fefa	[parport]
d8894a90 parport_find_base_Rbdf5fadd	[parport]
d8895530 parport_negotiate_Rce4ab4f5	[parport]
d8895930 parport_write_Rc0b58a6d	[parport]
d8895a30 parport_read_R8625c153	[parport]
d88950d0 parport_ieee1284_wakeup_R3949df97	[parport]
d8895270 parport_wait_peripheral_R0786bf50	[parport]
d88951d0 parport_poll_peripheral_R03386fcc	[parport]
d8895110 parport_wait_event_Re3049e50	[parport]
d8895b70 parport_set_timeout_Rd928bc16	[parport]
d88958f0 parport_ieee1284_interrupt_Rb3ec0c3b	[parport]
d8896170 parport_ieee1284_ecp_write_data_Rb2be757e	[parport]
d8896420 parport_ieee1284_ecp_read_data_R3e9bd2d6	[parport]
d8896700 parport_ieee1284_ecp_write_addr_Rc57b9b46	[parport]
d8895bc0 parport_ieee1284_write_compat_Rca60e714	[parport]
d8895e10 parport_ieee1284_read_nibble_R8a3a0013	[parport]
d8895fc0 parport_ieee1284_read_byte_R496f0e65	[parport]
d88969b0 parport_ieee1284_epp_write_data_R6257a65f	[parport]
d8896ad0 parport_ieee1284_epp_read_data_Race74130	[parport]
d8896bc0 parport_ieee1284_epp_write_addr_R15924867	[parport]
d8896ce0 parport_ieee1284_epp_read_addr_R485a0f16	[parport]
d8897540 parport_proc_register_Rfccf7f06	[parport]
d8897640 parport_proc_unregister_Rfc1985ed	[parport]
d8897680 parport_device_proc_register_Rbb9f33a4	[parport]
d8897780 parport_device_proc_unregister_R15e1f3ad	[parport]
d88977c0 parport_default_proc_register_R109c8f9a	[parport]
d88977f0 parport_default_proc_unregister_Rd775b7f4	[parport]
d8894fb0 parport_parse_irqs_Rfe3a2867	[parport]
d8894ff0 parport_parse_dmas_Rc976df0b	[parport]
d8897c10 parport_open_R86cec63b	[parport]
d8897d20 parport_close_R8ff537d2	[parport]
d88989e0 parport_device_id_Reaab2342	[parport]
d8897d30 parport_device_num_R2ce00ef0	[parport]
d8897d90 parport_device_coords_R4be801ae	[parport]
d8898050 parport_daisy_deselect_all_Reef49b71	[parport]
d8898070 parport_daisy_select_R29c43045	[parport]
d8897a10 parport_daisy_init_Rc15cfa3d	[parport]
d8898370 parport_find_device_R3f481df7	[parport]
d8898400 parport_find_class_R25212bbb	[parport]
d8894000 __insmod_parport_O/lib/modules/2.4.21-pre7/kernel/drivers/parport/parport.o_M3EB94271_V132117	[parport]
d8894060 __insmod_parport_S.text_L19272	[parport]
d8898bc0 __insmod_parport_S.rodata_L1576	[parport]
d889a4e0 __insmod_parport_S.data_L728	[parport]
d889a7c0 __insmod_parport_S.bss_L64	[parport]
d8892ae0 __insmod_aha1542_S.data_L204	[aha1542]
d8892b00 isapnp	[aha1542]
d8892808 __insmod_aha1542_S.rodata_L240	[aha1542]
d8890060 __insmod_aha1542_S.text_L8010	[aha1542]
d8892bac __insmod_aha1542_S.bss_L100	[aha1542]
d8892b04 aha1542	[aha1542]
d8890000 __insmod_aha1542_O/lib/modules/2.4.21-pre7/kernel/drivers/scsi/aha1542.o_M3EB94272_V132117	[aha1542]
d888c060 __insmod_ide-scsi_S.text_L7707	[ide-scsi]
d888c000 __insmod_ide-scsi_O/lib/modules/2.4.21-pre7/kernel/drivers/scsi/ide-scsi.o_M3EB94272_V132117	[ide-scsi]
d888d430 idescsi_detect	[ide-scsi]
d888d5b0 idescsi_queue	[ide-scsi]
d888d500 idescsi_info	[ide-scsi]
d888d880 idescsi_reset	[ide-scsi]
d888d4d0 idescsi_release	[ide-scsi]
d888e7dc ignore	[ide-scsi]
d888d8a0 idescsi_bios	[ide-scsi]
d888d0d0 idescsi_attach	[ide-scsi]
d888d870 idescsi_abort	[ide-scsi]
d888e520 __insmod_ide-scsi_S.rodata_L20	[ide-scsi]
d888e740 __insmod_ide-scsi_S.data_L268	[ide-scsi]
d888d510 idescsi_ioctl	[ide-scsi]
d888d270 idescsi_init	[ide-scsi]
d888e860 __insmod_ide-scsi_S.bss_L80	[ide-scsi]
d8889000 __insmod_rtc_O/lib/modules/2.4.21-pre7/kernel/drivers/char/rtc.o_M3EB94269_V132117	[rtc]
d8889060 __insmod_rtc_S.text_L5259	[rtc]
d888a5b1 __insmod_rtc_S.rodata_L13	[rtc]
d888a980 __insmod_rtc_S.data_L416	[rtc]
d888ab20 __insmod_rtc_S.bss_L28	[rtc]
c029e550 i8253_lock_R977cb481
c0105430 machine_real_restart_R3da1b07a
c0105360 default_idle_R92897e3d
c02f73a0 drive_info_R744aa133
c029e080 boot_cpu_data_R0657d037
c02f7068 MCA_bus_Rf48a2c4c
c0114900 __verify_write_R203afbeb
c0105990 dump_thread_Rae90b20c
c010d570 dump_fpu_Rf7e7d3e6
c010d630 dump_extended_fpu_Ra9c2ac9b
c0115200 __ioremap_R9eac042a
c0115340 iounmap_R5fb196d4
c01089d0 enable_irq_Rfcec0987
c0108970 disable_irq_R3ce4ca6f
c01091c0 disable_irq_nosync_R27bbf221
c0108e00 probe_irq_mask_R360b1afe
c01175c0 kernel_thread_R7ca341af
c02f6f44 pm_idle_Rf890fe7f
c02f6f48 pm_power_off_R60a32ea9
c010c470 get_cmos_time_Rb31ddfb4
c02f70c0 apm_info_R50db8be5
c010022c gdt_R455fbf86
c0104000 empty_zero_page_R84daabab
c02547f0 __io_virt_debug_R2fd62b99
c01060bc __down_failed
c01060c8 __down_failed_interruptible
c01060d4 __down_failed_trylock
c01060e0 __up_wakeup
c025429c csum_partial_copy_generic_Re8aa9a96
c0254450 __ndelay_Rdf8c695a
c0254420 __udelay_R9e7d6bd0
c02543f0 __delay_R466c14a7
c0254480 __const_udelay_Reae3dfd6
c02546d4 __get_user_1
c02546e8 __get_user_2
c0254704 __get_user_4
c0254990 strtok_Ree9c1bd4
c0254950 strpbrk_R9a1dfd65
c02547a0 strstr_R1e6d26a8
c02545b0 strncpy_from_user_R24428be5
c0254570 __strncpy_from_user_Rc003c637
c0254620 clear_user_R7aec9089
c0254670 __clear_user_Rf3341268
c0254500 __generic_copy_from_user_R116166aa
c02544b0 __generic_copy_to_user_Rd523fdd3
c0254690 strnlen_user_Rbcc308bb
c010ce20 pci_alloc_consistent_Rca1c24c8
c010ce90 pci_free_consistent_R1bfc1908
c0110880 pcibios_penalize_isa_irq_R5211c8bf
c029e120 pci_mem_start_R3da171f9
c010f4e0 pcibios_set_irq_routing_R56254025
c010f3c0 pcibios_get_irq_routing_table_R294a76e5
c02f7080 screen_info_R7e239247
c0105cb0 get_wchan_Rde08db22
c029e550 rtc_lock_R6f67f475
c0254730 memcpy
c0254770 memset
c02f7824 is_sony_vaio_laptop_R7462d5e4
c01118f0 mtrr_add_R56179c5f
c0111ba0 mtrr_del_R272d394e
c01156c0 change_page_attr_R3dfc056b
c0118250 register_exec_domain_R47e9f5c8
c01182a0 unregister_exec_domain_Ra226b04a
c01182f0 __set_personality_R6a47571d
c029ec0c abi_defhandler_coff_R0a1599e0
c029ec10 abi_defhandler_elf_Ra2cfb2a8
c029ec14 abi_defhandler_lcall7_R188ab858
c029ec18 abi_defhandler_libcso_Rc3cac2a9
c02f9ea0 abi_traceflg_R9c9c987a
c02f9e9c abi_fake_utsname_R2e0b4e21
c0118c50 printk_R1b7d4074
c0118da0 acquire_console_sem_Rf174ed48
c0118ea0 console_print_Rb714a981
c0118ec0 console_unblank_Rb857dfed
c0118f00 register_console_R80c5241f
c01190a0 unregister_console_Rd83dc0dd
c0121770 dequeue_signal_R8e39319b
c0121470 flush_signals_Rd3a05d35
c0122090 force_sig_Rcc1e2686
c0121d30 force_sig_info_R807eae99
c01220c0 kill_pg_R38f29719
c0121de0 kill_pg_info_R8e2d4990
c0122120 kill_proc_R932da67e
c0122f00 kill_proc_info_Rfb68b264
c01220f0 kill_sl_Rfba12fd0
c0121e60 kill_sl_info_R1988d21e
c01222f0 notify_parent_Rda55e3d7
c0123190 recalc_sigpending_Rc2a81c73
c0122070 send_sig_R129e9cf5
c0121c70 send_sig_info_R6f97d8fa
c01215f0 block_all_signals_R4b34fbf5
c0121620 unblock_all_signals_R0a2487e0
c01232e0 notifier_chain_register_R60cec3b9
c0123320 notifier_chain_unregister_Rf099679c
c0123350 notifier_call_chain_R28846962
c01233a0 register_reboot_notifier_R1cc6719a
c01233c0 unregister_reboot_notifier_R3980aac1
c0124600 in_group_p_Rc3cf1128
c0124630 in_egroup_p_Rd8a2ab95
c029fc80 hotplug_path_R12dcd5a6
c0125230 exec_usermodehelper_Rc47bf6ad
c0125690 call_usermodehelper_R84a291c8
c0125420 request_module_R27e4dc04
c0125a60 schedule_task_R2d6c3d04
c0125ca0 flush_scheduled_tasks_R7c3242b4
00000001 Using_Versions
c01192b0 inter_module_register_R62dada05
c01193b0 inter_module_unregister_R7a9e845e
c0119460 inter_module_get_Rf6a0ce24
c01194c0 inter_module_get_request_Rb69f826b
c0119500 inter_module_put_R6b99f7d8
c0119d50 try_inc_mod_count_Re6105b23
c0128720 do_mmap_pgoff_R20d1926d
c01291f0 do_munmap_Rb0edcf5f
c0129500 do_brk_R9eecde16
c011b730 exit_mm_R5510b079
c011b4c0 exit_files_Re28e2c6d
c011b5a0 exit_fs_R1952f482
c0121490 exit_sighand_R4a78b604
c01327c0 _alloc_pages_R3224486d
c01329d0 __alloc_pages_Rc0e68e72
c0134f00 alloc_pages_node_R1d164015
c0132b60 __get_free_pages_R4784e424
c0132bb0 get_zeroed_page_R0c2188c7
c0132c20 __free_pages_Rffa9bc2f
c0132c40 free_pages_R9941ccb8
c03000e4 num_physpages_R0948cde9
c0130750 kmem_find_general_cachep_R52bb6891
c012fc50 kmem_cache_create_Rd1c0b4e6
c0130200 kmem_cache_destroy_Rdf83c692
c01301b0 kmem_cache_shrink_R12f7cf04
c0130560 kmem_cache_alloc_R75810956
c01305c0 kmem_cache_free_R891f2686
c0130730 kmem_cache_size_R16a3c749
c0130570 kmalloc_R93d4cfe6
c0130680 kfree_R037a0cba
c012f3e0 vfree_R2fd1d81c
c012f470 __vmalloc_R79995c5b
c0127f30 vmalloc_to_page_R14204a46
c03000f0 mem_map_R49ad51e0
c0127270 remap_page_range_R69d01e73
c03000e0 max_mapnr_R01139ffc
c03000ec high_memory_R8a7d1c31
c0127700 vmtruncate_R713a21b5
c0128e10 find_vma_R4db94c29
c0128cf0 get_unmapped_area_R98524709
c029d800 init_mm_Rfa14abe2
c02a0a40 def_blk_fops_R600530ac
c014e800 update_atime_R488d7154
c013dd30 get_fs_type_R4c83e9b1
c013e1e0 get_super_Rffeb4a80
c013e070 drop_super_R4dbc2267
c01430c0 getname_R7c60d66e
c0301d78 names_cachep_Rd25469b4
c0139e20 fput_Rdfead455
c0139f50 fget_R93681041
c014e3c0 igrab_Rdd3f46e1
c014e340 iunique_R001d504b
c014e430 iget4_R4256f1e8
c014e590 iput_R0d5d59cb
c014d660 inode_init_once_R15a80349
c014e7a0 force_delete_R966e8b95
c0143500 follow_up_Rb2726898
c01435a0 follow_down_Rb3ceaa12
c014fdb0 lookup_mnt_R5eb347e4
c0143ed0 path_init_R819193d1
c0143d10 path_walk_R1886a89c
c0143360 path_release_R64df075f
c0144120 __user_walk_R6f3c922f
c01440b0 lookup_one_len_Rd95b30c3
c0143fe0 lookup_hash_R79ac2dd5
c0138580 sys_close_R268cc6a2
c02a0f20 dcache_lock_R73463cef
c014ca80 d_alloc_root_R9af626d0
c014ccc0 d_delete_Rc4d9137d
c014c360 dget_locked_Raa505a12
c014cc00 d_validate_R7d01bcbd
c014cd50 d_rehash_Rd4cfdf3d
c014c2f0 d_invalidate_R3ab782b1
c014cda0 d_move_Rded27a24
c014ca30 d_instantiate_Rae5faca1
c014c8c0 d_alloc_R2d93ea64
c014caf0 d_lookup_R56ee7f49
c014cee0 __d_path_R46871298
c013b080 mark_buffer_dirty_Rab8da6e3
c013d960 set_buffer_async_io_R268671d9
c013b050 __mark_buffer_dirty_R86f87ca2
c014d750 __mark_inode_dirty_Re2695ae4
c01375a0 fd_install_R22398364
c0139c60 get_empty_filp_Rac1b14a5
c0139d90 init_private_file_Re03cf116
c0138080 filp_open_Rf31d8a78
c0138500 filp_close_Rdb31d5e9
c0139f80 put_filp_Raead4d95
c02a0804 files_lock_Rf9efb16a
c013f880 check_disk_change_R11d4076d
c013ab60 __invalidate_buffers_R98f51538
c013aa20 invalidate_bdev_R281bbfd8
c014dee0 invalidate_inodes_Rdbfa4372
c014df70 invalidate_device_R25a4b0b2
c0129b80 invalidate_inode_pages_R726f399c
c0129e70 truncate_inode_pages_Rfb6abad1
c013a550 fsync_dev_R8ea128e2
c013a510 fsync_no_super_R57520644
c01432d0 permission_Rf5b71be0
c0143190 vfs_permission_R379da559
c014ec50 inode_setattr_R36a7a064
c014ea70 inode_change_ok_R5bc9a965
c014db20 write_inode_now_R7d23e11d
c014ede0 notify_change_R370330a9
c013ee10 set_blocksize_Rc75d857c
c013ef20 sb_set_blocksize_R5cc5a854
c013ef80 sb_min_blocksize_R53c9f774
c013af20 getblk_Rb66143f5
c013fea0 cdget_Rdee70f3e
c013ff80 cdput_Rd7ab4f1d
c013f3d0 bdget_Rbf219111
c013f510 bdput_Rd9f01f48
c013b1d0 bread_Rc6104e5a
c013b170 __brelse_R2721f152
c013b190 __bforget_R3ca18188
c01c6bc0 ll_rw_block_R1128628b
c01c6b40 submit_bh_R3d49de43
c013a0e0 unlock_buffer_R5f240e3c
c013a120 __wait_on_buffer_R607e5d5e
c012a570 ___wait_on_page_R1a524839
c013c920 generic_direct_IO_R6018e99b
c013b5d0 discard_bh_page_Rd958940d
c013c6e0 block_write_full_page_R092edbcd
c013bd60 block_read_full_page_R0d2736e4
c013c390 block_prepare_write_R37f74a83
c013d660 block_sync_page_Ra5d77557
c013bff0 generic_cont_expand_R320bcd5c
c013c110 cont_prepare_write_R9e6cbe6b
c013c410 generic_commit_write_Rda61abbe
c013c4a0 block_truncate_page_Rcd307cfb
c013c8d0 generic_block_bmap_Re2ea9044
c012b380 generic_file_read_Rb41c46bd
c012abf0 do_generic_file_read_R653913ac
c012cb90 generic_file_write_Ra110e55a
c012be20 generic_file_mmap_R43c3eb8b
c02a06e0 generic_ro_fops_Rc7d1258b
c012a060 generic_buffer_fdatasync_R174898ab
c03000fc page_hash_bits_R04925b4e
c0300100 page_hash_table_R17ede69f
c02a0f10 file_lock_list_R6e85119d
c0149440 locks_init_lock_R04374464
c01494f0 locks_copy_lock_R35e3ba65
c014a3c0 posix_lock_file_R10fd23ff
c0149f20 posix_test_lock_Rd2001748
c014ba30 posix_block_lock_R94099ab9
c014ba40 posix_unblock_lock_Ra49f668c
c0149f70 posix_locks_deadlock_Raa595a99
c014a020 locks_mandatory_area_R9dc1c695
c014c190 dput_R89ec2447
c014c770 have_submounts_R57b9f2c7
c014c390 d_find_alias_Rced76a17
c014c3f0 d_prune_aliases_Rab2ef3b0
c014c480 prune_dcache_R6cf28f77
c014c5e0 shrink_dcache_sb_R8217264a
c014c850 shrink_dcache_parent_Rf254bdf4
c014d220 find_inode_number_Reb9c9400
c014d190 is_subdir_Redf2bd12
c01382c0 get_unused_fd_R99bfbe39
c0144180 vfs_create_Rbd26f8d6
c0144b00 vfs_mkdir_R1b2247af
c0144850 vfs_mknod_Rb868eb98
c0145350 vfs_symlink_R223631ab
c0145530 vfs_link_R74c5062f
c0144d30 vfs_rmdir_R1268da71
c0145060 vfs_unlink_R15eec542
c0145fc0 vfs_rename_Rc00d1da9
c0137400 vfs_statfs_R9045d2a8
c0138b70 generic_read_dir_R51309d17
c0138b80 generic_file_llseek_R5dd27a3d
c0138c60 no_llseek_R4174297c
c01482a0 __pollwait_R8d17fcb5
c0148250 poll_freewait_R3fd02e58
c02f6ee0 ROOT_DEV_Rb32496e8
c012a7a0 __find_get_page_Ra0e10210
c012a8a0 __find_lock_page_R75bbbab9
c012a8b0 find_or_create_page_R399a4c66
c012a9a0 grab_cache_page_nowait_Rda030483
c012cae0 read_cache_page_Rf9b8bdb8
c0129b10 set_page_dirty_R39849f63
c0146120 vfs_readlink_R66c4ba89
c01461a0 vfs_follow_link_R71441fea
c0146260 page_readlink_R862887d9
c01462c0 page_follow_link_R84bb481b
c02a0dc0 page_symlink_inode_operations_Re56c3256
c013cfe0 block_symlink_Re5ed67a9
c0147820 vfs_readdir_R893a2deb
c014aac0 __get_lease_R789b1c17
c014ad50 lease_get_mtime_R2d6f620d
c014bec0 lock_may_read_R497d7e5a
c014bf60 lock_may_write_R4fbb4a45
c01478c0 dcache_dir_open_R6266165c
c0147900 dcache_dir_close_R82c175c5
c0147920 dcache_dir_lseek_R0df309f1
c0147a70 dcache_dir_fsync_R7db3099d
c0147a80 dcache_readdir_R789a29cc
c02a0e60 dcache_dir_ops_R077e3f70
c0138c70 default_llseek_Re07e4e87
c01380f0 dentry_open_R436268af
c012bb40 filemap_nopage_R23471b05
c012bd70 filemap_sync_R67796cd5
c012a190 filemap_fdatasync_Rff836da7
c012a250 filemap_fdatawait_Rbd1ad4bd
c012a780 lock_page_R89de0048
c012a630 unlock_page_R4d752d6d
c01399a0 register_chrdev_R43c0d691
c0139a20 unregister_chrdev_Rc192d491
c013f780 register_blkdev_R37a96b4c
c013f800 unregister_blkdev_Reac1c4af
c01acc00 tty_register_driver_R0a308b70
c01acce0 tty_unregister_driver_R5a431cc0
c0305440 tty_std_termios_R89ac5254
c0318260 blksize_size_R2f30b4b6
c0318660 hardsect_size_Rc5f560d8
c0317e60 blk_size_Ra2e0a082
c030f2e0 blk_dev_R806316b2
c01c6240 is_read_only_R740274ca
c01c6280 set_device_ro_Rdc036ebb
c014e7c0 bmap_R7f25d319
c013a5a0 sync_dev_Rfc0b0f49
c015d2b0 devfs_register_partitions_R17117038
c013fb60 blkdev_open_Rfa718f22
c013fad0 blkdev_get_Rce86385d
c013fbb0 blkdev_put_Rc0dd3b15
c013f910 ioctl_by_bdev_R6584b62d
c015d2f0 grok_partitions_R3c470ad6
c015d2c0 register_disk_Rc57e79a1
c02aad40 tq_disk_R5373dbb6
c013abf0 init_buffer_Rdaf53121
c013b160 refile_buffer_Rf135b1e1
c0318e60 max_sectors_R6bf58e33
c0318a60 max_readahead_R3e5480a4
c01aa4e0 tty_hangup_R3aec6f42
c01af7c0 tty_wait_until_sent_R47358b6c
c01aa0e0 tty_check_change_Rc87ebc10
c01aa500 tty_hung_up_p_Rdd11492a
c01aca00 tty_flip_buffer_push_R0ecd4065
c01ac960 tty_get_baud_rate_R66fcf75f
c01ac840 do_SAK_Re3694503
c013da80 register_filesystem_R4e2219de
c013dae0 unregister_filesystem_R8dbc3ae8
c013ead0 kern_mount_R677efd79
c014fff0 __mntput_Rbf8205c2
c0150430 may_umount_R14e29f3c
c0140ae0 register_binfmt_R005d1d86
c0140b30 unregister_binfmt_R8600d711
c0141990 search_binary_handler_Rca72e7ad
c0141610 prepare_binprm_R35dc16ea
c0141760 compute_creds_R11099c69
c01418f0 remove_arg_zero_R765b9a49
c0141d30 set_binfmt_R4a8588c2
c011e190 register_sysctl_table_R72988ae1
c011e220 unregister_sysctl_table_R0f2bdddd
c011f410 sysctl_string_R10ce270d
c011f580 sysctl_intvec_R9e2e5dfc
c011f640 sysctl_jiffies_Re7e29fcd
c011e580 proc_dostring_R17564b96
c011eb80 proc_dointvec_Rfb82fb63
c011f3c0 proc_dointvec_jiffies_Ra50e8010
c011ec60 proc_dointvec_minmax_R1a727a5f
c011f370 proc_doulongvec_ms_jiffies_minmax_R2fa16d07
c011f320 proc_doulongvec_minmax_R711b59a5
c0120530 add_timer_Ra19eacf8
c01205d0 del_timer_Rfc62f16d
c0108b50 request_irq_R0c60f2e0
c0108c30 free_irq_Rf20dabd8
c02fe7e0 irq_stat_R3cb3077d
c0116d30 add_wait_queue_Rdec6c020
c0116d60 add_wait_queue_exclusive_Rc40cf1c3
c0116d90 remove_wait_queue_R7d2d3753
c0115e00 wait_for_completion_Rdc016488
c0115da0 complete_R942613ad
c0108cc0 probe_irq_on_Rb121390a
c0108e80 probe_irq_off_Rab600421
c0120570 mod_timer_R1f13d309
c029fad8 tq_timer_Rfa3e9acc
c029fae0 tq_immediate_R0da0dcd1
c014f610 alloc_kiovec_Rd5f543f1
c014f6b0 free_kiovec_R7e595355
c014f730 expand_kiobuf_Rafbeab81
c0126d80 map_user_kiobuf_Rf2e9ca74
c0126f10 unmap_kiobuf_Rb0866723
c0126f60 lock_kiovec_R18d43b1a
c0127060 unlock_kiovec_Rc06da2cc
c013cb70 brw_kiovec_Re42d9ee0
c014f7e0 kiobuf_wait_for_io_R45a1cfe8
c0116cb0 request_dma_R43435480
c0116cf0 free_dma_R72b243d4
c029eae0 dma_spin_lock_R4411b792
c0105340 disable_hlt_R794487ee
c0105350 enable_hlt_R9c7077bd
c011d930 request_resource_R41685cfb
c011d960 release_resource_R814e8407
c011daa0 allocate_resource_Rb859c3d0
c011d970 check_resource_Rd8d78aaa
c011db30 __request_region_R1a1a4f09
c011dbc0 __check_region_Rf1d0cdab
c011dc10 __release_region_Rd49501d4
c029ee90 ioport_resource_R865ebccd
c029eeac iomem_resource_R9efed5af
c011bcc0 complete_and_exit_R95deffb7
c0115cc0 __wake_up_Rb76c5f1e
c0115d30 __wake_up_sync_R0231d9ea
c01169a0 wake_up_process_R62cb6fdc
c0115f70 sleep_on_Re0679a3f
c0115fd0 sleep_on_timeout_R75c8e394
c0115ea0 interruptible_sleep_on_R7e4f89c3
c0115f00 interruptible_sleep_on_timeout_R407a28d8
c0115970 schedule_R4292364c
c01158b0 schedule_timeout_R17d59d01
c0116400 yield_R760a0f4f
c0116420 __cond_resched_R49e79940
c02feba4 jiffies_R0da02d67
c02febb0 xtime_Rf31ddf83
c010c090 do_gettimeofday_R72270e35
c010c100 do_settimeofday_R19d7b1ff
c029d8e8 loops_per_jiffy_Rba497f13
c02f7a00 kstat_Rb3c1dfc0
c02f8e60 nr_running_Rca3c6d78
c01184b0 panic_R01075bf0
c0118650 __out_of_line_bug_R8b0fd3c5
c02555b0 sprintf_R1d26aa98
c0255550 snprintf_R025da070
c0255a30 sscanf_R859204af
c0255580 vsprintf_R954cbb26
c02550f0 vsnprintf_R57a6504e
c02555e0 vsscanf_Rb5044271
c0139b00 kdevname_Rc258c906
c013fce0 bdevname_Rd04782e6
c0139b40 cdevname_R9754741d
c0254b70 simple_strtol_R0b742fd7
c0254ac0 simple_strtoul_R20000329
c0254bb0 simple_strtoull_R61b7b126
c029d900 system_utsname_Rb12cdfe7
c029fb54 uts_sem_R86e953cb
c029db10 sys_call_table_Rdfdb18bd
c01054f0 machine_restart_Re6e3ef70
c0105570 machine_halt_R9aa32630
c0105580 machine_power_off_R091c824a
c02d9820 _ctype_R8d3894f2
c01b3440 secure_tcp_sequence_number_R1e68841f
c01b2530 get_random_bytes_R79aa04a2
c029eaa0 securebits_Rabe77484
c029facc cap_bset_R59ab4080
c01167f0 reparent_to_init_Rec6158d0
c0116930 daemonize_Rd66a354a
c025417c csum_partial_R9a3de8f8
c0152220 seq_escape_R3061b9fd
c01522f0 seq_printf_R19d0ea84
c0151c10 seq_open_R5a7423f8
c01521f0 seq_release_Re2a8f261
c0151c80 seq_read_R8e0b1291
c01520f0 seq_lseek_R7459bd7e
c0141010 setup_arg_pages_R4fcb22c6
c0140ef0 copy_strings_kernel_R1b0da376
c0141b10 do_execve_R9c62098f
c01413d0 flush_old_exec_Rfbd1fdd6
c0141240 kernel_read_R90b610ac
c0141150 open_exec_R9b821891
c0114820 si_meminfo_Rb3a307c6
c02fe7c0 sys_tz_Rfe5d4bb2
c013a5d0 file_fsync_Rb5ff9495
c013acb0 fsync_buffers_list_Rd2e9eab8
c014dcf0 clear_inode_Rc662c784
c0326234 ___strtok_R29805c13
c0139bb0 init_special_inode_Ra8ce4f0f
c030eec0 read_ahead_R0abb7b07
c013a8f0 get_hash_table_R4247fe50
c014e190 new_inode_R69ee5853
c014e520 insert_inode_hash_R5ffc1615
c014e570 remove_inode_hash_R1855a4c9
c013a970 buffer_insert_list_R9e2c64e9
c014ef30 make_bad_inode_R3f6a31c9
c014ef60 is_bad_inode_R37b1574e
c02feb80 event_R7b16c344
c013cf00 brw_page_R063d7ee8
c014fb50 __inode_dir_notify_R81d58603
c029fb28 overflowuid_R8b618d08
c029fb2c overflowgid_R7171121c
c029fb30 fs_overflowuid_R25820c64
c029fb34 fs_overflowgid_Rdf929370
c0147350 fasync_helper_R3486e2a1
c01474a0 kill_fasync_R8308dd29
c015ce40 disk_name_R3043a824
c0143310 get_write_access_R417861bc
c0254890 strnicmp_R4e830a3e
c0254900 strspn_Rc7ec6c27
c0254a00 strsep_R85df9b6c
c02f6b40 tasklet_hi_vec_Rbb06575f
c02f6b20 tasklet_vec_R41d3b367
c02fe800 bh_task_vec_R284177b8
c011d5a0 init_bh_Rf6cf27cc
c011d5c0 remove_bh_Rbc524a32
c011d4c0 tasklet_init_Ra5808bbf
c011d4f0 tasklet_kill_R79ad224b
c011d5f0 __run_task_queue_R3889b11c
c011d240 do_softirq_Rf0a529b7
c011d2e0 raise_softirq_Rd8e4fa1c
c011d730 cpu_raise_softirq_Rd01f3ee8
c011d340 __tasklet_schedule_Red5c73bf
c011d390 __tasklet_hi_schedule_R60ea5fe7
c02dc000 init_task_union_Rf9ed39d3
c02f6b00 tasklist_lock_R999c80a2
c02f8e80 pidhash_R20340971
c0107800 dump_stack_R6b2dc060
c0126340 pm_register_R027ebe5e
c01263d0 pm_unregister_R94097bd6
c0126480 pm_unregister_all_Rba4fe124
c01264f0 pm_send_R1abc3026
c01265f0 pm_send_all_Recbf9cad
c01266a0 pm_find_Re7902a5f
c03000cc pm_active_Rebd387f6
c0126be0 get_user_pages_R596ec52f
c029fe28 vm_max_readahead_Rf8c9aa3c
c029fe2c vm_min_readahead_R41ef314d
c012a150 fail_writepage_R9d8b9fa8
c030013c zone_table_R25fcc265
c0136f70 shmem_file_setup_Rf18a4b6b
c0138640 generic_file_open_R362d14e8
c013b0c0 set_buffer_flushtime_R08d59749
c013b2d0 put_unused_buffer_head_R84ddfca3
c013b2e0 get_unused_buffer_head_R009c9642
c013b360 set_bh_page_R1129e836
c013b660 create_empty_buffers_R63d0231e
c013c810 writeout_one_page_Rbcb432ad
c013c880 waitfor_one_page_R5c520b6b
c013d4b0 try_to_free_buffers_Ra7b7294d
c0301d84 bh_cachep_Rdcc0bb37
c0301ed4 nfsd_linkage_Rb7a059a8
c0301f34 proc_sys_root_R8d47572e
c0159bf0 proc_symlink_R0a3c8e7d
c0159cb0 proc_mknod_R5b0cdf91
c0159d20 proc_mkdir_Rd87191c1
c0159d90 create_proc_entry_R255e1dd3
c0159ec0 remove_proc_entry_R6db494cb
c02a1460 proc_root_R36055e57
c0301f24 proc_root_fs_R9d695a5a
c0301f28 proc_net_R428a9b14
c0301f2c proc_bus_R5b3b111b
c0301f30 proc_root_driver_Rf1519128
c016a4e0 journal_start_R7fc33d0f
c016a6a0 journal_try_start_R367131e4
c016a850 journal_restart_R7c431183
c016a790 journal_extend_R86f07098
c016b970 journal_stop_Rb3ae571c
c016a990 journal_lock_updates_Rc6d5c319
c016aa00 journal_unlock_updates_R45191b54
c016afe0 journal_get_write_access_R8be54626
c016b060 journal_get_create_access_R0bbe7f12
c016b270 journal_get_undo_access_R9ae4ac5f
c016b3a0 journal_dirty_data_R46f9f609
c016b560 journal_dirty_metadata_R5a3d4cdb
c016b730 journal_forget_Rbee5e532
c0170f10 journal_flush_R14a0b32b
c016f4d0 journal_revoke_R616ab623
c016b950 journal_callback_set_Rac666463
c01703a0 journal_init_dev_Rcb38958b
c0170470 journal_init_inode_R077ec472
c0170e00 journal_update_format_Rfb8bd3aa
c0170c90 journal_check_used_features_R97a1d226
c0170d00 journal_check_available_features_R4f4262d4
c0170d70 journal_set_features_R5e0e2337
c0170660 journal_create_R13eaa482
c0170a50 journal_load_R328d1368
c0170ae0 journal_destroy_R5b3857ff
c016de80 journal_recover_Rc093645c
c0170800 journal_update_superblock_R75eab575
c01712e0 journal_abort_Rce009d74
c0171330 journal_errno_R916aa04c
c0171390 journal_ack_err_R9175fa7c
c0171360 journal_clear_err_R8f693a30
c0170080 log_wait_commit_R650e7702
c0170030 log_start_commit_R646e09da
c0171140 journal_wipe_R6d5182bb
c0171470 journal_blocks_per_page_Re45b054f
c016c120 journal_flushpage_Re922b66a
c016bdd0 journal_try_to_free_buffers_R1414a0f5
c0170170 journal_bmap_R6c282f3a
c016bb50 journal_force_commit_R50348cbd
c017d150 register_nls_Rb75d5c98
c017d1a0 unregister_nls_Re636348f
c017d2e0 unload_nls_R36a16ffc
c017d240 load_nls_Rafd2e7ee
c017d380 load_nls_default_R535f6428
c017cf60 utf8_mbtowc_R4ddc4b9f
c017cfe0 utf8_mbstowcs_R7d850612
c017d050 utf8_wctomb_Rf82f1109
c017d0d0 utf8_wcstombs_R863cb91a
c01a9da0 tty_register_ldisc_R510029ac
c01acbe0 tty_register_devfs_R2b86812d
c01acbf0 tty_unregister_devfs_Rac413b04
c01afea0 n_tty_ioctl_R02f66ecb
c01b1820 misc_register_R012748b7
c01b19a0 misc_deregister_R0355e5c9
c01b1f90 add_keyboard_randomness_R74789c19
c01b1fc0 add_mouse_randomness_R70507c97
c01b1fe0 add_interrupt_randomness_R16dfbf36
c01b2020 add_blkdev_randomness_Rd9cb21d1
c01b1d20 batch_entropy_store_R68d33fbe
c01b2d40 generate_random_uuid_Ra681fe88
c02a507c color_table_Rf6bb4729
c02a50a0 default_red_R3147857d
c02a50e0 default_grn_R06fe3b14
c02a5120 default_blu_R10ee20bb
c030cddc video_font_height_R65e24198
c030cde4 video_scan_lines_Rafaf59dc
c01b8560 vc_resize_R12e7edfe
c030cf10 fg_console_R4e6e8ea7
c030d450 console_blank_hook_Rd25d4f74
c030cce0 vt_cons_R83424298
c01bbee0 take_over_console_Rdea4e062
c01bc0b0 give_up_console_Rd52fff57
c01bce50 set_selection_R6b419fb4
c01bd3d0 paste_selection_Rcf4f36c8
c01c2b90 register_serial_Ra18dc2b1
c01c2de0 unregister_serial_Rce8a3e65
c01c2380 pci_siig10x_fn_R74601a65
c01c2450 pci_siig20x_fn_R9c2d3f8c
c01c3660 handle_scancode_Rd3d6a2f1
c030edbc kbd_ledfunc_Rfa67cc5f
c01c45a0 kbd_refresh_leds_Raa2c935a
c02a966c keyboard_tasklet_R28aa0faa
c01c5920 handle_sysrq_R3df5cacb
c01c59a0 __handle_sysrq_nolock_Rc26f984b
c01c58a0 __sysrq_lock_table_R6eced4f5
c01c58b0 __sysrq_unlock_table_Rbd25cd87
c01c58c0 __sysrq_get_key_op_R26f38d83
c01c58f0 __sysrq_put_key_op_R1671df4d
c02aad48 io_request_lock_Rc30f3aef
c01c6d90 end_that_request_first_R1d48686d
c01c6e80 end_that_request_last_R234f626f
c01c5ed0 blk_grow_request_list_R66710f4c
c01c6010 blk_init_queue_R0802f687
c01c6eb0 blk_get_queue_R5e936340
c01c5b10 blk_cleanup_queue_R7fd1c8b0
c01c5b80 blk_queue_headactive_R8c52dac0
c01c5b90 blk_queue_make_request_R07f02fbe
c01c6a10 generic_make_request_Raabec40c
c01c62e0 blkdev_release_request_R325509a1
c01c5e90 generic_unplug_device_Ra2b8075e
c01c5ba0 blk_queue_bounce_limit_R3d7bd934
c030f2bc blk_max_low_pfn_R1163f0a7
c030f2c0 blk_max_pfn_R82e59756
c01c6ee0 blk_seg_merge_ok_R038f2214
c02aad48 blk_nohighio_Rba637bff
c01c74b0 blk_ioctl_Re7800428
c031b240 gendisk_head_R0aa367e8
c01c7a70 add_gendisk_R0299f769
c01c7aa0 del_gendisk_Ra03f013f
c01c7af0 get_gendisk_R9a6c766d
c01cfc70 init_etherdev_R90e31ccc
c01cfca0 alloc_etherdev_Rcf5cd9d6
c01cfd40 ether_setup_Rb5d61a3c
c01cfdf0 register_netdev_Rda8e99f1
c01cfe80 unregister_netdev_R68aa1924
c01d00d0 autoirq_setup_R5a5a2280
c01d00e0 autoirq_report_R84530c53
c01d16c0 agp_free_memory_R48653576
c01d1760 agp_allocate_memory_R47ba4b82
c01d1860 agp_copy_info_Rd9106651
c01d1910 agp_bind_memory_R28347b8b
c01d1980 agp_unbind_memory_R1888e773
c01d2280 agp_enable_R50eb8453
c01d1540 agp_backend_acquire_Rfda71904
c01d1580 agp_backend_release_R0d43fde1
c01d4ab0 probe_hwif_R67fab519
c01d4d60 save_match_R2d0eb108
c01d4e20 init_irq_Rb754bf15
c01d5160 init_gendisk_R18c715cd
c01d54b0 hwif_init_R9d0919db
c01d5730 export_ide_init_queue_R8a7828ff
c01d5740 export_probe_for_drive_R250ddff1
c01d6300 unplugged_hwif_iops_R34f8a740
c01d6470 default_hwif_iops_Rc40404a2
c01d67b0 default_hwif_mmiops_R900681b1
c01d6830 default_hwif_transport_R1bd52e01
c01d6870 read_24_Rc7831b6a
c01d7e10 SELECT_DRIVE_R8d8e5810
c01d7e70 SELECT_INTERRUPT_Rb6b81ba7
c01d7ec0 SELECT_MASK_Ra7fb5b90
c01d7f00 QUIRK_LIST_R1129421f
c01d68e0 ata_vlb_sync_R9f2f007f
c01d6930 ata_input_data_Rc4cc51f7
c01d69f0 ata_output_data_R90f4b38c
c01d6ab0 atapi_input_bytes_Rb0be5faf
c01d6b40 atapi_output_bytes_Rd5f1bedc
c01d6bd0 ide_fix_driveid_R824fa796
c01d6be0 ide_fixstring_R4101a975
c01d6c80 drive_is_ready_Racc35b79
c01d6cc0 wait_for_ready_R35269fb4
c01d6d70 ide_wait_stat_R404c40d6
c01d6eb0 eighty_ninty_three_R4f9f13b7
c01d6f00 ide_ata66_check_R14249a0d
c01d6f70 set_transfer_R5b12bbbd
c01d6fb0 ide_auto_reduce_xfer_R288ef1e8
c01d7020 ide_driveid_update_R8a80712f
c01d7230 ide_config_drive_speed_Ra98e2e74
c01d7670 __ide_set_handler_R5bdbc632
c01d7700 ide_set_handler_Rc2e73ae9
c01d7740 ide_execute_command_R1f0b6df2
c01d7df0 ide_do_reset_R91932ab7
c01dad60 task_read_24_Refb054e4
c01d7f80 taskfile_input_data_Rf28aae4d
c01d7ff0 taskfile_output_data_Rbb76afe1
c01d8080 taskfile_lib_get_identify_R30ec301d
c01d8100 do_rw_taskfile_Rd59dae07
c01d8390 taskfile_dump_status_Rbb0e7361
c01d8810 ide_end_taskfile_R6057b9db
c01d8a10 task_try_to_flush_leftover_data_R58b71774
c01d8a80 taskfile_error_Rea5c456e
c01d8c60 set_multmode_intr_Rc03e7d74
c01d8cd0 set_geometry_intr_Rb38761b2
c01d8d90 recal_intr_R21f8c892
c01d8de0 task_no_data_intr_R35f98cdb
c01d8e80 task_in_intr_Recbfa929
c01d8f90 task_mulin_intr_R69eb76e2
c01d90e0 pre_task_out_intr_Rcf6d87b9
c01d91b0 task_out_intr_Rf950cfa8
c01d9310 pre_task_mulout_intr_R7b71acaf
c01d93d0 task_mulout_intr_Rf563804f
c01d9590 ide_pre_handler_parser_R6a491080
c01d9620 ide_handler_parser_R3807f2ec
c01d96b0 ide_post_handler_parser_Ra22a7282
c01d96c0 ide_cmd_type_parser_R80899297
c01d97b0 ide_init_drive_taskfile_Rd8f5f3fc
c01d97f0 ide_diag_taskfile_R85c75a86
c01d98a0 ide_raw_taskfile_R9211aa44
c01d98d0 ide_taskfile_ioctl_R3aa445c2
c01d9e10 ide_wait_cmd_R7b9008c0
c01d9ee0 ide_cmd_ioctl_R59dc5cc4
c01da110 ide_wait_cmd_task_R0dd6ba80
c01da160 ide_task_ioctl_R7aa5a710
c01da1e0 flagged_taskfile_Rf10519dd
c02acd20 noautodma_R70022241
c031c8e0 ide_hwifs_Re685fb1c
c031f400 idedisk_Rfda77cd8
c031f404 idecd_R18f98e3a
c031f408 idefloppy_R1dfe7b18
c031f40c idetape_Rc4365062
c031f410 idescsi_R72ecb5ac
c01db370 current_capacity_Rd6f19a03
c01db3a0 ide_dump_status_Rcd5ad089
c01db8a0 ide_revalidate_disk_R0e604442
c01dba50 ide_probe_module_Rdb016a03
c01dba80 ide_driver_module_Rb983e201
c01dbc70 hwif_unregister_R5aed0631
c01dbd70 ide_unregister_Rec16ca95
c01dc5a0 ide_setup_ports_Rf51954a7
c01dc600 ide_register_hw_R9940cb71
c01dc790 ide_register_R3b5586d8
c02acd60 ide_setting_sem_R3ccdbd77
c01dc800 ide_add_setting_R073d1ee5
c01dca30 ide_remove_setting_R62f6817a
c01dcbc0 ide_spin_wait_hwgroup_R4f5efb7e
c01dcc30 ide_write_setting_Rfc9ff155
c01dd3c0 ide_delay_50ms_R7f9ab554
c01dd3f0 system_bus_clock_Ree5a11eb
c01dd410 ide_replace_subdriver_R7f48a93e
c01dd4d0 ide_attach_drive_Ra5ba3b3a
c01de3d0 ide_scan_devices_Reef77c38
c01de4b0 ide_register_subdriver_R710e7c6a
c01de5f0 ide_unregister_subdriver_R79730933
c01de680 ide_register_module_R8526704f
c01de6d0 ide_unregister_module_Rad381b18
c02acd78 ide_fops_R8a764a6c
c01de710 ide_geninit_R9b158a52
c031c8dc ide_probe_R0897fa69
c031f414 ide_devfs_handle_Reb53c0a2
c01deb30 ide_xfer_verbose_Re2daeb0a
c01debc0 ide_dma_speed_R19d59ab2
c01dee10 ide_rate_filter_R8691989a
c01dee50 ide_dma_enable_Raabb7b9b
c025fda0 ide_pio_timings_R4186676c
c01def40 ide_get_best_pio_mode_R30a871c6
c01df0b0 ide_toggle_bounce_R7962311c
c01df100 ide_set_xfer_rate_R577df285
c01df140 ide_end_request_R345c64a7
c01df210 ide_end_drive_cmd_Re569d141
c01df4f0 try_to_flush_leftover_data_R59380600
c01df560 ide_error_Rabdcb6eb
c01df730 ide_abort_Rbd61796b
c01df7b0 ide_cmd_Rbc668d5e
c01df860 drive_cmd_intr_R54f5b7c7
c01df970 do_special_R99bd5505
c01df9d0 execute_drive_cmd_Re44829ef
c01dfc10 start_request_Rd45ebc38
c01dfe20 restart_request_R3ee0790a
c01dfe40 ide_stall_queue_R8a7154be
c01dfe70 ide_do_request_R7012964e
c01e0000 ide_get_queue_R31b1eaac
c01e0050 ide_dma_timeout_retry_R6bdfca18
c01e00e0 ide_timer_expiry_Ra7ac9f5b
c01e0340 ide_intr_Rc912a433
c01e0470 get_info_ptr_Ra8973d19
c01e04e0 ide_init_drive_cmd_R38c26355
c01e0520 ide_do_drive_cmd_Ra5b5d117
c01e95a0 ide_setup_pci_device_R66d87d88
c01e95d0 ide_setup_pci_devices_Ra513b0a6
c01e9630 ide_pci_register_driver_Rf90cd4eb
c01e96a0 ide_pci_unregister_driver_R02239fbc
c01e9870 ide_dma_intr_R19826cdc
c01e9ce0 ide_build_dmatable_Rff025f88
c01e9e80 ide_destroy_dmatable_R3c9a5afc
c01ea060 __ide_dma_host_off_Rfe2e8675
c01ea0d0 __ide_dma_off_quietly_Rfdff9743
c01ea110 __ide_dma_off_R45c3a129
c01ea150 __ide_dma_host_on_Ra5561140
c01ea1d0 __ide_dma_on_R43364ef5
c01ea210 __ide_dma_check_Rbca5d5a5
c01ea220 __ide_dma_read_R17b7a497
c01ea350 __ide_dma_write_Rb8a1d2d8
c01ea480 __ide_dma_begin_R40490f44
c01ea4d0 __ide_dma_end_R26c4c840
c01ea570 __ide_dma_test_irq_Ra9f2e88d
c01ea5d0 __ide_dma_bad_drive_Ra45f6afb
c01ea630 __ide_dma_good_drive_R33dd6632
c01ea660 __ide_dma_count_R00be0716
c01ea680 __ide_dma_verbose_Rc3d73548
c01ea870 __ide_dma_retune_R0f90d68b
c01ea890 __ide_dma_lostirq_R2584a068
c01ea8b0 __ide_dma_timeout_R15209a68
c01eaea0 ide_setup_dma_R1dd57168
c01eb7d0 proc_ide_read_config_R854f4192
c01eb970 proc_ide_read_drivers_R3b077a52
c01eba00 proc_ide_read_imodel_R4a8d1084
c01ebb10 proc_ide_read_mate_R4e883a78
c01ebbb0 proc_ide_read_channel_R699b3216
c01ebc20 proc_ide_read_identify_R1f8c12c5
c01ebd10 proc_ide_read_settings_R420b5bb9
c01ebed0 proc_ide_write_settings_R19d109b2
c01ec0f0 proc_ide_read_capacity_R46b2a30d
c01ec180 proc_ide_read_geometry_R50fed6f7
c01ec240 proc_ide_read_dmodel_R11f2d799
c01ec2d0 proc_ide_read_driver_R7bbbb662
c01ec350 proc_ide_write_driver_R3d6ea543
c01ec3b0 proc_ide_read_media_Rb9895a88
c01ec450 ide_add_proc_entries_R804196f1
c01ec4c0 ide_remove_proc_entries_R02a192f5
c01ec510 create_proc_ide_drives_R0d13401b
c01ec620 recreate_proc_ide_device_R8bc7c537
c01ec6d0 destroy_proc_ide_device_R2b9e327d
c01ec750 destroy_proc_ide_drives_R90e2bcb4
c01ec7a0 create_proc_ide_interfaces_Rab2c600e
c01ec810 destroy_proc_ide_interfaces_R99dbd93f
c01ec870 ide_pci_register_host_proc_R1cc47cd1
c01ec8c0 proc_ide_create_Ra8e0f104
c01ec980 proc_ide_destroy_R35e1351c
c01ee920 scsi_register_module_Rfa20b7b0
c01ee990 scsi_unregister_module_R81d85a75
c01f6260 scsi_free_R475dddfa
c01f6190 scsi_malloc_R1cce3f92
c01eeed0 scsi_register_Ra0d5b603
c01eee60 scsi_unregister_Rf3873de4
c01f05a0 scsicam_bios_param_R054b9b47
c01f06c0 scsi_partsize_Rd6076dd5
c01ecb90 scsi_allocate_device_Rf862b858
c01ed410 scsi_do_cmd_R9289ce2b
c0260500 scsi_command_size_R9b05ea5c
c01ef8e0 scsi_ioctl_R00965eb0
c01efe10 print_command_R528232e7
c01f0170 print_sense_R614e8f30
c01f01a0 print_req_sense_R25e58314
c01f01d0 print_msg_R8cc5ae07
c01efe70 print_status_Re4c08ccd
c02ae70c scsi_dma_free_sectors_Re930b3cb
c01efcc0 kernel_scsi_ioctl_R7f784d53
c02ae710 scsi_need_isa_buffer_Re22bca98
c01ece60 scsi_release_command_R997af5a3
c01f03f0 print_Scsi_Cmnd_R9e128ba5
c01f1170 scsi_block_when_processing_errors_Rfef043eb
c01f3400 scsi_mark_host_reset_Red8cc566
c01ef500 scsi_ioctl_send_command_Rf5c831c9
c01ecad0 scsi_allocate_request_R1e6b1d26
c01ecb50 scsi_release_request_R50589088
c01ed0c0 scsi_wait_req_R2dbc365f
c01ed170 scsi_do_req_Rdbfab1db
c01f4870 scsi_report_bus_reset_R07513f5c
c01f4820 scsi_block_requests_R8fb3dc9a
c01f4830 scsi_unblock_requests_R5c3cbbca
c01ee9e0 scsi_get_host_dev_Rfd27ea6f
c01eea70 scsi_free_host_dev_R12a46dfc
c01f16b0 scsi_sleep_R35962bf8
c01f0de0 proc_print_scsidevice_Rdaaa8c4e
c031f42c proc_scsi_R964a3235
c01f4070 scsi_io_completion_Ra46a9cc7
c01f3f60 scsi_end_request_Rd47a8d4d
c01f48a0 scsi_register_blocked_host_R6d3cfc03
c01f48b0 scsi_deregister_blocked_host_Re1598ded
c01eead0 scsi_reset_provider_Rb536514d
c031f454 scsi_hostlist_Ra16c038d
c031f45c scsi_hosts_Reeec77b9
c031f458 scsi_devicelist_Rb3558c80
c0260520 scsi_device_types_Rd54b74ac
c01f1040 scsi_add_timer_R50ecc277
c01f10b0 scsi_delete_timer_R97d06793
c01fd7e0 cdrom_get_disc_info_R6bc3dbd6
c01fd710 cdrom_get_track_info_R6d600868
c01fda00 cdrom_get_next_writable_R36914bae
c01fd8a0 cdrom_get_last_written_R78263467
c01faa90 cdrom_count_tracks_Re746a53b
c01f9ba0 register_cdrom_R5a61744f
c01f9e00 unregister_cdrom_R703d3575
c01f9ef0 cdrom_open_Rfeeb9358
c01fa510 cdrom_release_Reb50ceb2
c01fbb90 cdrom_ioctl_Re94eb557
c01faa40 cdrom_media_changed_R0054e9fe
c01fa750 cdrom_number_of_slots_R5d8f3672
c01fa8a0 cdrom_select_disc_R8dcbf2fd
c01fb8d0 cdrom_mode_select_Rcf102018
c01fb850 cdrom_mode_sense_R441c9253
c01face0 init_cdrom_command_Rfacde1b5
c01f9ec0 cdrom_find_device_R57baf788
c01ff790 pci_read_config_byte_R3ccefab4
c01ff7d0 pci_read_config_word_R923654cb
c01ff820 pci_read_config_dword_R0bf170e2
c01ff870 pci_write_config_byte_R364fc2a2
c01ff8b0 pci_write_config_word_Rf23d8795
c01ff900 pci_write_config_dword_R77f7f940
c02af148 pci_devices_R7a84b102
c02af140 pci_root_buses_R082c3213
c01fece0 pci_enable_device_bars_Rc7a002b9
c01fed20 pci_enable_device_R1bc741d2
c01fed40 pci_disable_device_R95846005
c01fe8e0 pci_find_capability_R097d3101
c01ff170 pci_release_regions_R32f6b833
c01ff1a0 pci_request_regions_R01186146
c01fef30 pci_release_region_R0b5991ae
c01feff0 pci_request_region_R4e266bbc
c01fe8a0 pci_find_class_R643cfa42
c01fe860 pci_find_device_Rc584f4e3
c01fe780 pci_find_slot_R391edc78
c01fe7d0 pci_find_subsys_R29ab2f45
c01ff950 pci_set_master_R99cc7ae2
c01ffa90 pci_set_mwi_Rc280a6ec
c01ffb00 pci_clear_mwi_Re311513e
c01ff9c0 pdev_set_mwi_Rf32d6291
c01ffb70 pci_set_dma_mask_R80a48ce9
c01ffbb0 pci_dac_set_dma_mask_R6ec7580d
c02029b0 pci_assign_resource_Rd095861e
c01ff380 pci_register_driver_R1e536d21
c01ff3e0 pci_unregister_driver_Re8061e13
c01ff760 pci_dev_driver_R58a96c85
c01ff260 pci_match_device_Rf3392d45
c01fe9e0 pci_find_parent_resource_R0770b048
c02004d0 pci_setup_device_R863ed348
c01ff630 pci_insert_device_R3341a12e
c01ff6d0 pci_remove_device_R2d6c74a6
c01ff5d0 pci_announce_device_to_drivers_Rc3f2c56b
c0200220 pci_add_new_bus_R98038322
c02008c0 pci_do_scan_bus_R0f39e16c
c02007d0 pci_scan_slot_Rb4149ce6
c0200a60 pci_scan_bus_R023fc82e
c02006e0 pci_scan_device_Raceae718
c01fff10 pci_read_bridge_bases_Rff6344f9
c0202340 pci_proc_attach_device_R346f7e0e
c0202420 pci_proc_detach_device_R1771e16f
c0202470 pci_proc_attach_bus_Ra56ce41b
c02024e0 pci_proc_detach_bus_Rbc531827
c031f8cc proc_bus_pci_dir_Rc1bb79ee
c01fea70 pci_set_power_state_R11eecaa6
c01febf0 pci_save_state_R62eca146
c01fec40 pci_restore_state_R1fb877c8
c01fedb0 pci_enable_wake_Re4028ad7
c0201810 pcibios_present_R520a75b9
c02018f0 pcibios_read_config_byte_Rd80115e1
c0201960 pcibios_read_config_word_Raa9effd7
c02019d0 pcibios_read_config_dword_R38ae6689
c0201a40 pcibios_write_config_byte_R719856ee
c0201aa0 pcibios_write_config_word_R4f1c2e33
c0201b00 pcibios_write_config_dword_R81b4f465
c0201820 pcibios_find_class_Ref333f7b
c0201880 pcibios_find_device_R97d49c4d
c031f8c4 isa_dma_bridge_buggy_Rf82abc1d
c031f8c0 pci_pci_problems_Rdc14eda7
c0200db0 pci_pool_create_Ra38fff27
c0201030 pci_pool_destroy_Rb564fd3f
c02010f0 pci_pool_alloc_Rba279244
c0201290 pci_pool_free_Rb5179d81
c02d4ca0 isapnp_cards_R593dbfd2
c02d4ca8 isapnp_devices_R2db6fba6
c0202ed0 isapnp_present_Rbf8b39e9
c0202ee0 isapnp_cfg_begin_R770a0036
c0202fb0 isapnp_cfg_end_R28b715a6
c0202aa0 isapnp_read_byte_Re3be82b4
c0202ad0 isapnp_read_word_Rbf3d7670
c0202b20 isapnp_read_dword_Rcfbf7247
c0202b90 isapnp_write_byte_Rda8fd495
c0202bd0 isapnp_write_word_R6aed3a24
c0202c20 isapnp_write_dword_Rd7dc599a
c0202da0 isapnp_wake_Rfc4e2140
c0202dc0 isapnp_device_Re00489ef
c0202de0 isapnp_activate_R2ee66b41
c0202e20 isapnp_deactivate_Re5bc3040
c0203190 isapnp_find_card_R99418839
c02031e0 isapnp_find_dev_R27cb2cad
c0203320 isapnp_probe_cards_R81218926
c0203400 isapnp_probe_devs_Rb35feaaa
c0203470 isapnp_activate_dev_R7fc23f26
c0204ea0 isapnp_resource_change_R09b965af
c0204f50 isapnp_register_driver_Rfa4495a1
c0204fb0 isapnp_unregister_driver_R10affe44
c02096c0 register_framebuffer_R56516fa1
c0209800 unregister_framebuffer_R1dc6c5e6
c031fa20 registered_fb_R89416442
c031fa00 num_registered_fb_R6c61ce70
c0209520 GET_FB_IDX_R5280c630
c0209990 fb_alloc_cmap_R07a890c8
c0209b20 fb_copy_cmap_R3d68266c
c0209d60 fb_get_cmap_R8cd83ea3
c0209ed0 fb_set_cmap_Rbafd3fe0
c0209ff0 fb_default_cmap_Ra56557ea
c020a020 fb_invert_cmaps_Rf195c682
c020a170 __fb_try_mode_R02214ab9
c031fb40 fb_display_Rd9873e3c
c020be40 fbcon_redraw_bmove_R7a04f582
c020bdd0 fbcon_redraw_clear_R01c0ec23
c02d6a20 fbcon_dummy_R3ce0628d
c02613e0 fb_con_R00fa7f08
c0212410 skb_over_panic_R225fb2ab
c0212460 skb_under_panic_R57fcff36
c02131f0 skb_pad_R5f69484f
c0210a60 sock_register_R2b0fe248
c0210ab0 sock_unregister_R2394a062
c0211aa0 __lock_sock_Ra58599a7
c0211b70 __release_sock_R2f3c2c20
c0214350 memcpy_fromiovec_R9fb3dd30
c02142f0 memcpy_tokerneliovec_Rc125e088
c020f820 sock_create_R2e010685
c020ee10 sock_alloc_R6fb1733d
c020eed0 sock_release_R4bf5d9fa
c0210d80 sock_setsockopt_Rcff29fa3
c0211200 sock_getsockopt_R41cd19a2
c020ef30 sock_sendmsg_R6c08c8a2
c020eff0 sock_recvmsg_R6e7f9216
c0211540 sk_alloc_R874a1cd6
c02115b0 sk_free_R905f3488
c020f780 sock_wake_async_R0ff39f9e
c0211a60 sock_alloc_send_skb_Rc27217eb
c02118a0 sock_alloc_send_pskb_Rcbed3fbc
c0212160 sock_init_data_R1b985d40
c0211d80 sock_no_release_R129e99ce
c0211d90 sock_no_bind_R451cf405
c0211da0 sock_no_connect_R24ef500d
c0211db0 sock_no_socketpair_Rfce496a0
c0211dc0 sock_no_accept_R3f08f48e
c0211dd0 sock_no_getname_Red286ba9
c0211de0 sock_no_poll_R926f7264
c0211df0 sock_no_ioctl_R1865ecad
c0211e00 sock_no_listen_R045d2b20
c0211e10 sock_no_shutdown_R985c1116
c0211e30 sock_no_getsockopt_Ra02eb520
c0211e20 sock_no_setsockopt_R43ebf423
c0211ec0 sock_no_sendmsg_Rc0e91c24
c0211ed0 sock_no_recvmsg_Rf445c799
c0211ee0 sock_no_mmap_R1af15246
c0211ef0 sock_no_sendpage_Ra1816ccf
c0211660 sock_rfree_Rac807970
c0211610 sock_wfree_Rcbc76824
c0211670 sock_wmalloc_Rc2ea19ee
c02116d0 sock_rmalloc_Rc5d91680
c0212cc0 skb_linearize_R6927af15
c0213990 skb_checksum_Ra75715c6
c0216170 skb_checksum_help_R05232eae
c0214830 skb_recv_datagram_R169c6b49
c0214900 skb_free_datagram_R25c880c6
c0214930 skb_copy_datagram_Raa673538
c0214970 skb_copy_datagram_iovec_Re8733712
c0214ed0 skb_copy_and_csum_datagram_iovec_R0406e743
c0213760 skb_copy_bits_Rd9655cdb
c0213c00 skb_copy_and_csum_bits_R4651e076
c0213ec0 skb_copy_and_csum_dev_R36f738a4
c0213120 skb_copy_expand_R898a6346
c02132f0 ___pskb_trim_R7318830d
c0213460 __pskb_pull_tail_Rbf5eb15e
c0212f40 pskb_expand_head_Rb6651574
c0212dd0 pskb_copy_R70ae4e6b
c0213070 skb_realloc_headroom_R0aff9b5d
c0214fe0 datagram_poll_R3332fa60
c02153d0 put_cmsg_Rf39bf4d9
c0211730 sock_kmalloc_Ra401e16c
c0211780 sock_kfree_s_R5d2f6af8
c021a870 neigh_table_init_Rab7c0f66
c021a990 neigh_table_clear_R43ae0ac5
c021a240 neigh_resolve_output_Rd1af7da9
c021a420 neigh_connected_output_R266b514d
c0219ce0 neigh_update_R5ce1a7f9
c0219130 neigh_create_R2b1172c9
c0219090 neigh_lookup_R22ffa98c
c0219b10 __neigh_event_send_R69a6ae2c
c0219fe0 neigh_event_ns_Rf2ffd2a4
c0218e20 neigh_ifdown_Rbe9ba798
c021b270 neigh_sysctl_register_Rb3565e95
c02192e0 pneigh_lookup_Rd4425aff
c021a5f0 pneigh_enqueue_R6dee46dd
c02195b0 neigh_destroy_Rb062076a
c021a700 neigh_parms_alloc_R8a88dfe2
c021a7c0 neigh_parms_release_R1f4b3432
c0218c50 neigh_rand_reach_time_R4188d439
c021a190 neigh_compat_output_Rcff64453
c0218920 dst_alloc_R4383c2bb
c02189c0 __dst_free_R41a3e56b
c0218a70 dst_destroy_Rfaf9473f
c021c810 net_ratelimit_Rf6ebc03b
c021c7d0 net_random_R1c66f64c
c021c7f0 net_srandom_Rff963ed8
c0215190 __scm_destroy_R8a7545fb
c02151d0 __scm_send_Rc7b0bff5
c02156b0 scm_fp_dup_R21523a08
c02a07e8 files_stat_R03cada27
c0214280 memcpy_toiovec_R9ceb163c
c0211c90 sklist_destroy_socket_Rcdb5438d
c0211c30 sklist_insert_socket_R5e5bfb9b
c02154a0 scm_detach_fds_Rba928267
c02d835c inetdev_lock_R8c3f0ef4
c0224140 inet_add_protocol_R0c9263ca
c02241c0 inet_del_protocol_R36a08978
c0249cf0 inet_register_protosw_R6cfc98a1
c0249db0 inet_unregister_protosw_Rbf408aa7
c0222900 ip_route_output_key_R4bd7ff71
c02220d0 ip_route_input_R28da870b
c0245b70 icmp_send_R45375dd8
c0225fc0 ip_options_compile_R190af275
c02265b0 ip_options_undo_R9721f12f
c02442e0 arp_send_R780c4d29
c02d7f00 arp_broken_ops_R741e89b8
c0220a80 __ip_select_ident_Reeb64a7e
c02284a0 ip_send_check_Ra37b7441
c0227ed0 ip_fragment_R68a9ca7c
c02d8924 inet_family_ops_R9d637c10
c021fd90 in_aton_R83e0a162
c024a8b0 ip_mc_inc_group_R7229a62c
c024a9d0 ip_mc_dec_group_Rd7b7afb4
c02284f0 ip_finish_output_R566070d9
c02d8880 inet_stream_ops_R5ac1cbfa
c02d88e0 inet_dgram_ops_Rfd333532
c0228ba0 ip_cmsg_recv_R18bf4828
c024b710 inet_addr_type_Re8cf3ae7
c0247a90 inet_select_addr_Rae178e08
c024b670 ip_dev_find_R52f904d3
c0246f70 inetdev_by_index_R39513e75
c02467c0 in_dev_finish_destroy_R51a11638
c0225540 ip_defrag_Re748f215
c024ba10 ip_rt_ioctl_R94208e84
c02473b0 devinet_ioctl_R869c80ea
c0247b80 register_inetaddr_notifier_R3e45e9ff
c0247ba0 unregister_inetaddr_notifier_R760b437a
c0324fc0 ip_statistics_Rb1579ebe
c022d4c0 tcp_read_sock_Rf388f173
c021f050 netlink_set_err_Rce6bc000
c021ee50 netlink_broadcast_R6bb8c24a
c021eba0 netlink_unicast_R24916268
c021f530 netlink_kernel_create_R25ac4f36
c021f7e0 netlink_dump_start_Rb409835b
c021f8d0 netlink_ack_R9e90f69b
c021f5c0 netlink_set_nonroot_R5a744b86
c021fb00 netlink_register_notifier_Rf78d04ab
c021fb20 netlink_unregister_notifier_Rf338d4c3
c021b890 rtattr_parse_Re49414e9
c03243a0 rtnetlink_links_R5b8f3b10
c021b920 __rta_fill_R8396e395
c021c040 rtnetlink_dump_ifinfo_R31a14c1a
c021ba80 rtnetlink_put_metrics_R385a2765
c0324380 rtnl_R1f40b4e2
c021aa40 neigh_delete_R704e9d9b
c021ab90 neigh_add_R29e5eb49
c021b1c0 neigh_dump_info_R3f5c489a
c02170e0 dev_set_allmulti_Ra1c374ff
c0217060 dev_set_promiscuity_Rbd0e9c92
c0211bc0 sklist_remove_socket_R2c037db5
c02d72e0 rtnl_sem_R511d0ebe
c021b830 rtnl_lock_Rc7a4fbed
c021b850 rtnl_unlock_R6e720ff2
c020ea60 move_addr_to_kernel_R5dfa4696
c020eab0 move_addr_to_user_R38c99093
c0325de4 ipv4_config_R26b99782
c0215ea0 dev_open_Ra9f0d2dc
c0245840 xrlim_allow_Rf6a1110d
c02244b0 ip_rcv_Rd9b292b9
c0244a90 arp_rcv_Rb68c1842
c02d7f20 arp_tbl_R511efdbc
c02440a0 arp_find_R70a122d1
c0216060 register_netdevice_notifier_R63ecad53
c0216080 unregister_netdevice_notifier_Rfe769456
c02ac380 loopback_dev_R239ff3d6
c02179a0 register_netdevice_Rc6a0bb07
c0217bb0 unregister_netdevice_R76435f03
c0215d90 netdev_state_change_R3a61e626
c0217950 dev_new_index_R8fddc84c
c0215bb0 dev_get_by_index_R18d59091
c0215b90 __dev_get_by_index_R11c83e41
c0215b50 dev_get_by_name_R19108241
c0215b00 __dev_get_by_name_Rbac12f5a
c0217ae0 netdev_finish_unregister_R0835c67d
c0216f60 netdev_set_master_Ra0dd4e73
c021d6a0 eth_type_trans_R433f0a48
c02124b0 alloc_skb_Rc6668f06
c02127f0 __kfree_skb_Rfda6b103
c0212940 skb_clone_R7ae70048
c0212bd0 skb_copy_R5423e626
c0216510 netif_rx_R9390a461
c02167f0 netif_receive_skb_R5a80ce34
c02158b0 dev_add_pack_R2d10d613
c0215920 dev_remove_pack_R89b8af4b
c0215b70 dev_get_R79259fbc
c0215d10 dev_alloc_Rd68dfe2d
c0215c70 dev_alloc_name_R08fdff8b
c021dc10 __netdev_watchdog_up_R362863b2
c0215df0 dev_load_Ra90fd3b7
c02176c0 dev_ioctl_R387c78a5
c0216210 dev_queue_xmit_R77937673
c02ac4d4 dev_base_Raeb0ceab
c02ac4d8 dev_base_lock_R5b3f9c07
c0215f80 dev_close_R05a9d69f
c02183f0 dev_mc_add_R7781b72a
c02182f0 dev_mc_delete_R278228bc
c02182b0 dev_mc_upload_R9d6af706
c0147420 __kill_fasync_R0d6e22aa
c02d6e14 if_port_text_R9cf0c64f
c02d6b60 sysctl_wmem_max_Rfac8865f
c02d6b64 sysctl_rmem_max_Rb05fc310
c02d7b5c sysctl_ip_default_ttl_Rf6388c56
c021e040 qdisc_destroy_R6b5be6bf
c021e020 qdisc_reset_R6839234d
c021da20 qdisc_restart_Re1bd5220
c021df70 qdisc_create_dflt_Rdb1be69d
c02d7500 noop_qdisc_Rcbc7c4bd
c02d74c0 qdisc_tree_lock_R47e4f658
c021c8a0 nf_register_hook_R900409b7
c021c910 nf_unregister_hook_R8b696e09
c021c950 nf_register_sockopt_R9ea3fc6a
c021ca30 nf_unregister_sockopt_R19c3d08c
c021d090 nf_reinject_R37301516
c021ccf0 nf_register_queue_handler_R3544320d
c021cd50 nf_unregister_queue_handler_R4df6e6de
c021cf00 nf_hook_slow_R48872757
c0324440 nf_hooks_R078b1fd2
c021cbd0 nf_setsockopt_R7bed2f71
c021cc10 nf_getsockopt_R5f6faf64
c0324c40 ip_ct_attach_R7e15bffe
c021d250 ip_route_me_harder_R452b21f4
c0216b80 register_gifconf_Rfe5677d1
c02f6c80 softnet_data_Rae426a01
c0255b20 memparse_R23f2d36f
c0255a60 get_option_Rb0e10781
c0255ad0 get_options_R0fbff9b9
c0255c10 rb_insert_color_Raa2b5a22
c0255ec0 rb_erase_Rda226a80
c0255fb0 rwsem_down_read_failed
c0255ff0 rwsem_down_write_failed
c0256030 rwsem_wake
c0257cb0 zlib_inflate_workspacesize_Rce5ac24f
c0257ee0 zlib_inflate_R64cf8602
c0257eb0 zlib_inflateInit__R456e911d
c0257da0 zlib_inflateInit2__R5d3b34e2
c0257d40 zlib_inflateEnd_R9ef45f92
c0258320 zlib_inflateSync_R34582e0d
c0257cc0 zlib_inflateReset_Ref76d642
c0258410 zlib_inflateSyncPoint_R41d10449
c0258590 zlib_inflateIncomp_Rb5058135

--Boundary-00=_WjJ7+Iw98lmJuU+
Content-Type: text/plain;
  charset="iso-8859-15";
  name="capture.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="capture.txt"

=0Dcapifs: Rev 1.1.4.1
=0DCAPI-driver Rev 1.1.4.1: loaded
=0Dcapi20: started up with major 68
=0Dkcapi: capi20 attached
=0Dcapi20: Rev 1.1.4.2: started up with major 68 (middleware+capifs)
=0DCSLIP: code copyright 1989 Regents of the University of California
=0DISDN subsystem Rev: 1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1 load=
ed
=0Dkcapi: capidrv attached
=0Dkcapi: appl 1 up
=0Dcapidrv: Rev 1.1.4.1: loaded
=0Db1: revision 1.1.4.1
=0Db1isa: revision 1.1.4.1
=0Dkcapi: driver b1isa attached
=0Dkcapi: Controller 1: b1isa-150 attached
=0Db1isa: AVM B1 ISA at i/o 0x150, irq 5, revision 255
=0Db1isa-150: card 1 "B1" ready.
=0Db1isa-150: card 1 Protocol: DSS1
=0Db1isa-150: card 1 Linetype: point to multipoint
=0Db1isa-150: B1-card (3.09-10) now active
=0Dkcapi: card 1 "b1isa-150" ready.
=0Dkcapi: notify up contr 1
=0Dcapidrv: controller 1 up
=0Dcapidrv-1: now up (2 B channels)
=0Dcapidrv-1: D2 trace enabled
=0Dcapi: controller 1 up
=0Dkcapi: appl 2 up
=0Dcapidrv-1: incoming call 2663919395,1,2,919394
=0Dcapidrv-1: patching si2=3D2 to 0 for VBOX
=0Disdn_net: call from 2663919395 -> 0 919394 ignored
=0Disdn_tty: call from 2663919395 -> 919394 ignored
=0Dcapidrv-1: incoming call 2663919395,1,0,919394 ignored
=0Dkcapi: appl 2 ncci 0x10101 up
=0Dkcapi: appl 2 ncci 0x10101 down
=0Dkcapi: recv_handler: applid 2 is releasing
=0Dkcapi: appl 2 down
=0Dkcapi: recv_handler: applid 2 has no signal function
=0DWarning: kfree_skb passed an skb still on a list (from d88aff73).
=0Dkernel BUG at skbuff.c:315!
=0Dinvalid operand: 0000
=0DCPU:    0
=0DEIP:    0010:[<c0212924>]    Not tainted
=0DEFLAGS: 00010282
=0Deax: 00000045   ebx: d7d463b8   ecx: 00000001   edx: d79bc000
=0Desi: d7d463b8   edi: 00000080   ebp: 00000046   esp: c02ddef0
=0Dds: 0018   es: 0018   ss: 0018
=0DProcess swapper (pid: 0, stackpage=3Dc02dd000)
=0DStack: c028bb80 d88aff73 d7d463b8 00000002 d88aff73 d7d463b8 00000002 c0=
120afd=20
=0D       c02ddf24 c02ddf24 fffffffe c011d64a 00000000 d88b6844 d88b6844 00=
000000=20
=0D       c02f6b60 c012064d c029fae0 c011d582 c011d496 00000009 00000001 c0=
11d2d5=20
=0DCall Trace:    [<d88aff73>] [<d88aff73>] [<c0120afd>] [<c011d64a>] [<d88=
b6844>]
=0D  [<d88b6844>] [<c012064d>] [<c011d582>] [<c011d496>] [<c011d2d5>] [<c01=
08b1e>]
=0D  [<c010b1b8>] [<c0105383>] [<c0113055>] [<c0112fa0>] [<c0112fa0>] [<c01=
05412>]
=0D  [<c0105000>]

=0DCode: 0f 0b 3b 01 c7 ad 28 c0 8b 5c 24 14 e9 ce fe ff ff 8d 74 26=20
=0D <0>Kernel panic: Aiee, killing interrupt handler!
=0DIn interrupt handler - not syncing
=0D <6>keyboard: unknown scancode e0 64
=0D
--Boundary-00=_WjJ7+Iw98lmJuU+
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="kcapi.c.releasing2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kcapi.c.releasing2.patch"

--- kcapi.c.orig	2003-05-13 17:19:36.000000000 +0200
+++ kcapi.c	2003-05-13 17:19:46.000000000 +0200
@@ -73,7 +73,7 @@
 struct capi_appl {
 	__u16 applid;
 	capi_register_params rparam;
-	int releasing;
+	atomic_t releasing;
 	void *param;
 	void (*signal) (__u16 applid, void *param);
 	struct sk_buff_head recv_queue;
@@ -705,8 +705,7 @@
 			nextpp = &(*pp)->next;
 		}
 	}
-	APPL(appl)->releasing--;
-	if (APPL(appl)->releasing <= 0) {
+	if (atomic_dec_and_test(&APPL(appl)->releasing)) {
 		APPL(appl)->signal = 0;
 		APPL_MARK_FREE(appl);
 		printk(KERN_INFO "kcapi: appl %d down\n", appl);
@@ -793,6 +792,12 @@
 			kfree_skb(skb);
 			continue;
 		}
+	        if (atomic_read(&APPL(appl)->releasing)) {
+			printk(KERN_ERR "kcapi: recv_handler: applid %d is releasing\n",
+				appl);
+			kfree_skb(skb);
+			continue;
+		}
 		if (APPL(appl)->signal == 0) {
 			printk(KERN_ERR "kcapi: recv_handler: applid %d has no signal function\n",
 			       appl);
@@ -869,7 +874,7 @@
 
 	for (appl = 1; appl <= CAPI_MAXAPPL; appl++) {
 		if (!VALID_APPLID(appl)) continue;
-		if (APPL(appl)->releasing) continue;
+		if (atomic_read(&APPL(appl)->releasing)) continue;
 		card->driver->register_appl(card, appl, &APPL(appl)->rparam);
 	}
 
@@ -1117,6 +1122,7 @@
 	APPL_MARK_USED(appl);
 	skb_queue_head_init(&APPL(appl)->recv_queue);
 	APPL(appl)->nncci = 0;
+	atomic_set(&APPL(appl)->releasing,0);
 
 	memcpy(&APPL(appl)->rparam, rparam, sizeof(capi_register_params));
 
@@ -1136,19 +1142,18 @@
 {
 	int i;
 
-	if (!VALID_APPLID(applid) || APPL(applid)->releasing)
+	if (!VALID_APPLID(applid) || atomic_read(&APPL(applid)->releasing))
 		return CAPI_ILLAPPNR;
-	APPL(applid)->releasing++;
+	atomic_inc(&APPL(applid)->releasing);
 	skb_queue_purge(&APPL(applid)->recv_queue);
 	for (i = 0; i < CAPI_MAXCONTR; i++) {
 		if (cards[i].cardstate != CARD_RUNNING)
 			continue;
-		APPL(applid)->releasing++;
+	        atomic_inc(&APPL(applid)->releasing);
 		cards[i].driver->release_appl(&cards[i], applid);
 	}
-	APPL(applid)->releasing--;
-	if (APPL(applid)->releasing <= 0) {
-	        APPL(applid)->signal = 0;
+	if (atomic_dec_and_test(&APPL(applid)->releasing)) {
+		APPL(applid)->signal = 0;
 		APPL_MARK_FREE(applid);
 		printk(KERN_INFO "kcapi: appl %d down\n", applid);
 	}

--Boundary-00=_WjJ7+Iw98lmJuU+--

