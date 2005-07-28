Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVG1NCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVG1NCU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVG1NCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:02:20 -0400
Received: from coderock.org ([193.77.147.115]:2495 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261217AbVG1NCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:02:19 -0400
Date: Thu, 28 Jul 2005 15:02:19 +0200
From: Domen Puncer <domen@coderock.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Matt Porter <mporter@kernel.crashing.org>,
       wfarnsworth@mvista.com, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/3] ppc32: add 440ep support
Message-ID: <20050728130219.GB2249@homer.coderock.org>
References: <11224856623638@foobar.com> <20050727131857.78a56972.akpm@osdl.org> <17128.4407.838024.111955@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17128.4407.838024.111955@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/05 18:56 -0400, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > Matt Porter <mporter@kernel.crashing.org> wrote:
> > >
> > > +static u64 dma_mask = 0xffffffffULL;

How about just DMA_32BIT_MASK from dma-mapping.h, that one has to be
correct. ;-)

> > 
> > I'm sure you're totally uninterested in this, but the above will probably
> > generate warnings on (say) ppc64, where u64 is implemented as unsigned
> > long.
> > 
> > I usually chuck a simple `-1' in there and the compiler always gets it
> > right, regardless of signedness and size and architecture.
> 
> Umm, I think we actually want 2^32-1 not -1, don't we?  In which case
> I think Matt's code is what we have to have.
> 
> I tried a little test compile with gcc 4.0 with -m64 -Wall and it
> didn't generate a warning with the 0xffffffffULL constant.
