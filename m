Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSLQUJP>; Tue, 17 Dec 2002 15:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSLQUJP>; Tue, 17 Dec 2002 15:09:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20490 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265568AbSLQUJO>; Tue, 17 Dec 2002 15:09:14 -0500
Message-ID: <3DFF8638.4090509@transmeta.com>
Date: Tue, 17 Dec 2002 12:16:56 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>	<3DFF772E.2050107@transmeta.com>  <160470000.1040153210@flay> <1040158271.20765.26.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1040158271.20765.26.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2002-12-17 at 19:26, Martin J. Bligh wrote:
> 
>>>>It's not as good as a pure user-mode solution using tsc could be, but
>>
>>You can't use the TSC to do gettimeofday on boxes where they aren't 
>>syncronised anyway though. That's nothing to do with vsyscalls, you just
>>need a different time source (eg the legacy stuff or HPET/cyclone).
> 
> 
> Ditto all the laptops and the like. With code provided by the kernel we
> can cheat however. If we know the fastest the CPU can go (ie full speed
> on spudstop/powernow etc) we can tell the tsc value at which we have to
> query the kernel to get time to any given accuracy, so allowing limited
> caching
> 
> Ditto by knowing the worst case drift on summit
> 

Clever.  I like it :)

	-hpa


