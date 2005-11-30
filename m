Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbVK3RdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbVK3RdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVK3RdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:33:07 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44261 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751478AbVK3RdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:33:06 -0500
Date: Wed, 30 Nov 2005 18:32:56 +0100
From: Andi Kleen <ak@suse.de>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130173256.GS19515@wotan.suse.de>
References: <20051130042118.GA19112@kvack.org> <438D4905.9F023405@users.sourceforge.net> <1133337416.2825.18.camel@laptopd505.fenrus.org> <438D60B0.4020207@yahoo.com.au> <438DE183.439170CD@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438DE183.439170CD@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 07:29:39PM +0200, Jari Ruusu wrote:
> Nick Piggin wrote:
> > Sounds like a trick question - I don't think the kernel does use any
> > out-of-tree amd64 assember code, does it? ;)
> 
> Out-of-tree amd64 assember code is being run in kernel space. For example:
> http://loop-aes.sourceforge.net/
> 
> Calling convention change that breaks existing assembler code that has been
> field proven and is believed to be entirely free of bugs for long time, does
> NOT belong in a STABLE kernel series.

I don't think you understand the policies of linux kernel development 
very well. 

If you want your code be maintained it's best to submit it to mainline.
Otherwise you're on your own.

Anyways - as long as your assembly code doesn't call any other kernel
services it should be enough to just save/restore R10 at the beginning/end.
Interrupts reload it automatically.

-Andi

