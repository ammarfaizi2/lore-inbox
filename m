Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbTDVSn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbTDVSn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:43:27 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:12729 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263347AbTDVSnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:43:25 -0400
Date: Tue, 22 Apr 2003 20:55:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: Michael Hunold <michael@mihu.de>
Subject: top stack (l)users for 2.5.68
Message-ID: <20030422185532.GB12947@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

45 functions for 2.5.68, 44 for 2.5.67. The new one is this:
0xc0881136 mxb_init_done:                                sub    $0x51c,%esp

Michael, are there any reasons not to make saa7740_init static, global
or both? The memory is gone forever either way.
Moreover, wouldn't this be a candidate for __init and __initdata
respectively?

Apart from that, patches for the marked (P) functions are in -je1, but
might need some shaping up. Handle with care.

Everything else remains unchanged since 2.5.67.

P 0xc0227526 presto_get_fileid:                            sub    $0x1198,%esp
P 0xc0225d16 presto_copy_kml_tail:                         sub    $0x1028,%esp
P 0xc09c07ed gdth_ioctl:                                   sub    $0xb7c,%esp
0xc0914d78 ide_unregister:                               sub    $0xa0c,%esp
0xc0843f3b v4l_compat_translate_ioctl:                   sub    $0x8d4,%esp
0xc08d5f73 ia_ioctl:                                     sub    $0x84c,%esp
0xc0e733d3 snd_emu10k1_fx8010_ioctl:                     sub    $0x830,%esp
0xc085e976 w9966_v4l_read:                               sub    $0x828,%esp
0xc0e03ccb snd_cmipci_ac3_copy:                          sub    $0x7c0,%esp
0xc0e042eb snd_cmipci_ac3_silence:                       sub    $0x7c0,%esp
P 0xc0ac6248 amd_flash_probe:                              sub    $0x72c,%esp
0xc0105650 huft_build:                                   sub    $0x59c,%esp
0xc01073d0 huft_build:                                   sub    $0x59c,%esp
0xc02e2966 dohash:                                       sub    $0x594,%esp
0xc0108256 inflate_dynamic:                              sub    $0x554,%esp
P 0xc05ebec3 ida_ioctl:                                    sub    $0x54c,%esp
0xc01064a6 inflate_dynamic:                              sub    $0x538,%esp
P 0xc0fe67f3 device_new_if:                                sub    $0x520,%esp
0xc0881136 mxb_init_done:                                sub    $0x51c,%esp
0xc021bef6 presto_ioctl:                                 sub    $0x508,%esp
0xc0e6d668 snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
0xc0e951e6 snd_trident_mixer:                            sub    $0x4c0,%esp
0xc0106307 inflate_fixed:                                sub    $0x4ac,%esp
0xc01080b7 inflate_fixed:                                sub    $0x4ac,%esp
0xc092c491 ide_config:                                   sub    $0x4a8,%esp
0xc05cff3c parport_config:                               sub    $0x490,%esp
0xc0c12366 sw_connect:                                   sub    $0x490,%esp
0xc0c36c73 ixj_config:                                   sub    $0x484,%esp
0xc0c18ef1 uinput_alloc_device:                          sub    $0x480,%esp
0xc10d43e6 sctp_hash_digest:                             sub    $0x45c,%esp
0xc1074493 gss_pipe_downcall:                            sub    $0x450,%esp
0xc03ba218 ciGetLeafPrefixKey:                           sub    $0x428,%esp
0xc0b73c60 isd200_action:                                sub    $0x424,%esp
0xc045d913 befs_error:                                   sub    $0x418,%esp
0xc045d983 befs_warning:                                 sub    $0x418,%esp
0xc045d9f3 befs_debug:                                   sub    $0x418,%esp
0xc07bcf76 wv_hw_reset:                                  sub    $0x418,%esp
0xc16bf115 root_nfs_name:                                sub    $0x414,%esp
0xc0c5d6f2 bt3c_config:                                  sub    $0x410,%esp
0xc0c61862 btuart_config:                                sub    $0x410,%esp
0xc07772f1 hex_dump:                                     sub    $0x40c,%esp
0xc032fa17 jffs2_rtime_compress:                         sub    $0x408,%esp
0xc0c5bc8f dtl1_config:                                  sub    $0x408,%esp
0xc0c5fb06 bluecard_config:                              sub    $0x408,%esp
0xc032fb15 jffs2_rtime_decompress:                       sub    $0x404,%esp


Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
