Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269632AbRHCWA5>; Fri, 3 Aug 2001 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269633AbRHCWAs>; Fri, 3 Aug 2001 18:00:48 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:44166
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S269632AbRHCWAd>; Fri, 3 Aug 2001 18:00:33 -0400
Message-ID: <3B6B1F0A.2000807@fugmann.dhs.org>
Date: Sat, 04 Aug 2001 00:00:42 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010716
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108031823380.11893-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See you point very well.

So I guess the problem is, that we want to keep the CPU busy while 
fetching the data the program wants.

This would mean, that having two processes that activly uses more than 
half of the memory would compete against each other and noone would 
never win, resulting in very bad performance - actually I would rather 
want the CPU to "twiddle thumbs" while waiting for the data, than a 
system that will halt for minutes (but that is very sub-optimal).

A solution may be to make sure that a program suspended by the VM gets 
higher priority than other processes, and thus provoking the VM-layer to 
fetch the data for the process more often than others. This would not 
give a fair system, but it would behave better under memory pressure.

Regards
Anders Fugmann



Rik van Riel wrote:
> On Fri, 3 Aug 2001, Anders Peter Fugmann wrote:
> 
> 
>>I dont know task states are defined, but by 'running' I mean that it
>>is not stopped by the VM, when the VM needs to fetch memory for the
>>process.
>>
> 
> What do you propose the program does when it doesn't have
> its data ? Better give up the CPU for somebody else than
> twiddle your thumbs while you don't have the data you want.
> 
> regards,
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
> 
> 


