Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265365AbSKARTr>; Fri, 1 Nov 2002 12:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265367AbSKARTr>; Fri, 1 Nov 2002 12:19:47 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:21655 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S265365AbSKARTr>; Fri, 1 Nov 2002 12:19:47 -0500
Message-ID: <3DC2BCF5.5010607@kegel.com>
Date: Fri, 01 Nov 2002 09:42:13 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
References: <Pine.LNX.4.44.0210311043380.1562-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
>>Do you avoid the cost of epoll_ctl() per new fd?
> 
> Jamie, the cost of epoll_ctl(2) is minimal/zero compared with the average
> life of a connection.

Depends on the workload.  Where I work, the http client I'm writing
has to perform extremely well even on 1 byte files with HTTP 1.0.
Minimizing system calls is suprisingly important - even
a gettimeofday hurts.

- Dan

