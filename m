Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbTDHT74 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTDHT7z (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:59:55 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:37350 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261717AbTDHT7Z (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 15:59:25 -0400
Subject: Re: *  2.5.67 sleep function from illegal context
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200304082340.06746.b_adlakha@softhome.net>
References: <200304082340.06746.b_adlakha@softhome.net>
Content-Type: text/plain
Organization: 
Message-Id: <1049832651.592.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 08 Apr 2003 22:10:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 01:40, Balram Adlakha wrote:
> I get this repeatedly each second:
> 
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1658
> 
> Call Trace:
>   [<c0117459>] __might_sleep+0x5f/0x72
>   [<c0136b93>] kmalloc+0x88/0x8f
>   [<c02583c7>] accel_cursor+0xd5/0x2f8
>   [<c02587db>] fb_vbl_handler+0x82/0x9d
>   [<c0115ecb>] scheduler_tick+0x2d9/0x2de
>   [<c0120b89>] update_process_times+0x46/0x50
>   [<c0256edc>] cursor_timer_handler+0x0/0x3d
>   [<c0256efd>] cursor_timer_handler+0x21/0x3d
>   [<c0120c3d>] run_timer_softirq+0x90/0x170
>   [<c010e577>] timer_interrupt+0x56/0x119
>   [<c011d065>] do_softirq+0xa1/0xa3
>   [<c010abf6>] do_IRQ+0x10e/0x12b
>   [<c0109320>] common_interrupt+0x18/0x20

Does disabling FrameBuffer console support help?

________________________________________________________________________
Linux Registered User #287198

