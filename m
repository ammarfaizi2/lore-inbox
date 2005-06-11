Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVFKLv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVFKLv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 07:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVFKLv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 07:51:27 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:13598 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261686AbVFKLvU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 07:51:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hOLjEsp1uQc+T/bIaEtROG2+DyafhkgRyJdUD1f1oJGM9SsDslkJRXwDWh0RZNfHj6UkfkLAWQrfJszT9r8ZPNRizgVXRETZXKypnjIxJXkvqwHakjz7eYWq9xkH4qkBt1RTh9qnxoVqMb3jQLyjjDXq2aEAHqD+UQVm2h6Ghnk=
Message-ID: <40f323d00506110451f5c2983@mail.gmail.com>
Date: Sat, 11 Jun 2005 13:51:19 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc6-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050607042931.23f8f8e0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.6.12-rc6-mm1/
> 
> - Added v9fs
> 
> - Various random fixes
> 
> - Probably a similar number of breakages
> 
I just had the following Oopses:

Unable to handle kernel paging request at virtual address 901a1960
printing eip:
c0139251
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: radeon drm tun snd_seq snd_pcm_oss snd_mixer_oss
snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ipt_multiport
ipt_state ipt_limit ipt_MASQUERADE ipt_mark iptable_mangle ipt_MARK
ipt_REJECT iptable_filter iptable_nat ip_tables ip_conntrack_irc
ip_conntrack_ftp ip_conntrack skge 8139too mii usbcore ide_cd cdrom
CPU:    0
EIP:    0060:[<c0139251>]    Not tainted VLI
EFLAGS: 00010086   (2.6.12-rc6-mm1-arakou) 
EIP is at find_lock_page+0x21/0xb0
eax: 901a195c   ebx: 901a195c   ecx: d8a3b094   edx: 00000003
esi: 00109380   edi: c18e4b08   ebp: d822cb10   esp: d822cb00
ds: 007b   es: 007b   ss: 0068
Process emerge (pid: 31977, threadinfo=d822c000 task=cbb9d040)
Stack: c18e4b04 c1218060 00000000 00000050 d822cb34 c013930e 00000050 00109380 
        c18e4b04 c0333d04 00109380 c18e4a00 00001000 d822cb50 c0157986 d822cb50
 00109380 00109380 00001000 c18e4a00 d822cb70 c0157af5 00001000 d822cb70
Call Trace:
[<c0103d17>] show_stack+0x97/0xd0 
[<c0103ec5>] show_registers+0x155/0x1f0
[<c01040c1>] die+0xc1/0x140 
[<c01157ec>] do_page_fault+0x23c/0x6b5 
[<c010395f>] error_code+0x4f/0x54
[<c013930e>] find_or_create_page+0x2e/0xd0
[<c0157986>] grow_dev_page+0x26/0x110
[<c0157af5>] __getblk_slow+0x85/0x130
[<c0157e8b>] __getblk+0x3b/0x50
[<c01a788b>] search_by_key+0x9b/0xf40
[<c0195095>] reiserfs_read_locked_inode+0x65/0x110
[<c01951e9>] reiserfs_iget+0x79/0xa0
[<c0190330>] reiserfs_lookup+0xd0/0x130
[<c0161f80>] real_lookup+0xb0/0xd0
[<c01622be>] do_lookup+0x7e/0x90
[<c0162a06>] __link_path_walk+0x736/0xd50
[<c016306a>] link_path_walk+0x4a/0x110
[<c01633b4>] path_lookup+0x74/0x120
[<c01635ee>] __user_walk+0x2e/0x50
[<c015e240>] vfs_stat+0x20/0x50
[<c015e834>] sys_stat64+0x14/0x30
[<c0102e0f>] sysenter_past_esp+0x54/0x75
Code: c3 89 f6 8d bc 27 00 00 00 00 55 89 e5 57 56 89 d6 53 83 ec 04
89 45 f0 fa 8d 78 04 89 f2 89 f8 e8 35 04 0b 00 85 c0 89 c3 74 56 <ff>
40 04 0f ba 28 00 19 c0 85 c0 74 49 fb 0f ba 2b 00 19 c0 85


 <1>Unable to handle kernel paging request at virtual address 71ef2710
 printing eip:
c0157140
*pde = 00000000
Oops: 0000 [#2]
Modules linked in: radeon drm tun snd_seq snd_pcm_oss snd_mixer_oss
snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ipt_multiport
ipt_state ipt_limit ipt_MASQUERADE ipt_mark iptable_mangle ipt_MARK
ipt_REJECT iptable_filter iptable_nat ip_tables ip_conntrack_irc
ip_conntrack_ftp ip_conntrack skge 8139too mii usbcore ide_cd cdrom   
                          CPU:    0
EIP:    0060:[<c0157140>]    Not tainted VLI   
EFLAGS: 00010a16   (2.6.12-rc6-mm1-arakou)     
EIP is at __find_get_block_slow+0x90/0x140
eax: 00000000   ebx: 71ef26fc   ecx: cb96f0e7   edx: 00000001
esi: c1309f20   edi: 000f9df5   ebp: e35d5b98   esp: e35d5b74
ds: 007b   es: 007b   ss: 0068
Process vim (pid: 32081, threadinfo=e35d5000 task=c2cc55b0)  
Stack: df7fb6bc f6de8a4c f7cf12fc f6de8cec 00000002 c18e4584 dcb43d7c c18e4520 
       000f9df5 e35d5bac c0157e1c 00001000 000f9df5 c18e4520 e35d5bc0 c0157e6c 
       00003e94 0000003e 000f9df5 e35d5ce0 c01a788b 0000001e 0000001f e35d5bf0 
Call Trace:
 [<c0103d17>] show_stack+0x97/0xd0
 [<c0103ec5>] show_registers+0x155/0x1f0
 [<c01040c1>] die+0xc1/0x140
 [<c01157ec>] do_page_fault+0x23c/0x6b5 
 [<c010395f>] error_code+0x4f/0x54
 [<c0157e1c>] __find_get_block+0x6c/0xa0
 [<c0157e6c>] __getblk+0x1c/0x50
 [<c01a788b>] search_by_key+0x9b/0xf40  
 [<c018fc2c>] search_by_entry_key+0x1c/0x1f0
 [<c01901e0>] reiserfs_find_entry+0x90/0x110
 [<c01902d2>] reiserfs_lookup+0x72/0x130
 [<c0161f80>] real_lookup+0xb0/0xd0
 [<c01622be>] do_lookup+0x7e/0x90
 [<c0162a06>] __link_path_walk+0x736/0xd50
 [<c016306a>] link_path_walk+0x4a/0x110 
 [<c01633b4>] path_lookup+0x74/0x120
 [<c0163a09>] open_namei+0x79/0x5f0
 [<c0154c29>] filp_open+0x29/0x50
 [<c0154fac>] sys_open+0x3c/0xc0
 [<c0102e0f>] sysenter_past_esp+0x54/0x75
Code: 89 f0 e8 34 b8 fe ff 89 d8 83 c4 18 5b 5e 5f c9 c3 8b 06 f6 c4
08 0f 84 a4 00 00 00 8b 5e 0c ba 01 00 00 00 89 d9 90 8d 74 26 00 <3b>
7b 14 74 7b 8b 03 8b 5b 04 a8 10 b8 00 00 00 00 0f 44 d0 39

Bad page state at free_hot_cold_page (in process 'firefox-bin', page c1309360)
flags:0x40000000 mapping:00000000 mapcount:-1 count:0
Backtrace:
 [<c0103d67>] dump_stack+0x17/0x20
 [<c013cb52>] bad_page+0x72/0xb0
 [<c013d2da>] free_hot_cold_page+0x4a/0xe0
 [<c013da81>] __pagevec_free+0x31/0x40
 [<c0142a9d>] release_pages+0x9d/0x150
 [<c0142b68>] __pagevec_release+0x18/0x30
 [<c01430bb>] truncate_inode_pages_range+0x13b/0x300
 [<c014329a>] truncate_inode_pages+0x1a/0x20
 [<c016d8e2>] generic_delete_inode+0xb2/0xd0
 [<c016da1f>] generic_drop_inode+0xf/0x20
 [<c016da92>] iput+0x62/0x90
 [<c016494f>] sys_unlink+0xdf/0x110
 [<c0102e0f>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed

regards,

Benoit Boissinot
