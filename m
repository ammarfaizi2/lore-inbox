Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTJCIdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTJCIdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:33:11 -0400
Received: from dyn-ctb-203-221-73-69.webone.com.au ([203.221.73.69]:53771 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263611AbTJCIdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:33:08 -0400
Message-ID: <3F7D343D.7000806@cyberone.com.au>
Date: Fri, 03 Oct 2003 18:33:01 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rodolfo Boer <movez@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Badness in as_remove_dispatched_request
References: <200310031013.37366.movez@gawab.com>
In-Reply-To: <200310031013.37366.movez@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rodolfo Boer wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hello! This is my first try with the 2.6.0-test kernels and I get AMOUNTS of 
>these warnings during boot-up on both test5 and test6 (this expecially is 
>from test6):
>
>Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1023
>Call Trace:
> [<c01e0ef1>] as_remove_dispatched_request+0x71/0x100
> [<c01d9b17>] elv_remove_request+0x27/0x40
> [<c01e5974>] ide_end_request+0xf4/0x150
> [<c01f4ae7>] ide_dma_intr+0x97/0xc0
> [<c01e70ca>] ide_intr+0xea/0x190
> [<c01f4a50>] ide_dma_intr+0x0/0xc0
> [<c010b3aa>] handle_IRQ_event+0x3a/0x70
> [<c010b731>] do_IRQ+0x91/0x130
> [<c0105000>] rest_init+0x0/0x60
> [<c0109b48>] common_interrupt+0x18/0x20
> [<c0105000>] rest_init+0x0/0x60
> [<c0106e93>] default_idle+0x23/0x30
> [<c0106efc>] cpu_idle+0x2c/0x40
> [<c02d670c>] start_kernel+0x14c/0x160
> [<c02d6480>] unknown_bootoption+0x0/0x100
>
>They are all the same. Otherwise the system *seems* to work fine, but I 
>haven't tried much since I want to solve this. Maybe the problem is with my 
>on-board hpt-372 disk controller (not in RAID configuration). If you need 
>more info or my .config just ask.
>

Hi Rodolfo,
Linus just merged some AS fixes. Could you test the latest cset please?
http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/ (topmost link)

Thanks.


