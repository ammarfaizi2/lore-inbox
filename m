Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287591AbSAGOUu>; Mon, 7 Jan 2002 09:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSAGOUk>; Mon, 7 Jan 2002 09:20:40 -0500
Received: from denise.shiny.it ([194.20.232.1]:41959 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S287591AbSAGOUX>;
	Mon, 7 Jan 2002 09:20:23 -0500
Message-ID: <XFMail.20020107152007.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3C396A66.D19E71DF@zip.com.au>
Date: Mon, 07 Jan 2002 15:20:07 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Andrew Morton <akpm@zip.com.au>
Subject: RE: [patch, CFT] improved disk read latency
Cc: lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +             if (__rq->elevator_sequence-- <= 0) {
> +                     /*
> +                      * OK, we've exceeded someone's latency limit.
> +                      * But we still continue to look for merges,
> +                      * because they're so much better than seeks.
> +                      */
> +                     merge_only = 1;


That's true for hard discs, but for most removables seek time is
small compared to write time. Think about a magneto-optical drive or
a ZIP. Seek is about 20-50ms while writing goes at 300-1000KiB/s.



Bye.

