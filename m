Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265905AbUFXW70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbUFXW70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUFXW7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:59:25 -0400
Received: from math.ut.ee ([193.40.5.125]:47353 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265905AbUFXW53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:57:29 -0400
Date: Fri, 25 Jun 2004 01:57:27 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: OOPS from ext3_follow_link in 2.6.7+BK
Message-ID: <Pine.GSO.4.44.0406250153410.8143-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today evenings BK snapshot oopsed on starting X:

Unable to handle kernel paging request at virtual address 2601c78c
 printing eip:
c018d17c
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: binfmt_misc md5 ipv6 ipt_MASQUERADE iptable_nat ipt_REJECT ipt_LOG ipt_state ip_conntrack iptable_filter ip_tables cls_u32 sch_sfq sch_cbq usb_storage snd_bt87x uhci_hcd usbcore vfat fat md dm_mod eeprom via686a i2c_sensor parport_pc lp parport snd_via82xx snd_mpu401_uart snd_ens1371 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd sd_mod scsi_mod mga ide_cd cdrom floppy tuner tvaudio msp3400 bttv video_buf v4l2_common btcx_risc videodev soundcore analog gameport joydev 8139too mii
CPU:    0
EIP:    0060:[<c018d17c>]    Not tainted
EFLAGS: 00010282   (2.6.7)
EIP is at ext3_follow_link+0xc/0x50
eax: d4643614   ebx: c02e9500   ecx: d4643580   edx: d470ef1c
esi: d47249bc   edi: d470ef1c   ebp: 00000400   esp: d470ef10
ds: 007b   es: 007b   ss: 0068
Process X (pid: 2752, threadinfo=d470e000 task=d7974090)
Stack: c01594ff c0113c86 bffff8d0 d470ef70 d7fbd160 d47249bc 00003cb7 d7bcb009
       00000001 d7fca400 d4643614 40db5aa4 0eeccb38 d4643650 c0161f48 40db5aa4
       0eeccb38 40db5aa4 0eeccb38 c02e9500 00000400 d4643614 d470ef70 c0152fcd
Call Trace:
 [<c01594ff>] generic_readlink+0x2f/0x80
 [<c0113c86>] do_page_fault+0x2e6/0x4c1
 [<c0161f48>] update_atime+0xb8/0xc0
 [<c0152fcd>] sys_readlink+0x9d/0xb0
 [<c0103e75>] sysenter_past_esp+0x52/0x71
Code: 89 4c 82 20 31 c0 c3 90 90 90 90 90 90 90 90 90 90 90 90 90

-- 
Meelis Roos (mroos@linux.ee)

