Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311149AbSCHVnI>; Fri, 8 Mar 2002 16:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311150AbSCHVmr>; Fri, 8 Mar 2002 16:42:47 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:26116 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S311149AbSCHVmn>;
	Fri, 8 Mar 2002 16:42:43 -0500
Date: Fri, 8 Mar 2002 13:34:27 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@suse.de>, Patricia Gaughen <gone@us.ibm.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Message-ID: <20020308213427.GC28541@kroah.com>
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com> <20020308223330.A15106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020308223330.A15106@suse.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 08 Feb 2002 18:57:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 10:33:30PM +0100, Dave Jones wrote:
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

YES!!!
I've been working on the Foster patches and keep thinking that this
would be the best solution to our current #ifdef hell.

>  I've been meaning to find some time to move the necessary bits around,
>  and jiggle configs to see how it would work out, but with a pending
>  house move, I haven't got around to it yet.. Maybe next week.
> 
>  The downsides to this:
>  - Code duplication.
>    Some routines will likely be very similar if not identical.
>  - Bug propagation.
>    If something is fixed in one subarch, theres a high possibility
>    it needs fixing in other subarchs

Make sure that every subarch has a maintainer/someone to blame who needs
to make sure their subarch also keeps up to date with the "generic" one
would help out a lot with this problem.

>   The plus sides of this:
>   - Removal of #ifdef noise
>     With more and more of these subarchs appearing, this is getting
> 	more of an issue.
>   - subarchs are free to do things 'their way' without affecting the
>     common case.

I think Martin's recent CONFIG_MULTIQUAD patches prove that the plus
side would outweigh any possible downside :)

thanks,

greg k-h
