Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbULVSrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbULVSrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbULVSrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:47:49 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:57610 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262000AbULVSrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:47:47 -0500
Date: Wed, 22 Dec 2004 19:47:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com, vandrove@vc.cvut.cz
Subject: Re: [PATCH] [CAN-2004-1144] Fix int 0x80 hole in 2.4 x86-64 linux kernels
Message-ID: <20041222184742.GN17946@alpha.home.local>
References: <20041222175818.GA3363@wotan.suse.de> <20041222182048.GM17946@alpha.home.local> <20041222182313.GB3363@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222182313.GB3363@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 07:23:13PM +0100, Andi Kleen wrote:
> > (...)
> > >  	sti
> > > +	movl %eax,%eax	
> > >  	pushq %rax
> > 
> > Although I don't know about x86_64 assembly, I know x86 and I wonder
> > how this patch would do anything. I would personnaly have written something
> > more like :
> 
> An 32bit write in long mode clears the upper 32bits of the register.

Ok, thanks for this quick precision, it wasn't obvious at first glance.

> See the x86-64 architecture manuals for more details.

Oh, I did a long time ago, when the athlon64 was only an emulator which ran
under linux, but I forgot all the details since then.

Thanks,
Willy

