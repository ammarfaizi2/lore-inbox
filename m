Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266918AbSKLUHY>; Tue, 12 Nov 2002 15:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266922AbSKLUHY>; Tue, 12 Nov 2002 15:07:24 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:17678 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S266918AbSKLUHX>; Tue, 12 Nov 2002 15:07:23 -0500
Message-ID: <YWxhbg==.4ba29085391a15f8758a33f1e28f4c5b@1037131644.cotse.net>
Date: Tue, 12 Nov 2002 15:07:24 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
From: "Alan Willis" <alan@cotse.net>
To: <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200211121923.gACJNap10779@Port.imtp.ilyichevsk.odessa.ua>
References: <3DD01B32.4A113A71@digeo.com>
        <YWxhbg==.563e560fc9743df6e2cd56ac2568e2c0@1037049066.cotse.net>
        <3DD021D3.B7F1C511@digeo.com>
        <200211121923.gACJNap10779@Port.imtp.ilyichevsk.odessa.ua>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <akpm@digeo.com>, <alan@cotse.com>, <linux-kernel@vger.kernel.org>,
       <vs@namesys.com>
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Still running 2.5.46, put more memory in this machine (I need it
anyway, 256mb for what I do is truly masochistic) and now I have 384Mb.
 This time when pressuring memory (ever setup KDevelop for the first
time and index your documentation? not pretty) things got a bit
sluggish, then I tuned vm.swappiness to 50 (from 0).  About a minute
later it began swapping a bit
more, and things are much better.  When vm.swappiness was at 0, 1300 bytes
were swapped.  As I'm writing this, (vm.swappiness at 100) 39448 bytes are
swapped, after less than five minutes.

-alan


> On 11 November 2002 19:32, Andrew Morton wrote:
>> That sucker really works.  I run my desktop machines (768M and 256M)
>> at swappiness=80% or 90%.   I end up with 10-20 megs in swap after a
>> day or two, which seems about right.  The default of 60 is probably a
>> little too unswappy.
>
> I think swappiness should depend also on mem/disk latency ratio.
> Imagine you have 32Gb IDE 'disk' made internally of tons of DRAM chips
> (such things exist). I suppose you would like to swap more to it,
> since access times are not ~10 ms, they are more like 10 us.
>
> Hand tuning for optimal performance is doomed to be periodically
> obsoleted by technology jumps. Today RAM is 1000000 times faster
> than mass storage. Nobody knows what will happen in five years.
> --
> vda



