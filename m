Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVGaOuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVGaOuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 10:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGaOuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 10:50:16 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:7393 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261671AbVGaOuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 10:50:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=pDFbVLcZ3UIci0ZJ2j3peq8N+i37PW/766dcWBeZYbV04dpf8ePPyWw+rbds54q0wrEqLL35Ij/m8nhrHxf3SuUrMCUzctuS3kaW4QIJvlAlS27rsBPr2OfNdEIA9hFd/XrbTA5I1w6+IWqipq7/rWBDUMNEPzX1UBh3LJCjsKk=
Message-ID: <42ED01DF.9000906@gmail.com>
Date: Sun, 31 Jul 2005 16:52:47 +0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050731)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Tobias <kernelmail@icht.homelinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.3 2.6.11.6 2.6.12  2.6.13rc3 Badness in blk_remove_plug
 at	drivers/block/ll_rw_blk.c:1424
References: <20050731160704.eopkg4w04ggcg8kc@www.fujitsu.ti>
In-Reply-To: <20050731160704.eopkg4w04ggcg8kc@www.fujitsu.ti>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias schrieb:

>Hi I tried
>2.6.11.3
>2.6.11.6
>2.6.12
>2.6.13rc3
>
>In all these Kernels syslog reports me every few minutes log-entries like this
>
>Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424
> [<c0249559>] blk_remove_plug+0x69/0x70
> [<c024957a>] __generic_unplug_device+0x1a/0x30
> [<c024ac88>] __make_request+0x248/0x5a0
> [<c0140583>] mempool_alloc+0x33/0x110
> [<c0131240>] autoremove_wake_function+0x0/0x60
> [<c024b3ed>] generic_make_request+0x11d/0x210
> [<c0131240>] autoremove_wake_function+0x0/0x60
> [<c013cfaf>] find_lock_page+0xaf/0xe0
> [<c0131240>] autoremove_wake_function+0x0/0x60
> [<c0140583>] mempool_alloc+0x33/0x110
> [<d8f315b2>] _pagebuf_lookup_pages+0x1a2/0x2f0 [xfs]
> [<c024b536>] submit_bio+0x56/0xf0
> [<c0163ca0>] bio_alloc_bioset+0x130/0x1f0
> [<c0164244>] bio_add_page+0x34/0x40
> [<d8f325ef>] _pagebuf_ioapply+0x19f/0x2d0 [xfs]
> [<c0116cc0>] default_wake_function+0x0/0x20
> [<c0116cc0>] default_wake_function+0x0/0x20
> [<d8f32768>] pagebuf_iorequest+0x48/0x1b0 [xfs]
> [<c0116cc0>] default_wake_function+0x0/0x20
> [<c0116cc0>] default_wake_function+0x0/0x20
> [<d8f39268>] xfs_bdstrat_cb+0x38/0x50 [xfs]
> [<d8f322b6>] pagebuf_iostart+0x46/0xa0 [xfs]
> [<d8f39230>] xfs_bdstrat_cb+0x0/0x50 [xfs]
> [<d8f0bbe8>] xfs_iflush+0x2b8/0x4e0 [xfs]
> [<d8f2c867>] xfs_inode_flush+0x157/0x220 [xfs]
> [<d8f399f0>] linvfs_write_inode+0x40/0x80 [xfs]
> [<c0185fa2>] __sync_single_inode+0x132/0x270
> [<c018611f>] __writeback_single_inode+0x3f/0x180
> [<c0108b78>] enable_8259A_irq+0x48/0x90
> [<c013b591>] __do_IRQ+0x111/0x160
> [<c0186405>] sync_sb_inodes+0x1a5/0x300
> [<c018664d>] writeback_inodes+0xed/0x130
> [<c0143806>] wb_kupdate+0xb6/0x140
> [<c0144400>] pdflush+0x0/0x30
> [<c01442d8>] __pdflush+0xd8/0x200
> [<c0144426>] pdflush+0x26/0x30
> [<c0143750>] wb_kupdate+0x0/0x140
> [<c0144400>] pdflush+0x0/0x30
> [<c0130ca9>] kthread+0xa9/0xf0
> [<c0130c00>] kthread+0x0/0xf0
> [<c0101395>] kernel_thread_helper+0x5/0x10
>
>
>In bugzilla I found it here to:
>
>http://bugzilla.kernel.org/show_bug.cgi?id=4837
>
>
>First I reportet it here :
>
>http://bugzilla.kernel.org/show_bug.cgi?id=4438
>
>
>----------------------------------------------------------------
>This message was sent using IMP, the Internet Messaging Program.
>( http://www.horde.org )
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hello Tobias,

did you read the message at bugzilla? A .config file of the kernel
would be appropriate to reproduce the failure you've got. Else it
is like looking for a needle in a haystack, for the developers.

<http://dict.leo.org/se?lp=ende&p=/Mn4k.&search=haystack> 
<http://dict.leo.org/se?lp=ende&p=/Mn4k.&search=haystack>

Greets &
Best regards
-- 
Michael Thonke
IT-Systemintegrator & Systemanalist

"Is it a fault to think we're independent individuals? Is it conceivable that the human race is a computer assisted simulation of higher individuals? Is it normal for the human race to distroy the basis of their own existence - the earth?"

