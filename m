Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVAXAh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVAXAh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVAXAh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:37:59 -0500
Received: from smtp.ono.com ([62.42.230.12]:9008 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S261392AbVAXAho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:37:44 -0500
Message-ID: <41F4434E.50000@usuarios.retecal.es>
Date: Mon, 24 Jan 2005 01:37:34 +0100
From: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <rrey@usuarios.retecal.es>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: reiserfs-dev@namesys.com
CC: linux-kernel@vger.kernel.org
Subject: [2.6.11-rc2] kernel BUG at fs/reiserfs/journal.c:2966!
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I get this with 2.6.11-rc2

kernel BUG at fs/reiserfs/journal.c:2966!
invalid operand: 0000 [#1]
Modules linked in: r128 ipt_state iptable_filter iptable_nat
ip_conntrack ip_tables 8139too mii crc32 snd_ens1371 snd_rawmidi
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
snd_page_alloc gameport uhci_hcd via_agp floppy ide_cd cdrom
CPU:    0
EIP:    0060:[<c01936d0>]    Not tainted VLI
EFLAGS: 00210203   (2.6.11-rc2)
EIP is at journal_end+0x50/0xe0
eax: cf48d400   ebx: c4040e6c   ecx: 0004b7fd   edx: cf48d400
esi: c4040e64   edi: 00000001   ebp: c8fc091c   esp: c4040e54
ds: 007b   es: 007b   ss: 0068
Process d4x (pid: 18036, threadinfo=c4040000 task=c26ddaa0)
Stack: c8fc091c c4040e64 00000000 c0183fdf cf48d400 00000001 00000002
00000000
~       0004b7fd 00000000 0864d53b c4040e88 c4040e88 c4040e88 c4040e88
00000000
~       00000007 c8fc091c c0160b04 00000000 c8fc091c c8fc09bc cf48d400
3b9aca00
Call Trace:
~ [<c0183fdf>] reiserfs_dirty_inode+0x5f/0x80
~ [<c0160b04>] __mark_inode_dirty+0x164/0x180
~ [<c015a214>] inode_setattr+0x94/0x1c0
~ [<c017d028>] reiserfs_setattr+0x148/0x1c0
~ [<c01160a0>] current_fs_time+0x40/0x60
~ [<c015a518>] notify_change+0x178/0x1b2
~ [<c0142033>] do_truncate+0x33/0x60
~ [<c0103b1d>] do_IRQ+0x3d/0x60
~ [<c0142534>] sys_ftruncate64+0x74/0x100
~ [<c014256f>] sys_ftruncate64+0xaf/0x100
~ [<c0102317>] syscall_call+0x7/0xb
Code: 00 00 00 8b 4e 10 85 c9 74 61 8b 46 04 48 85 c0 89 46 04 7e 46 b8
00 f0 ff ff 21 e0 8b 00 8b 98 a8 04 00 00 8b 46 00 39 03 74 08 <0f> 0b
96 0b f3 16 26 c0 39 de 74 15 b9 24 00 00 00 89 f2 89 d8

- --
Ramón Rey Vicente <ramon.rey en hispalinux.es>
JID rreylinux@jabber.org - GPG public key id 0x9F28E377
GPG Fingerprint 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
Planet AUGCyL - http://augcyl.org/planet/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9ENNw4Wp058o43cRAlRtAJ9uNKkEBfc1Vn+4tk9X77MfaDK3mgCeNBsG
WVo4sDzFURWlNQPw2nzIuNU=
=dpPN
-----END PGP SIGNATURE-----
