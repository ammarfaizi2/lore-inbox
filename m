Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVLPSxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVLPSxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVLPSxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:53:15 -0500
Received: from quark.didntduck.org ([69.55.226.66]:46464 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932365AbVLPSxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:53:11 -0500
Message-ID: <43A30D36.5090406@didntduck.org>
Date: Fri, 16 Dec 2005 13:53:42 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Lee Revell <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
In-Reply-To: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> linux-os \(Dick Johnson\) <linux-os@analogic.com> wrote:
> 
> [...]
> 
> 
>>Throughout the past two years of 4k stack-wars, I never heard why
>>such a small stack was needed (not wanted, needed). It seems that
>>everybody "knows" that smaller is better and most everybody thinks
>>that one page in ix86 land is "optimum". However I don't think
>>anybody ever even tried to analyze what was better from a technical
>>perspective. Instead it's been analyzed as religious dogma, i.e.,
>>keep the stack small, it will prevent idiots from doing bad things.
> 
> 
> OK, so here goes again...
> 
> The kernel stack has to be contiguous in /physical/ memory. Keep the stack
> /one/ page, that way you can always get a new stack when needed (== each
> fork(2) or clone(2)). If the stack is 2 (or more) pages, you'll have to
> find (or create) a multi-page free area, and (fragmentation being what it
> is, and Linux routinely running for months at a time) you are in a whole
> new world of pain.

So what about arches where single-page stacks aren't viable (for example 
x86_64)?  Are we just screwed?

--
				Brian Gerst
