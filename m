Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTE2KgI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTE2KgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:36:07 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:55483 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262127AbTE2KgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:36:06 -0400
Date: Thu, 29 May 2003 12:49:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: chas@cmf.nrl.navy.mil
Subject: top stack users for 2.5.70
Message-ID: <20030529104921.GB17252@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

44 functions for 2.5.67.
45 functions for 2.5.68
41 functions for 2.5.69
36 functions for 2.5.70

Things have improved again, but we have one newcomer:
0xc170fd38 he_init_cs_block_rcm:                         sub    $0x42c,%esp

Chas, the 1k array should be ok for an init function, but you might
want to give it another thought anyway.  Maybe make it static
__init_data, that way it will remain simple and and doesn't waste any
ram.

P 0xc022cba6 presto_get_fileid:                            sub    $0x1198,%esp
P 0xc022b396 presto_copy_kml_tail:                         sub    $0x1028,%esp
0xc0920538 ide_unregister:                               sub    $0x96c,%esp
0xc0e7a483 snd_emu10k1_fx8010_ioctl:                     sub    $0x830,%esp
0xc086dc86 w9966_v4l_read:                               sub    $0x828,%esp
0xc0e0ac0b snd_cmipci_ac3_copy:                          sub    $0x7c0,%esp
0xc0e0b22b snd_cmipci_ac3_silence:                       sub    $0x7c0,%esp
P 0xc0acd878 amd_flash_probe:                              sub    $0x72c,%esp
0xc0105650 huft_build:                                   sub    $0x59c,%esp
0xc01073d0 huft_build:                                   sub    $0x59c,%esp
0xc02e94f6 dohash:                                       sub    $0x594,%esp
0xc0108256 inflate_dynamic:                              sub    $0x554,%esp
P 0xc05f54e3 ida_ioctl:                                    sub    $0x550,%esp
0xc01064a6 inflate_dynamic:                              sub    $0x538,%esp
0xc0221586 presto_ioctl:                                 sub    $0x508,%esp
0xc0e74748 snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
0xc0e9c2b6 snd_trident_mixer:                            sub    $0x4c0,%esp
0xc0106307 inflate_fixed:                                sub    $0x4ac,%esp
0xc01080b7 inflate_fixed:                                sub    $0x4ac,%esp
0xc0937df1 ide_config:                                   sub    $0x4a8,%esp
0xc05d9a4c parport_config:                               sub    $0x490,%esp
0xc0c3f4b3 ixj_config:                                   sub    $0x484,%esp
0xc1084bc3 gss_pipe_downcall:                            sub    $0x450,%esp
0xc170fd38 he_init_cs_block_rcm:                         sub    $0x42c,%esp
0xc03c4d28 ciGetLeafPrefixKey:                           sub    $0x428,%esp
0xc046baf3 befs_error:                                   sub    $0x418,%esp
0xc046bb63 befs_warning:                                 sub    $0x418,%esp
0xc046bbd3 befs_debug:                                   sub    $0x418,%esp
0xc07ca0d6 wv_hw_reset:                                  sub    $0x418,%esp
0xc16c9215 root_nfs_name:                                sub    $0x414,%esp
0xc0c63612 bt3c_config:                                  sub    $0x410,%esp
0xc0c67722 btuart_config:                                sub    $0x410,%esp
0xc0336757 jffs2_rtime_compress:                         sub    $0x408,%esp
0xc0c61bdf dtl1_config:                                  sub    $0x408,%esp
0xc0c659f6 bluecard_config:                              sub    $0x408,%esp
0xc0336855 jffs2_rtime_decompress:                       sub    $0x404,%esp

Jörn

-- 
The only real mistake is the one from which we learn nothing.
-- John Powell
