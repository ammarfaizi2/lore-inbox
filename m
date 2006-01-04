Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWADFvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWADFvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 00:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWADFvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 00:51:23 -0500
Received: from dvhart.com ([64.146.134.43]:36842 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964892AbWADFvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 00:51:22 -0500
Message-ID: <43BB6255.2030903@mbligh.org>
Date: Tue, 03 Jan 2006 21:51:17 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>, mingo@elte.hu,
       tim@physik3.uni-rostock.de, arjan@infradead.org, torvalds@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de> <20060102102824.4c7ff9ad.akpm@osdl.org> <43BB0B8B.1000703@mbligh.org> <20060104042822.GA3356@waste.org>
In-Reply-To: <20060104042822.GA3356@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>On Tue, Jan 03, 2006 at 03:40:59PM -0800, Martin J. Bligh wrote:
>  
>
>>It seems odd to me that we're doing this by second-hand effect on
>>code size ... the objective of making the code smaller is to make it
>>run faster, right? So ... howcome there are no benchmark results
>>for this?
>>    
>>
>
>Because it's extremely hard to design a benchmark that will show a
>significant change one way or the other for single kernel functions
>that doesn't also make said functions unusually cache-hot. And part of
>the presumed advantage of uninlining is that it leaves icache room for
>random other code that you're _not_ benchmarking.
>
>In other words, if it's not a microbenchmark, it generally can't be
>measured, directly or indirectly. And if it is a microbenchmark, the
>result is known to be biased.
>  
>
Well, it's not just one function, is it? It'd seem that if you unlined
a whole bunch of stuff (according to this theory) then normal
macro-benchmarks would go faster? Otherwise it's all just rather
theoretical, is it not?

>In the rare case of functions that are extremely popular (like
>spinlock and friends), we _can_ actually see small improvements in
>macrobenchmarks like kernel compiles. So it's fairly reasonable to
>assume that reducing icache footprint really does matter more than
>cycle count and extrapolate that to other functions.
>  
>
Cool, that sounds good. How much are we talking about?
I didn't see that in the thread anywhere ... perhaps I just
missed it, sorry it got long ;-)

M.
