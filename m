Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWDFGsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWDFGsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 02:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWDFGsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 02:48:12 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:25478 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932100AbWDFGsL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 02:48:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KZyk5zY64U1ZVdpeXSONdZ+Hy86ylX/5AE9PEX3XG91gtfWFFgUJtkC8/D1HEloeJ59MSSiD+Vox7VnaNInodoDdTokLeHshjj6FowZ4q290q2+GECPcHwPgFtsqxN5TIWBZ4QAPm+zYaQpLSMNDTki6jnT20NggO+mzVeJdccQ=  ;
Message-ID: <44339031.4040307@yahoo.com.au>
Date: Wed, 05 Apr 2006 19:38:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: pomac@vapor.com
CC: Linux-kernel@vger.kernel.org
Subject: Re: [OOPS] related to swap?
References: <1144225363.7112.10.camel@localhost>
In-Reply-To: <1144225363.7112.10.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:
>>Ian Kumlien wrote:
>>
>>
>>>Yes, i run a tainted kernel! either live with it or ignore this mail
>>>=)
>>
>>>starting swap lead to a deadlock within 15 mins
>>
>>>I have never had the energy to perform a full memtext86+
>>
>>It would be useful if you could perform a memtest overnight one night,
>>then run a non-patched and non-tained 2.6.16.1 kernel, and try to
>>reproduce the problems.
> 
> 
> As i said, i really doubt that the memory is at fault here, it has done
> several passes over the memory but not all tests. I can give it a go
> though, but i really doubt it'll find anything.
> 

If it doesn't cost you much time (ie. do it overnight) it could save some
developers a lot of time.

> The kernel i run is a plain 2.6.16.1 from kernel.org (i have heard that
> you can actually compile gentoos own these days)
> 

OK, good.

> Since this is my *cough* desktop, running it without that ability is
> kinda a show stopper, thats why i included the thing above.
> 

But if the problem can be reproduced in 15 minutes, it shouldn't be
too hard to get a trace without nvidia loaded.

> But the thing is, my laptop runs with the same compiler, "same" nvidia
> driver and the "same" kernel ("same" as in 32 bit not 64 bit).
> Eventhough "same" in this case usually means nothing, i doubt that one
> would have a serius bug and the other wouldn't, ie it's most likley a
> bug related to 64 bits or one or more of the drivers involved.
> 
> The only errors i get in dmesg atm is:
> KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c
> (283)
> KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c
> (150)
> 
> Which is related to TSO, from what i gather, but i can't turn off tso on
> forcedeth... (i suspected this to cause corruption a while back....)
> 

If your network hardware or driver is flakey, try compiling a kernel
without that as well before reproducing this swap problem.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
