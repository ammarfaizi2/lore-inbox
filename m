Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUJKMqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUJKMqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUJKMqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:46:24 -0400
Received: from smtp.ono.com ([62.42.230.12]:58031 "EHLO mta02.onolab.com")
	by vger.kernel.org with ESMTP id S268907AbUJKMoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:44:21 -0400
Message-ID: <416A8019.4050901@hispalinux.es>
Date: Mon, 11 Oct 2004 14:44:09 +0200
From: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request at virtual address 0000ed9c
 [was Re: 2.6.9-rc4-mm1]
References: <20041011032502.299dc88d.akpm@osdl.org>
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I get this with rc4-mm1

Unable to handle kernel paging request at virtual address 0000ed9c
~ printing eip:
c0115ca4
*pde = 00000000
Oops: 0002 [#11]
PREEMPT
Modules linked in: r128 ipt_state ip_conntrack iptable_filter ip_tables
8139too mii crc32 snd_ens1371 snd_rawmidi snd_ac97_codec gameport
uhci_hcd via_agp snd_pcm_oss snd_pcm snd_timer snd_page_alloc
snd_mixer_oss snd floppy ide_cd cdrom
CPU:    0
EIP:    0060:[<c0115ca4>]    Not tainted VLI
EFLAGS: 00210082   (2.6.9-rc4-mm1)
EIP is at profile_hit+0x24/0x40
eax: 0000ed9c   ebx: c41b0aa0   ecx: 00000000   edx: 00003b67
esi: ffffffea   edi: 00000000   ebp: c49ddfbc   esp: c49ddf98
ds: 007b   es: 007b   ss: 0068
Process firefox-bin (pid: 3724, threadinfo=c49dd000 task=c41b0aa0)
Stack: c01122d7 c02efac0 4167da61 00000000 00200086 00000000 00000e8c
00000001
~       b7e73080 c49dd000 c0103da7 00000e8c 00000000 bffff098 00000001
b7e73080
~       bffff098 0000009c 0000007b 0000007b 0000009c 4d305504 00000073
00200246
Call Trace:
~ [<c01122d7>] setscheduler+0x97/0x1e0
~ [<c0103da7>] syscall_call+0x7/0xb
Code: 8d b4 26 00 00 00 00 89 d0 8b 0d 4c 4d 2f c0 8b 15 48 4d 2f c0 2d
40 02 10 c0 d3 e8 4a 39 c2 76 02 89 c2 a1 44 4d 2f c0 8d 04 90 <ff> 00
c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
~ <6>note: firefox-bin[3724] exited with preempt_count 2
scheduling while atomic: firefox-bin/0x04000002/3724
~ [<c025fe0f>] schedule+0x4cf/0x4e0
~ [<c013bc77>] unmap_page_range+0x37/0x60
~ [<c02602b2>] cond_resched+0x32/0x60
~ [<c013be61>] unmap_vmas+0x1c1/0x220
~ [<c0140121>] exit_mmap+0x61/0x140
~ [<c0112fdf>] mmput+0x1f/0xa0
~ [<c011717b>] do_exit+0x13b/0x3e0
~ [<c0104719>] die+0x159/0x160
~ [<c0110100>] do_page_fault+0x0/0x5a6
~ [<c01103b6>] do_page_fault+0x2b6/0x5a6
~ [<c013d58e>] do_no_page+0x1ae/0x320
~ [<c0110294>] do_page_fault+0x194/0x5a6
~ [<c013f996>] find_extend_vma+0x16/0x80
~ [<c0127855>] get_futex_key+0x35/0x140
~ [<c0110100>] do_page_fault+0x0/0x5a6
~ [<c010400d>] error_code+0x2d/0x40
~ [<c0115ca4>] profile_hit+0x24/0x40
~ [<c01122d7>] setscheduler+0x97/0x1e0
~ [<c0103da7>] syscall_call+0x7/0xb
- --
Ramón Rey Vicente <ramon.rey en hispalinux.es>
JID rreylinux@jabber.org - GPG public key id 0x9F28E377
GPG Fingerprint 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBaoAYw4Wp058o43cRAlUQAJ4nk8Ymgth57GwYPJBFzuwaTUYNgACfRfqy
JjMj74CC2e2Wejj2gzl2rNA=
=SR3/
-----END PGP SIGNATURE-----
