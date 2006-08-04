Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161479AbWHDXrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161479AbWHDXrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161584AbWHDXrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:47:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:44963 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161479AbWHDXrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:47:36 -0400
Message-ID: <44D3DC7E.70100@zytor.com>
Date: Fri, 04 Aug 2006 16:47:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       vgoyal@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com> <m1k65onleq.fsf@ebiederm.dsl.xmission.com> <20060804233815.GG18792@redhat.com>
In-Reply-To: <20060804233815.GG18792@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Aug 04, 2006 at 05:14:37PM -0600, Eric W. Biederman wrote:
> 
>  > I guess the practical question is do people see a real performance benefit
>  > when loading the kernel at 4MB?
> 
> Linus claimed lmbench saw some huge wins. Others showed that for eg,
> a kernel compile took the same amount of time, so take from that what you will..
> 
>  > Possibly the right solution is to do like I did on x86_64 and simply remove
>  > CONFIG_PHYSICAL_START, and always place the kernel at 4MB, or something like
>  > that.
>  > 
>  > The practical question is what to do to keep the complexity from spinning
>  > out of control.  Removing CONFIG_PHYSICAL_START would seriously help with
>  > that.
> 
> Given the two primary uses of that option right now are a) the aforementioned
> perf win and b) building kexec kernels, I doubt anyone would miss it once
> we go relocatable ;-)
> 

We DO want the performance gain with a conventional bootloader.  The 
perf win is about the location of the uncompressed kernel, not the 
compressed kernel.

	-hpa

