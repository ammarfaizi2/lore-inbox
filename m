Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTDNRTL (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTDNRTL (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:19:11 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:19944 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263580AbTDNRTG (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:19:06 -0400
Date: Mon, 14 Apr 2003 19:30:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.67
Message-ID: <20030414173047.GJ10347@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5 seems to be getting some driver care, lately. Compared to 2.5.64,
far less drivers were removed after make allyesconfig.

Again, all functions using >1k stack frame on i386.

44 functions for .67, .64 still had 51, things are getting better here
as well.

Is intermezzo still actively maintained? I submitted patches for those
two presto-functions several weeks ago and didn't notice any feedback.

0xc0221fe6 presto_get_fileid:                            sub    $0x1194,%esp
0xc02209a6 presto_copy_kml_tail:                         sub    $0x1028,%esp
0xc099bd9d gdth_ioctl:                                   sub    $0xb7c,%esp
0xc08f2548 ide_unregister:                               sub    $0x988,%esp
0xc082d9ab v4l_compat_translate_ioctl:                   sub    $0x8d4,%esp
0xc08b3743 ia_ioctl:                                     sub    $0x84c,%esp
0xc0e4a013 snd_emu10k1_fx8010_ioctl:                     sub    $0x830,%esp
0xc084c6c6 w9966_v4l_read:                               sub    $0x828,%esp
0xc0ddb53b snd_cmipci_ac3_copy:                          sub    $0x7c0,%esp
0xc0ddbb5b snd_cmipci_ac3_silence:                       sub    $0x7c0,%esp
0xc0aa10c8 amd_flash_probe:                              sub    $0x72c,%esp
0xc0105650 huft_build:                                   sub    $0x59c,%esp
0xc01073d0 huft_build:                                   sub    $0x59c,%esp
0xc02d9c56 dohash:                                       sub    $0x594,%esp
0xc0108256 inflate_dynamic:                              sub    $0x554,%esp
0xc05e2733 ida_ioctl:                                    sub    $0x54c,%esp
0xc01064a6 inflate_dynamic:                              sub    $0x538,%esp
0xc0fb00e3 device_new_if:                                sub    $0x520,%esp
0xc0216b86 presto_ioctl:                                 sub    $0x508,%esp
0xc0e44368 snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
0xc0e68646 snd_trident_mixer:                            sub    $0x4b4,%esp
0xc0106307 inflate_fixed:                                sub    $0x4ac,%esp
0xc01080b7 inflate_fixed:                                sub    $0x4ac,%esp
0xc0909bc1 ide_config:                                   sub    $0x4a8,%esp
0xc0f9d5db br_ioctl_device:                              sub    $0x498,%esp
0xc05c6bbc parport_config:                               sub    $0x490,%esp
0xc0bec486 sw_connect:                                   sub    $0x490,%esp
0xc0c105c3 ixj_config:                                   sub    $0x484,%esp
0xc0bf3011 uinput_alloc_device:                          sub    $0x480,%esp
0xc10b3d76 sctp_hash_digest:                             sub    $0x45c,%esp
0xc103e443 gss_pipe_downcall:                            sub    $0x450,%esp
0xc03b1268 ciGetLeafPrefixKey:                           sub    $0x428,%esp
0xc0454b53 befs_error:                                   sub    $0x418,%esp
0xc0454bc3 befs_warning:                                 sub    $0x418,%esp
0xc0454c33 befs_debug:                                   sub    $0x418,%esp
0xc07b1256 wv_hw_reset:                                  sub    $0x414,%esp
0xc16bcec5 root_nfs_name:                                sub    $0x414,%esp
0xc0c37b42 bt3c_config:                                  sub    $0x410,%esp
0xc0c3bcc2 btuart_config:                                sub    $0x410,%esp
0xc076cb71 hex_dump:                                     sub    $0x40c,%esp
0xc0326c17 jffs2_rtime_compress:                         sub    $0x408,%esp
0xc0c360ff dtl1_config:                                  sub    $0x408,%esp
0xc0c39f56 bluecard_config:                              sub    $0x408,%esp
0xc0326d15 jffs2_rtime_decompress:                       sub    $0x404,%esp

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
