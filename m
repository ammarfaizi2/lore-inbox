Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbULVSVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbULVSVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbULVSVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:21:16 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:56074 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261839AbULVSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:21:06 -0500
Date: Wed, 22 Dec 2004 19:20:48 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com, vandrove@vc.cvut.cz
Subject: Re: [PATCH] [CAN-2004-1144] Fix int 0x80 hole in 2.4 x86-64 linux kernels
Message-ID: <20041222182048.GM17946@alpha.home.local>
References: <20041222175818.GA3363@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222175818.GA3363@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Wed, Dec 22, 2004 at 06:58:18PM +0100, Andi Kleen wrote:
(...)
>  	sti
> +	movl %eax,%eax	
>  	pushq %rax

Although I don't know about x86_64 assembly, I know x86 and I wonder
how this patch would do anything. I would personnaly have written something
more like :

+    movzl %eax,%rax

Once again, I may be wrong, but I really don't understand at all then.
Could you please either confirm or detail a bit more ?

thanks in advance,
Willy

