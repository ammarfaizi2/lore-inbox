Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265646AbSKFEZt>; Tue, 5 Nov 2002 23:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSKFEZr>; Tue, 5 Nov 2002 23:25:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:43948 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265646AbSKFEZq>;
	Tue, 5 Nov 2002 23:25:46 -0500
Message-ID: <3DC89B50.2DBF413@digeo.com>
Date: Tue, 05 Nov 2002 20:32:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jordan Breeding <jordan.breeding@attbi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: unitialized timers with 2.5.46-bk
References: <3DC891A9.5030404@attbi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 04:32:16.0745 (UTC) FILETIME=[7C7EB590:01C2854D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding wrote:
> 
> Hello,
> 
>    I get these warnings about uninitialized timers when using 2.5.46-bk:

Thanks.  I sent fixes for tons and tons of these today.

> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc036ca30, data=0x0
> Call Trace:
>   [<c012d568>] check_timer_failed+0x68/0x70
>   [<c036ca30>] floppy_shutdown+0x0/0xe0
>   [<c012d8bb>] del_timer+0x1b/0x90
>   [<c036a458>] reschedule_timeout+0x28/0xd0
>   [<c03708f0>] floppy_find+0x0/0x60
>   [<c0105094>] init+0x54/0x180
>   [<c0105040>] init+0x0/0x180
>   [<c0108d9d>] kernel_thread_helper+0x5/0x18

hm.  Except this one.
