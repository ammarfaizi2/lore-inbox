Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278742AbRJ0N2C>; Sat, 27 Oct 2001 09:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278782AbRJ0N1u>; Sat, 27 Oct 2001 09:27:50 -0400
Received: from smtp2.libero.it ([193.70.192.52]:14302 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S278742AbRJ0N1k>;
	Sat, 27 Oct 2001 09:27:40 -0400
Message-ID: <3BDAB344.CE25D5D@denise.shiny.it>
Date: Sat, 27 Oct 2001 15:14:44 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.13-pre1 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: zlatko.calusic@iskon.hr
CC: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com> <dnr8rqu30x.fsf@magla.zg.iskon.hr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> block: 1024 slots per queue, batch=341
> 
> Wrote 600.00 MB in 71 seconds -> 8.39 MB/s (7.5 %CPU)
> 
> Still very spiky, and during the write disk is uncapable of doing any
> reads. IOW, no serious application can be started before writing has
> finished. Shouldn't we favour reads over writes? Or is it just that
> the elevator is not doing its job right, so reads suffer?
>
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  1  1      0   3596    424 453416   0   0     0 40468  189   508   2   2  96

341*127K = ~40M.

Batch is too high. It doesn't explain why reads get delayed so much, anyway.

Bye.

