Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSETRYX>; Mon, 20 May 2002 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSETRYW>; Mon, 20 May 2002 13:24:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43967 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316158AbSETRYW>;
	Mon, 20 May 2002 13:24:22 -0400
Date: Mon, 20 May 2002 10:23:05 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
Message-ID: <221520000.1021915385@flay>
In-Reply-To: <20020520163724.GI21806@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I've been benchmarking rmap 13 against mainline (2.4.19-pre7)
>> and with the latest lock breakup changes performance now seems
>> to be about equivalent to mainline (for kernel compile on NUMA-Q).
>> Those changes reduced system time from 650s to 160s. The only
> 
> How much are you swapping in your workload? (as said the fast paths are
> hurted a little so it's expected that it's almost as fast as mainline
> with a kernel compile, similar to the fact we also add anon pages to the
> lru list). I think you're only exercising the fast paths in your
> workload, not the memory balancing that is the whole point of the change.

No swapping. We fixed the horrendous locking problem we were seeing,
but this was only one test - obviously others are needed. But I think we're
in agreement that it's time to give it a beating and see what happens ;-)

M.

