Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311161AbSCHV73>; Fri, 8 Mar 2002 16:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311169AbSCHV7T>; Fri, 8 Mar 2002 16:59:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:37046 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311161AbSCHV7H>; Fri, 8 Mar 2002 16:59:07 -0500
Date: Fri, 08 Mar 2002 13:59:01 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Dave Jones <davej@suse.de>, Patricia Gaughen <gone@us.ibm.com>
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Message-ID: <40480000.1015624741@flay>
In-Reply-To: <20020308223330.A15106@suse.de>
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com> <20020308223330.A15106@suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  As a sidenote (sort of related topic) :
>  An idea being kicked around a little right now is x86 subarch
>  support for 2.5. With so many of the niche x86 spin-offs appearing
>  lately, all fighting for their own piece of various files in
>  arch/i386/kernel/, it may be time to do the same as the ARM folks did,
>  and have..
> 
>   arch/i386/generic/
>   arch/i386/numaq/
>   arch/i386/visws
>   arch/i386/voyager/
>   etc..
> 
>  I've been meaning to find some time to move the necessary bits around,
>  and jiggle configs to see how it would work out, but with a pending
>  house move, I haven't got around to it yet.. Maybe next week.

I'm willing to help you out with this if you like (especially as I caused
some of the current ifdefs ;-)).
 
>  The downsides to this:
>  - Code duplication.
>    Some routines will likely be very similar if not identical.
>  - Bug propagation.
>    If something is fixed in one subarch, theres a high possibility
>    it needs fixing in other subarchs

The above are what I'm really afraid of. I think the best way to avoid 
most of the downside is to split up some of the current monster functions 
(like setup_arch) into generic and platform-specific parts ... exactly as 
Pat's patch does.

It would be nice to see a "blessing in principle" from Marcelo and
Linus before we / you start spending lots of time on this.

M.

