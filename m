Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbSKPTB2>; Sat, 16 Nov 2002 14:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbSKPTB1>; Sat, 16 Nov 2002 14:01:27 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:39389 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267338AbSKPTB1> convert rfc822-to-8bit; Sat, 16 Nov 2002 14:01:27 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Date: Sat, 16 Nov 2002 19:58:57 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211161958.57677.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

> just to make a quick test, can you try an hack like this combined with a
> setting of elvtune -r 128 -w 256 on top of 2.4.20rc1?
>
> --- x/drivers/block/ll_rw_blk.c.~1~     Sat Nov  2 19:45:33 2002
> +++ x/drivers/block/ll_rw_blk.c Sat Nov 16 19:44:20 2002
> @@ -432,7 +432,7 @@ static void blk_init_free_list(request_q
> 
>         si_meminfo(&si);
>         megs = si.totalram >> (20 - PAGE_SHIFT);
> -       nr_requests = 128;
> +       nr_requests = 16;
>         if (megs < 32)
>                 nr_requests /= 2;
>         blk_grow_request_list(q, nr_requests);
hehe, Andrea, it seem's we both think of the same ... :-) ... I am just 
recompiling the kernel ... hang on.

ciao, Marc


