Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVAWLNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVAWLNW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 06:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAWLNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 06:13:22 -0500
Received: from 189.Red-83-34-227.pooles.rima-tde.net ([83.34.227.189]:9344
	"EHLO rocco.thepython.dyndns.org") by vger.kernel.org with ESMTP
	id S261293AbVAWLNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 06:13:06 -0500
Date: Sun, 23 Jan 2005 12:13:03 +0100
From: Pablo =?iso-8859-1?Q?Barb=E1chano?= <pablobarbachano@yahoo.es>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs bug
Message-ID: <20050123111303.GA9938@thepython.dyndns.org>
Reply-To: pablobarbachano@yahoo.es
References: <20050122232638.GA7626@thepython.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050122232638.GA7626@thepython.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 12:26:38AM +0100, Pablo Barbáchano wrote:
> Hi, Im having a segfault when trying to rm -rf a directory in my hard
> disk. If I run fsck.reiserfs on that partition it tells me to
> --rebuild-tree. I wont yet, because I cant make a backup and, well, Im
> scared of losing my data ;)
> 
> Ah, kernel is a 2.6.10, and Im running debian unstable on an
> athlon... hope it helps!
> 

Actually, it happens with the 2.4.27 from knoppix 3.7, and without the
nvidia module (i tried it "just in case")

> I attach the kernel output:
> ---------------------------------------------------
> 
> ReiserFS: sda4: found reiserfs format "3.6" with standard journal
> ReiserFS: sda4: using ordered data mode
> ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: sda4: checking transaction log (sda4)
> ReiserFS: sda4: replayed 3 transactions in 5 seconds
> ReiserFS: sda4: Using r5 hash to sort names
> ReiserFS: sda4: warning: vs-2180: finish_unfinished: iget failed for [245831 247149 0x0 SD]
> agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
> agpgart: XFree86 passes broken AGP3 flags (1f00080f). Fixed.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> ReiserFS: warning: is_tree_node: node level 54786 does not match to the expected one 1
> ReiserFS: sda4: warning: vs-5150: search_by_key: invalid format found in block 2037090. Fsck?
> ReiserFS: sda4: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [257451 257464 0x0 SD]
> ReiserFS: warning: is_tree_node: node level 54786 does not match to the expected one 1
> ReiserFS: sda4: warning: vs-5150: search_by_key: invalid format found in block 2037090. Fsck?
> ReiserFS: sda4: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [257451 257465 0x0 SD]
> ReiserFS: warning: is_tree_node: node level 54786 does not match to the expected one 1
> ReiserFS: sda4: warning: vs-5150: search_by_key: invalid format found in block 2037090. Fsck?
> ReiserFS: sda4: warning: vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [257451 257463 0xfffffffffffffff DIRECT]
> ReiserFS: sda4: warning: clm-2100: nesting info a different FS
> ReiserFS: sda4: warning: clm-2100: nesting info a different FS
> ------------[ cut here ]------------
> kernel BUG at fs/reiserfs/journal.c:2825!
> invalid operand: 0000 [#1]
> PREEMPT 
> Modules linked in: ppp_deflate zlib_deflate bsd_comp thermal fan button processor ac battery ppp_async crc_ccitt ipv6 ehci_hcd sn9c102 videod
> ev uhci_hcd usbcore sd_mod sata_via libata scsi_mod pci_hotplug analog parport_pc parport pcspkr reiserfs dm_mod capability commoncap it87 ee
> prom i2c_sensor i2c_isa nvidia rtc ppp_generic slhc ide_cd cdrom tsdev evdev psmouse mousedev i2c_viapro i2c_core snd_pcm_oss snd_mixer_oss s
> nd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via_agp agpgart 
> sk98lin af_packet ext2 ext3 jbd mbcache ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx
> _old opti621 ns87415 hpt366 ide_disk hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx pdc202xx_new ide_core unix 
> fbcon font bitblit vesafb cfbcopyarea cfbimgblt cfbfillrect
> CPU:    0
> EIP:    0060:[<e0bd518e>]    Tainted: P      VLI
> EFLAGS: 00010246   (2.6.10-1-686) 
> EIP is at journal_begin+0xee/0x100 [reiserfs]
> eax: 00000000   ebx: d9c9c000   ecx: d9c9df00   edx: d9c9df00
> esi: d9c9deb0   edi: d8882800   ebp: d9c9deb0   esp: d9c9de74
> ds: 007b   es: 007b   ss: 0068
> Process rm (pid: 6562, threadinfo=d9c9c000 task=da778020)
> Stack: ffffffff 00000000 00000000 00000000 00000012 d6b8cd6c 00000000 e0bc1bfa 
>        d9c9deb0 d8882800 00000012 00000000 00000000 000002c5 00000000 00000000 
>        00000000 00000000 00000000 e0c83000 00000000 d8882800 d6b8cd6c d9c9df70 
> Call Trace:
>  [<e0bc1bfa>] remove_save_link+0x3a/0x110 [reiserfs]
>  [<e0bd54ba>] journal_end+0xaa/0x100 [reiserfs]
>  [<e0bb4515>] reiserfs_delete_inode+0xe5/0x110 [reiserfs]
>  [<c016395d>] permission+0x6d/0x80
>  [<e0bb4430>] reiserfs_delete_inode+0x0/0x110 [reiserfs]
>  [<c0171095>] generic_delete_inode+0xa5/0x170
>  [<c0171343>] iput+0x63/0x90
>  [<c0166933>] sys_unlink+0xd3/0x130
>  [<c0156091>] sys_write+0x51/0x80
>  [<c01030df>] syscall_call+0x7/0xb
> Code: 24 08 89 54 24 04 89 34 24 e8 1f a5 5e df 83 7e 04 01 7e 04 31 c0 eb bd 89 3c 24 b8 c0 d8 bd e0 89 44 24 04 e8 04 fb fe ff eb e9 <0f> 0b 09 0b 6a ed bd e0 eb c0 90 8d b4 26 00 00 00 00 55 57 56 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
