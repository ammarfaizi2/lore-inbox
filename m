Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVD3SbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVD3SbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 14:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVD3SbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 14:31:04 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:2776 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261333AbVD3Sa6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:30:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PEYlqHi2jOpc3AztCh+2O4blQrC2OuCAbB+TbThPJsA6elkzmmN8djjkfQ3AxKD4sDmwgGn3JOLI1t+/qeqYvQ3kng2sxuvYFMNNLKepjw+i8XNiYSEp1pXYsmH4PQ+UrxpVVLPgQRA6POB/U8nJfXcW3S4PLGMSTgLiGoIVn88=
Message-ID: <2cd57c90050430113078133010@mail.gmail.com>
Date: Sun, 1 May 2005 02:30:57 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc3-mm1
Cc: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@holomorphy.com>,
       Andi Kleen <ak@muc.de>
In-Reply-To: <20050430142035.GB3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050429231653.32d2f091.akpm@osdl.org>
	 <20050430142035.GB3571@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Fri, Apr 29, 2005 at 11:16:53PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.12-rc2-mm3:
> >...
> > +x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree.patch
> >
> >  x86_64 updates
> >...
> 
> This patch contains at least two bugs:
> 
> The static inline set_irq_info() is not available
> for CONFIG_GENERIC_PENDING_IRQ=n, resulting in the following warning:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/i386/kernel/io_apic.o
> arch/i386/kernel/io_apic.c: In function `set_ioapic_affinity_irq':
> arch/i386/kernel/io_apic.c:251: warning: implicit declaration of function `set_irq_info'
> ...
> 
> <--  snip  -->
> 
> The second bug is that although irq.h defines set_irq_info() as a static
> inline, this patch adds an empty function to kernel/irq/manage.c .
> 
> The second bug shadows the first bug, but both have to be fixed.

IMHO, there are no bugs at all, or at least not the kind of bugs you think.

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
