Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267142AbSLRFb1>; Wed, 18 Dec 2002 00:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbSLRFb1>; Wed, 18 Dec 2002 00:31:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15876 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267142AbSLRFb0>; Wed, 18 Dec 2002 00:31:26 -0500
Message-ID: <3E0009EA.1010300@transmeta.com>
Date: Tue, 17 Dec 2002 21:38:50 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com> <1040189657.1562.11.camel@ixodes.goop.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> On Tue, 2002-12-17 at 09:55, Linus Torvalds wrote:
> 
>>Uli, how about I just add one ne warchitecture-specific ELF AT flag, which
>>is the "base of sysinfo page". Right now that page is all zeroes except
>>for the system call trampoline at the beginning, but we might want to add
>>other system information to the page in the future (it is readable, after
>>all).
> 
> 
> The P4 optimisation guide promises horrible things if you write within
> 2k of a cached instruction from another CPU (it dumps the whole trace
> cache, it seems), so you'd need to be careful about mixing mutable data
> and the syscall code in that page.
> 
> Immutable data should be fine.
>         

Yes, you really want to use a second page.

	-hpa



