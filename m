Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131209AbRCMVcR>; Tue, 13 Mar 2001 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131193AbRCMVcI>; Tue, 13 Mar 2001 16:32:08 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7373 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131199AbRCMVbt>;
	Tue, 13 Mar 2001 16:31:49 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103132105.f2DL5D8411265@saturn.cs.uml.edu>
Subject: Re: system call for process information?
To: npsimons@fsmlabs.com
Date: Tue, 13 Mar 2001 16:05:13 -0500 (EST)
Cc: g.liakhovetski@ragingbull.com (Guennadi Liakhovetski),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <20010312195647.A32437@fsmlabs.com> from "Nathan Paul Simons" at Mar 12, 2001 07:56:47 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Paul Simons writes:
> On Mon, Mar 12, 2001 at 09:21:37PM +0000, Guennadi Liakhovetski wrote:

>> CPU utilisation. Each new application has to calculate it (ps, top, qps,
>> kps, various sysmons, procmons, etc.). Wouldn't it be worth it having a
>> syscall for that? Wouldn't it be more optimal?
>
> 	No, it wouldn't be worth it because you're talking about 
> sacrificing simplicity and kernel speed in favor of functionality.
> This has been know to lead to "bloat-ware".  Every new syscall you

Bloat removal: being able to run without /proc mounted.

We don't have "kernel speed". We have kernel-mode screwing around
with text formatting.

> add takes just a little bit more time and space in the kernel, and
> when only a small number of programs will be using it, it's really 
> not worth it.  This time and space may not be large, but once you
> get _your_ syscall added, why can't everyone else get theirs added 
> as well?  And so, after making about a thousand specialized syscalls
> standard in the kernel, you end up with IRIX (from what I've heard).

This isn't just for him. Many people have wanted it.

> 	Don't even get me started about opening security holes, and
> increasing code complexity.  Please do a search for every other

I'll get you started. Compare:

1. variable-length ASCII strings with undefined ad-hoc syntax
2. array of fixed-size (64-bit) values

> ps - CPU time is cheap, that's why they don't charge for it anymore.
> Programmer time is _not_.

Parsing costs programmer time.
