Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVDMNyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVDMNyC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDMNyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:54:02 -0400
Received: from [213.85.5.168] ([213.85.5.168]:31730 "EHLO crimson.namesys.com")
	by vger.kernel.org with ESMTP id S261334AbVDMNx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:53:57 -0400
Date: Wed, 13 Apr 2005 17:54:38 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NULL pointe rin reiserfs
Message-ID: <20050413135438.GA6936@backtop.namesys.com>
References: <200504131217.17308@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504131217.17308@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

On Wed, Apr 13, 2005 at 12:17:15PM +0200, Alexander Gran wrote:
> Hi,
> 
> after resizing a reiserfs partition, the next cvs process produced:

please  provide more information about the system (.config, h/w configuration)
and how the fs was resized.  were there other error messages in the syslog
right before the crash?

may i guess -- was it online fs expanding with the cvs process running in
parallel?


> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c0192701
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: usbserial md5 ipv6 sk98lin
> CPU:    0
> EIP:    0060:[<c0192701>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.10-rc1-k7-vrs1)
> EIP is at scan_bitmap_block+0x41/0x2c0
> eax: f2d0d000   ebx: c6630eac   ecx: 00027305   edx: 00000000
> esi: f2d0d060   edi: c6630c48   ebp: eeeb3200   esp: c6630bdc
> ds: 007b   es: 007b   ss: 0068
> Process cvs (pid: 11807, threadinfo=c6630000 task=d7545ae0)
> Stack: 04040404 04040404 00005109 00184859 430034ec 00000800 542e1a94 3e846bff
>        b75bcfc3 0000000c c6630c48 eeeb3200 00000000 c0192c57 c6630eac 0000000c
>        c6630c48 00008000 00000002 00000002 00000001 eef8ce20 00007fff c6630d68
> Call Trace:
>  [<c0192c57>] scan_bitmap+0x1d7/0x260
>  [<c0193ea6>] reiserfs_allocate_blocknrs+0x196/0x4f0
>  [<c01a15b2>] reiserfs_allocate_blocks_for_region+0x302/0x16d0
>  [<c0139b18>] add_to_page_cache+0x68/0xc0
>  [<c019b085>] make_cpu_key+0x55/0x60
>  [<c01a39a3>] reiserfs_prepare_file_region_for_write+0x6b3/0xa10
>  [<c01a42d5>] reiserfs_file_write+0x5d5/0x840
>  [<c0149b73>] do_no_page+0x63/0x350
>  [<c0117b80>] do_page_fault+0x3d0/0x5ee
>  [<c015913e>] vfs_write+0xbe/0x130
>  [<c0159281>] sys_write+0x51/0x80
>  [<c010623b>] syscall_call+0x7/0xb
> Code: 3c 8b 28 8b 0f 8b 85 50 01 00 00 8b 40 08 89 4c 24 14 8b 4b 10 85 c9 8d 
> 34 d0 0f 84 7c 02 00 00 85 f6 0f 84 5a 02 00 00 8b 56 04 <8b> 02 83 e0 04 0f 
> 85 3f 02 00 00 8d 74 26 00 0f b7 46 02 3b 44
> 
> regards
> Alex
> -- 
> Encrypted Mails welcome.
> PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291



-- 
Alex.
