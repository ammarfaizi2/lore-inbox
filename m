Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265422AbUEZKTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUEZKTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265412AbUEZKTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:19:21 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:20362 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265422AbUEZKTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:19:06 -0400
Date: Wed, 26 May 2004 12:17:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: William Lee Irwin III <wli@holomorphy.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040526101742.GD12142@wohnheim.fh-wedel.de>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org> <20040517233515.GR5414@waste.org> <20040519102846.GG1223@holomorphy.com> <20040519120138.GI1223@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040519120138.GI1223@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004 05:01:38 -0700, William Lee Irwin III wrote:
> On Mon, May 17, 2004 at 06:35:15PM -0500, Matt Mackall wrote:
> >> I have a cleaned up version of this script in -tiny which is a bit
> >> nicer for adding new arches to and produces simpler output:
> >>  1428 huft_build
> >>  1292 inflate_dynamic
> >>  1168 inflate_fixed
> >>   528 ip_setsockopt
> >>   496 tcp_check_req
> >>   496 tcp_v4_conn_request
> >>   484 tcp_timewait_state_process
> >>   440 ip_getsockopt
> >>   408 extract_entropy
> >>   364 shrink_zone
> >>   324 do_execve
> 
> On Wed, May 19, 2004 at 03:28:46AM -0700, William Lee Irwin III wrote:
> > By eyeballing things, I see >= 384B on-stack in ep_send_events(). Hence:
> 
> I might as well hit something higher up in the list. Does this help
> ip_setsockopt() any (untested)?

If you have time for this, here are some more. :)
First list is my running kernel, second is with allmodconfig (sans
aic7*, which doesn't compile).

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein

0xc021a736 ide_unregister:                              1552
0xc01003ab huft_build:                                  1436
0xc01010e4 inflate_dynamic:                             1340
0xc0100f62 inflate_fixed:                               1196
0x0214 orinoco_cs_config:                               984
0x000046c4 arlan_sysctl_info:                           936
0x0239 atmel_config:                                    920
0x00002b34 wv_hw_reset:                                 916
0x023f airo_config:                                     912
0xc019f22d nfs_writepage_sync:                          904
0xc027a4e0 snd_pcm_hw_refine_old_user:                  892
0xc027a5b0 snd_pcm_hw_params_old_user:                  892
0xc019d90b nfs_readpage_sync:                           872
0x0000456b setup_card:                                  860
0x00000434 mhz_mfc_config:                              716
0x00000df0 ds_ioctl:                                    708
0x00000750 has_ce2_string:                              688
0x00000636 mhz_setup:                                   684
0x000008a8 smc_config:                                  684
0x00000994 smc_setup:                                   684
0x000003d9 axnet_config:                                668
0x000006fc pcnet_config:                                660
0xc01abcb6 nlmclnt_proc:                                656
0xc0288676 snd_pcm_oss_get_formats:                     652
0xc01ac77b nlmclnt_reclaim:                             640



0x00002178 CpqTsProcessIMQEntry:                        2064
0x0000203a PeekIMQEntry:                                2052
0x000064f5 ioc_rescan:                                  1568
0x00006387 ioc_hdrlist:                                 1528
0xc01005ed huft_build:                                  1444
0xc0101225 inflate_dynamic:                             1312
0x00007b11 send_panic_events:                           1268
0xc01010ce inflate_fixed:                               1168
0x01f0 ide_config:                                      1168
0x016e parport_config:                                  1144
0x02e4 ixj_config:                                      1144
0x00000502 gdth_get_info:                               1076
0x0000d8e9 nfsd4_proc_compound:                         1024
0x00004d45 zoran_do_ioctl:                              1020
0x00000de8 bt3c_config:                                 1016
0x0bb0 btuart_config:                                   1016
0x0000030e snd_mixart_add_ref_pipe:                     1016
0x0171 sedlbauer_config:                                1012
0x00000ee0 bluecard_config:                             1012
0x0c7b dtl1_config:                                     1012
0x00003e72 ixgb_ethtool_ioctl:                          1008
0x00010ac2 dohash:                                      1004
0x0000113e wavefront_load_gus_patch:                    984
0x00001a16 nsp_cs_config:                               980
0x0197 orinoco_cs_config:                               968
0x0000a1c8 Vpd:                                         960
0x00000305 mgslpc_config:                               956
0x00019d42 nfs_direct_write_seg:                        952
0x00007b7e cpqhp_set_irq:                               948
0x000049b5 arlan_sysctl_info:                           936
0x0013 com90xx_probe:                                   928
0x000096fe nfs_writepage_sync:                          920
0x00002adf wv_hw_reset:                                 912
0x00006e9d cs46xx_dsp_scb_and_task_init:                912
0x01b1 airo_config:                                     904
0x01b0 atmel_config:                                    900
0x00008147 nfs_readpage_sync:                           888
0x000199db nfs_direct_read_seg:                         888
0x00009546 sig_ind:                                     884
0x00007201 snd_pcm_hw_refine_old_user:                  868
0x0000727c snd_pcm_hw_params_old_user:                  868
0x000037cd setup_card:                                  852
0x000035e2 hfsplus_readdir:                             852
0x00000006 sha512_transform:                            844
0x000019c3 sb1000_dev_ioctl:                            824
0x00000210 NFTL_foldchain:                              816
0x00007164 isd200_action:                               812
0x00003eb5 calculate_clipping_registers_rect:           808
0xc0210449 calc_mode_timings:                           804
0x00001e4a netdev_ethtool_ioctl:                        796
0x0000198f get_ports:                                   788
0x069c multi_config:                                    764
0x03c6 simple_config:                                   760
0x00001982 add_card:                                    760
0x00002a23 atp870u_probe:                               756
0x00000257 INFTL_foldchain:                             752
0x00000c2e restore_mixer_state:                         728
0x00000b6b save_mixer_state:                            724
0x00008686 SkPnmiGetStruct:                             716
0x0208 elsa_cs_config:                                  708
0x0208 teles_cs_config:                                 708
0x0000034a mhz_mfc_config:                              704
0x00011582 nfsd4_encode_fattr:                          704
0x09a7 serial_config:                                   692
0x00000d35 ds_ioctl:                                    680
0x000004f5 mhz_setup:                                   676
0x000037f4 ncp_ioctl:                                   676
0x000006d5 smc_config:                                  672
0x00000783 smc_setup:                                   672
0x0000055d has_ce2_string:                              672
0x00000523 nlmclnt_proc:                                664
0x000078d4 reiserfs_rename:                             660
0x0254 avma1cs_config:                                  652
0x0000029e axnet_config:                                648
0x00001a45 snd_pcm_oss_get_formats:                     648
0x0000051d pcnet_config:                                644
0x00000f38 nlmclnt_reclaim:                             644
0x00001404 ncp_create_new:                              644
0x00001645 ncp_mkdir:                                   644
0x000011a4 ncp_lookup:                                  640

