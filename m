Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbULAXeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbULAXeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbULAXeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:34:06 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:53553 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261492AbULAXdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:33:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=MPZljWKn+Ak06NXxB+j9rWNfVAWShLXE7NLUW4VRU1pnaPReu/AIzDXJ7K0oPDznopwwLeyTs58cZW7jF8d7eWvAqvk+/Ntps4rjIj9/ogja7f4a8VcS4b35UYZhpVP4O5CfgH7aCqeuwD+HNxZAa3V7aLXzPGQoq7LKvLZi3Kw=
Message-ID: <79a6fb1e041201153328fed785@mail.gmail.com>
Date: Wed, 1 Dec 2004 23:33:44 +0000
From: Ruben Fonseca <fonseka@gmail.com>
Reply-To: Ruben Fonseca <fonseka@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ReiserFS 4 BUG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

happen with 2.6.10-rc2-mm2 and mm3 (and maybe latter, but didn't notive this)

when installing PHP or OpenOffice, the instalation break and kernel says:

------------[ cut here ]------------
kernel BUG at fs/reiser4/plugin/file/tail_conversion.c:58!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: ipw2100 ieee80211 ieee80211_crypt eth1394 ohci_hcd
parport_pc parport ohci1394 ieee1394 ehci_hcd uhci_hcd joydev evdev
snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device nls_iso8859_1 ntfs snd_intel8x0 snd_ac97_codec snd_pcm
snd_timer snd snd_page_alloc
CPU:    0
EIP:    0060:[<c022e438>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-rc2-mm3) 
EIP is at get_nonexclusive_access+0x28/0x40
eax: c390df1c   ebx: cc106d30   ecx: d67c2340   edx: cc106cd8
esi: cc106d00   edi: cc106cd8   ebp: d673c5f4   esp: c390dc7c
ds: 007b   es: 007b   ss: 0068
Process setup.bin (pid: 15101, threadinfo=c390c000 task=d5fb3540)
Stack: c022cff7 cc106cd8 d7076800 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c022cff7>] unix_file_filemap_nopage+0x67/0xd0
 [<c022cf90>] unix_file_filemap_nopage+0x0/0xd0
 [<c014fc77>] do_no_page+0xd7/0x3a0
 [<c0150241>] handle_mm_fault+0x1d1/0x210
 [<c014e3e5>] follow_page+0x25/0x30
 [<c014e59a>] get_user_pages+0x16a/0x3e0
 [<c022c466>] reiser4_get_user_pages+0x96/0xc0
 [<c022d570>] write_unix_file+0x300/0x450
 [<c01e29f5>] init_context+0x75/0xc0
 [<c01fcc2f>] reiser4_write+0x8f/0x100
 [<c0160e5a>] vfs_write+0x13a/0x180
 [<c0161f49>] fget_light+0x89/0xa0
 [<c0160f71>] sys_write+0x51/0x80
 [<c01032c1>] sysenter_past_esp+0x52/0x71
Code: 00 00 00 b8 00 e0 ff ff 21 e0 8b 00 8b 54 24 04 8b 80 b8 04 00
00 8b 40 3c 8b 48 08 85 c9 75 0b 89 d0 ff 00 0f 88 8b 12 00 00 c3 <0f>
0b 3a 00 38 f7 41 c0 eb eb 8d b4 26 00 00 00 00 8d bc 27 00

after that the system becomes unusable.. have to reboot....

no data damaged, but can't install those applications :(
