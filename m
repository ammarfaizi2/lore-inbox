Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262801AbSI3RxN>; Mon, 30 Sep 2002 13:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSI3RxM>; Mon, 30 Sep 2002 13:53:12 -0400
Received: from packet.digeo.com ([12.110.80.53]:58556 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262801AbSI3RxK>;
	Mon, 30 Sep 2002 13:53:10 -0400
Message-ID: <3D9890D4.FA7A5415@digeo.com>
Date: Mon, 30 Sep 2002 10:58:44 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.37-bk2 maybe new traceback for $BLAH at slab.c:1374
References: <1033406872.32409.82.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 17:58:29.0100 (UTC) FILETIME=[FB6192C0:01C268AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> I got the other init_irq() stuff just like many other people, but here's
> one which I haven't seen reported yet.  Kernel is 2.5.39bk2.  I just got
> this once on boot up.  This system is UP, IDE.
> 
> Debug: sleeping function called from illegal context at slab.c:1374
> cc57bf74 cc57bf94 c013204b c02a89e1 0000055e cc57a000 cd0103e0 00000000
>        cc57bfbc c010bb13 c12832e8 000001d0 c012b317 bffffb88 00000000 cc57a000
>        00000000 00000004 bffffb28 c010781b 00000000 00000400 00000001 00000000
> Call Trace:
>  [<c013204b>]__kmem_cache_alloc+0x10b/0x110
>  [<c010bb13>]sys_ioperm+0x83/0x150
>  [<c012b317>]sys_munmap+0x57/0x80
>  [<c010781b>]syscall_call+0x7/0xb
> 

Yup, thanks.  The sys_ioperm() one is known.  I'll fix it up.
