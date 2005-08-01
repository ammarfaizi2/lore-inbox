Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVHAVfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVHAVfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVHAVd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:33:27 -0400
Received: from p5486C2CE.dip.t-dialin.net ([84.134.194.206]:51348 "EHLO
	fujitsu.ti") by vger.kernel.org with ESMTP id S261290AbVHAVcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:32:24 -0400
Message-ID: <20050801233221.98b7vf1s040s480k@www.fujitsu.ti>
X-Priority: 3 (Normal)
Date: Mon, 01 Aug 2005 23:32:21 +0200
From: Tobias <kernelmail@icht.homelinux.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.3 2.6.11.6 2.6.12  2.6.13rc3 +rc4 Badness in
	blk_remove_plug at drivers/block/ll_rw_blk.c:1424 pppd problem ?
References: <20050731160704.eopkg4w04ggcg8kc@www.fujitsu.ti>
	<20050801130602.499nu645gksckc8g@www.fujitsu.ti>
In-Reply-To: <20050801130602.499nu645gksckc8g@www.fujitsu.ti>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-15;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-Originating-IP: 192.168.0.1
X-Remote-Browser: Mozilla/5.0 (X11; U; Linux i686; de-DE; rv:1.7.10)
	Gecko/20050720 Firefox/1.0.6
X-Hordeserver: www.fujitsu.ti
X-Hordehttps: on
X-horde-session: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i did run the systen half an hour without ppp . there was no badness in 
the logs
in the time.

after after starting the internet without the firewall the messages about the
badness  were after a few minutes  in the log.

so the bug is not in the iptables code.

it might  be in the pppd driver .

I use pppoe (ADSL) using the userspace pppoe driver.

On my old Installation I used the kernel space driver , were the badness also
also was.

my ethernet driver is 8139too
I use pppd 2.4.3


see also

http://bugzilla.kernel.org/show_bug.cgi?id=4438



----- Nachricht von kernelmail@icht.homelinux.net ---------
     Datum: Mon, 01 Aug 2005 13:06:02 +0200
       Von: Tobias <kernelmail@icht.homelinux.net>
Antwort an: Tobias <kernelmail@icht.homelinux.net>
   Betreff: Re: 2.6.11.3 2.6.11.6 2.6.12  2.6.13rc3 +rc4 Badness in
blk_remove_plug at drivers/block/ll_rw_blk.c:1424
        An: linux-kernel@vger.kernel.org


> HI
> I updated to rc4 It still happens
>
> i atached my bootlog . and config.gz
>
> the output of /scripts/ver_linux:
> ##############################################
>
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux fujitsu.ti 2.6.13-rc4 #1 Mon Aug 1 11:19:36 CEST 2005 i686 
> pentium3 i386
> GNU/Linux
>
> Gnu C                  3.4.3
> Gnu make               3.80
> binutils               2.15.94.0.2.2
> util-linux             2.12q
> mount                  2.12q
> module-init-tools      3.1
> e2fsprogs              1.37
> jfsutils               1.1.7
> reiserfsprogs          3.6.19
> reiser4progs           line
> xfsprogs               2.6.25
> quota-tools            3.12.
> PPP                    2.4.3
> nfs-utils              1.0.6
> Linux C Library        2.3.4
> Dynamic linker (ldd)   2.3.4
> Linux C++ Library      6.0.3
> Procps                 3.2.5
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.2.1
> udev                   058
> Modules Loaded         snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
> snd_pcm_oss snd_mixer_oss nfsd lockd sunrpc ip6t_limit ip6table_filter
> ip6_tables ipt_MASQUERADE ipt_TCPMSS ipt_state ipt_REJECT ipt_LOG ipt_limit
> iptable_mangle iptable_nat iptable_filter ip_conntrack_ftp ip_conntrack_irc
> r128 drm ip_conntrack ip_tables af_packet ppp_synctty ppp_async crc_ccitt
> ppp_generic slhc cls_route cls_u32 cls_fw sch_sfq sch_htb ohci_hcd ehci_hcd
> tsdev psmouse 8250_pnp 8250 serial_core floppy pcspkr rtc aty128fb snd_es1938
> gameport snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
> snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro i2c_core uhci_hcd
> usbcore pci_hotplug via_agp agpgart evdev autofs4 squashfs zlib_inflate
> nls_iso8859_1 nls_cp437 vfat fat xfs exportfs jfs loop ipv6 binfmt_misc
> parport_pc lp parport 8139too mii ide_cd cdrom capability commoncap via82cxxx
> video thermal processor fan button battery ac unix
>
> ################################
>
>
>
> ----- Nachricht von kernelmail@icht.homelinux.net ---------
>     Datum: Sun, 31 Jul 2005 16:07:04 +0200
>       Von: Tobias <kernelmail@icht.homelinux.net>
> Antwort an: Tobias <kernelmail@icht.homelinux.net>
>   Betreff: 2.6.11.3 2.6.11.6 2.6.12  2.6.13rc3 Badness in blk_remove_plug at
> drivers/block/ll_rw_blk.c:1424
>        An: linux-kernel@vger.kernel.org
>
>
>> Hi I tried
>> 2.6.11.3
>> 2.6.11.6
>> 2.6.12
>> 2.6.13rc3
>>
>> In all these Kernels syslog reports me every few minutes log-entries 
>> like this
>>
>> Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424
>> [<c0249559>] blk_remove_plug+0x69/0x70
>> [<c024957a>] __generic_unplug_device+0x1a/0x30
>> [<c024ac88>] __make_request+0x248/0x5a0
>> [<c0140583>] mempool_alloc+0x33/0x110
>> [<c0131240>] autoremove_wake_function+0x0/0x60
>> [<c024b3ed>] generic_make_request+0x11d/0x210
>> [<c0131240>] autoremove_wake_function+0x0/0x60
>> [<c013cfaf>] find_lock_page+0xaf/0xe0
>> [<c0131240>] autoremove_wake_function+0x0/0x60
>> [<c0140583>] mempool_alloc+0x33/0x110
>> [<d8f315b2>] _pagebuf_lookup_pages+0x1a2/0x2f0 [xfs]
>> [<c024b536>] submit_bio+0x56/0xf0
>> [<c0163ca0>] bio_alloc_bioset+0x130/0x1f0
>> [<c0164244>] bio_add_page+0x34/0x40
>> [<d8f325ef>] _pagebuf_ioapply+0x19f/0x2d0 [xfs]
>> [<c0116cc0>] default_wake_function+0x0/0x20
>> [<c0116cc0>] default_wake_function+0x0/0x20
>> [<d8f32768>] pagebuf_iorequest+0x48/0x1b0 [xfs]
>> [<c0116cc0>] default_wake_function+0x0/0x20
>> [<c0116cc0>] default_wake_function+0x0/0x20
>> [<d8f39268>] xfs_bdstrat_cb+0x38/0x50 [xfs]
>> [<d8f322b6>] pagebuf_iostart+0x46/0xa0 [xfs]
>> [<d8f39230>] xfs_bdstrat_cb+0x0/0x50 [xfs]
>> [<d8f0bbe8>] xfs_iflush+0x2b8/0x4e0 [xfs]
>> [<d8f2c867>] xfs_inode_flush+0x157/0x220 [xfs]
>> [<d8f399f0>] linvfs_write_inode+0x40/0x80 [xfs]
>> [<c0185fa2>] __sync_single_inode+0x132/0x270
>> [<c018611f>] __writeback_single_inode+0x3f/0x180
>> [<c0108b78>] enable_8259A_irq+0x48/0x90
>> [<c013b591>] __do_IRQ+0x111/0x160
>> [<c0186405>] sync_sb_inodes+0x1a5/0x300
>> [<c018664d>] writeback_inodes+0xed/0x130
>> [<c0143806>] wb_kupdate+0xb6/0x140
>> [<c0144400>] pdflush+0x0/0x30
>> [<c01442d8>] __pdflush+0xd8/0x200
>> [<c0144426>] pdflush+0x26/0x30
>> [<c0143750>] wb_kupdate+0x0/0x140
>> [<c0144400>] pdflush+0x0/0x30
>> [<c0130ca9>] kthread+0xa9/0xf0
>> [<c0130c00>] kthread+0x0/0xf0
>> [<c0101395>] kernel_thread_helper+0x5/0x10
>>
>>
>> In bugzilla I found it here to:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=4837
>>
>>
>> First I reportet it here :
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=4438
>>
>>
>> ----------------------------------------------------------------
>> This message was sent using IMP, the Internet Messaging Program.
>> ( http://www.horde.org )
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
>
> ----- Ende der Nachricht von kernelmail@icht.homelinux.net -----
>
>
>
> ----------------------------------------------------------------
> This message was sent using IMP, the Internet Messaging Program.
> ( http://www.horde.org )
>
>


----- Ende der Nachricht von kernelmail@icht.homelinux.net -----



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
( http://www.horde.org )


