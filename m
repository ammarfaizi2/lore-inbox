Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSEXJAf>; Fri, 24 May 2002 05:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSEXJAe>; Fri, 24 May 2002 05:00:34 -0400
Received: from denise.shiny.it ([194.20.232.1]:26019 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S317058AbSEXJAd>;
	Fri, 24 May 2002 05:00:33 -0400
Message-ID: <XFMail.20020524105942.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3CED4843.2783B568@zip.com.au>
Date: Fri, 24 May 2002 10:59:42 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: Re: Poor read performance when sequential write presents
Cc: "chen, xiangping" <chen_xiangping@emc.com>,
        Andrew Morton <akpm@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I did a IO test with one sequential read and one sequential write
>> to different files. I expected somewhat similar throughput on read
>> and write. But it seemed that the read is blocked until the write
>> finishes. After the write process finished, the read process slowly
>> picks up the speed. Is Linux buffer cache in favor of write? How
>> to tune it?
> [...]
> 2: Apply http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/read-latency2.patch

Hmmm, someone wrote a patch to fix another related problem: the fact
that multiple readers read at a very different speed. It's not unusual
that one reader gets stuck until all other have finished. I don't
remember who wrote that patch, sorry.


Bye.

