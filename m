Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbULVSYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbULVSYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbULVSYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:24:46 -0500
Received: from mail.suse.de ([195.135.220.2]:196 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262006AbULVSYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:24:24 -0500
Date: Wed, 22 Dec 2004 19:23:13 +0100
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com, vandrove@vc.cvut.cz
Subject: Re: [PATCH] [CAN-2004-1144] Fix int 0x80 hole in 2.4 x86-64 linux kernels
Message-ID: <20041222182313.GB3363@wotan.suse.de>
References: <20041222175818.GA3363@wotan.suse.de> <20041222182048.GM17946@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222182048.GM17946@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 07:20:48PM +0100, Willy Tarreau wrote:
> Hi Andi,
> 
> On Wed, Dec 22, 2004 at 06:58:18PM +0100, Andi Kleen wrote:
> (...)
> >  	sti
> > +	movl %eax,%eax	
> >  	pushq %rax
> 
> Although I don't know about x86_64 assembly, I know x86 and I wonder
> how this patch would do anything. I would personnaly have written something
> more like :

An 32bit write in long mode clears the upper 32bits of the register.
See the x86-64 architecture manuals for more details.

-Andi
