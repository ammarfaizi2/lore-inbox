Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWHMMY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWHMMY0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 08:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWHMMY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 08:24:26 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:8243 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751142AbWHMMYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 08:24:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BU+6myTt5ySikn5EqTETtYLhMNLeAormZukwtybUkTe8jn4Tj4Rlx6cN2rK2AOm26Lfs+g1b+wFxVzrA2rMpmTNYw9PD/DL9LizkbNFqYICA6AB9wDzVRzFzhdfdTp+4AKLYRkjoZfrVHNQNAJKHIk0ALzpuPCb1J4XajtfWhLE=
Message-ID: <6bffcb0e0608130524j81944bag14c65957c2781e7f@mail.gmail.com>
Date: Sun, 13 Aug 2006 14:24:24 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1
Cc: "Ingo Molnar" <mingo@elte.hu>, "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060813012454.f1d52189.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
>
> - Warning: all the Serial ATA Kconfig options have been renamed.  If you
>   blindly run `make oldconfig' you won't have any disks.
>

MAX_STACK_TRACE_ENTRIES too low!

What does it mean?

BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.
 [<c0103e41>] dump_trace+0x70/0x176
 [<c0103fc1>] show_trace_log_lvl+0x12/0x22
 [<c0103fde>] show_trace+0xd/0xf
 [<c01040b0>] dump_stack+0x17/0x19
 [<c0138f30>] save_trace+0xce/0xd7
 [<c0139370>] add_lock_to_list+0x22/0x39
 [<c0139b3c>] check_prev_add+0x139/0x1b4
 [<c0139c04>] check_prevs_add+0x4d/0xaf
 [<c013b646>] __lock_acquire+0x8a1/0x93c
 [<c013bd4c>] lock_acquire+0x6f/0x8f
 [<c03033e8>] _spin_lock_irq+0x29/0x35
 [<c01ed022>] __make_request+0x68/0x413
 [<c01ed6a7>] generic_make_request+0x273/0x2a4
 [<c01ed802>] submit_bio+0x12a/0x132
 [<c017b6f6>] submit_bh+0x10e/0x12e
 [<c0179fd3>] __block_write_full_page+0x231/0x326
 [<c017b567>] block_write_full_page+0xd7/0xdf
 [<c017e17a>] blkdev_writepage+0xf/0x11
 [<c0199d92>] mpage_writepages+0x1b6/0x324
 [<c017f3ee>] generic_writepages+0xa/0xc
 [<c015b6b5>] do_writepages+0x23/0x36
 [<c019871c>] __sync_single_inode+0x7b/0x199
 [<c01989ac>] __writeback_single_inode+0x172/0x17a
 [<c0198b50>] generic_sync_sb_inodes+0x19c/0x242
 [<c0198c13>] sync_sb_inodes+0x1d/0x20
 [<c0198c8e>] writeback_inodes+0x78/0xae
 [<c015b52b>] wb_kupdate+0x7c/0xdd
 [<c015bf14>] __pdflush+0xcc/0x163
 [<c015bfdd>] pdflush+0x32/0x34
 [<c01347a9>] kthread+0x82/0xaa
 [<c0303dfd>] kernel_thread_helper+0x5/0xb
 [<c0103fc1>] show_trace_log_lvl+0x12/0x22
 [<c0103fde>] show_trace+0xd/0xf
 [<c01040b0>] dump_stack+0x17/0x19
 [<c0138f30>] save_trace+0xce/0xd7
 [<c0139370>] add_lock_to_list+0x22/0x39
 [<c0139b3c>] check_prev_add+0x139/0x1b4
 [<c0139c04>] check_prevs_add+0x4d/0xaf
 [<c013b646>] __lock_acquire+0x8a1/0x93c
 [<c013bd4c>] lock_acquire+0x6f/0x8f
 [<c03033e8>] _spin_lock_irq+0x29/0x35
 [<c01ed022>] __make_request+0x68/0x413
 [<c01ed6a7>] generic_make_request+0x273/0x2a4
 [<c01ed802>] submit_bio+0x12a/0x132
 [<c017b6f6>] submit_bh+0x10e/0x12e
 [<c0179fd3>] __block_write_full_page+0x231/0x326
 [<c017b567>] block_write_full_page+0xd7/0xdf
 [<c017e17a>] blkdev_writepage+0xf/0x11
 [<c0199d92>] mpage_writepages+0x1b6/0x324
 [<c017f3ee>] generic_writepages+0xa/0xc
 [<c015b6b5>] do_writepages+0x23/0x36
 [<c019871c>] __sync_single_inode+0x7b/0x199
 [<c01989ac>] __writeback_single_inode+0x172/0x17a
 [<c0198b50>] generic_sync_sb_inodes+0x19c/0x242
 [<c0198c13>] sync_sb_inodes+0x1d/0x20
 [<c0198c8e>] writeback_inodes+0x78/0xae
 [<c015b52b>] wb_kupdate+0x7c/0xdd
 [<c015bf14>] __pdflush+0xcc/0x163
 [<c015bfdd>] pdflush+0x32/0x34
 [<c01347a9>] kthread+0x82/0xaa
 [<c0303dfd>] kernel_thread_helper+0x5/0xb
 =======================

config & dmesg http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/frontline/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
