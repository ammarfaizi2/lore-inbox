Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSIXBHx>; Mon, 23 Sep 2002 21:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSIXBHx>; Mon, 23 Sep 2002 21:07:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:23446 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261517AbSIXBHv>;
	Mon, 23 Sep 2002 21:07:51 -0400
Message-ID: <3D8FBC16.6A4BCDE4@digeo.com>
Date: Mon, 23 Sep 2002 18:12:54 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38 semaphore.c calls sleeping function in illegal context
References: <20020924002052.GS25605@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2002 01:12:54.0396 (UTC) FILETIME=[829DDBC0:01C26367]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ksymoops 2.4.6 on i686 2.5.38-2.  Options used
>      -v /mnt/b/2.5.38/vmlinux-2.5.38-2 (specified)
>      -K (specified)
>      -L (specified)
>      -O (specified)
>      -m /boot/System.map-2.5.38-2 (specified)
> 
> Reading Oops report from the terminal
> c02c9f6c c02c9f84 c01175f7 c0260f80 c0261500 0000007e c02c9f98 c011a4a1
>        c0261500 0000007e 00000000 c02c9fac c011a78a c0312480 c0278213 c0383244
>        c02c9fb8 c02d8316 c02ba640 c02c9fc0 c02d8164 c02c9fd0 c02d8a4b 00000000
> Call Trace: [<c01175f7>] [<c011a4a1>] [<c011a78a>] [<c0105000>]
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> Trace; c01175f7 <__might_sleep+27/2b>
> Trace; c011a4a1 <acquire_console_sem+2d/50>
> Trace; c011a78a <register_console+122/1cc>
> Trace; c0105000 <_stext+0/0>
> 

Don't know.  Who called register_console()?

But I suspect in_atomic() is returning incorrect or misleading
answers early in boot.
