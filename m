Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268140AbUHXQ6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268140AbUHXQ6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUHXQ6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:58:34 -0400
Received: from mail.dif.dk ([193.138.115.101]:42681 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268140AbUHXQ6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:58:22 -0400
Date: Tue, 24 Aug 2004 19:03:55 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Shouldn't kconfig defaults match recommendations in help text?
In-Reply-To: <16683.22576.781038.756277@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.61.0408241859420.2770@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0408232347380.3767@dragon.hygekrogen.localhost>
 <16683.22576.781038.756277@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Mikael Pettersson wrote:

> Jesper Juhl writes:
>  > [quote]
>  > 
>  > The processor's performance-monitoring counters are special-purpose
>  > global registers. This option adds support for virtual per-process
>  > performance-monitoring counters which only run when the process
>  > to which they belong is executing. This improves the accuracy of
>  > performance measurements by reducing "noise" from other processes.
>  > 
>  > Say Y.
>  > 
>  >   Virtual performance counters support (PERFCTR_VIRTUAL) [N/y/?] (NEW)
>  > 
>  > [/quote]
>  > 
>  > 
>  > I just picked the above randomly, there are several other cases like it.
>  > 
>  > The comment clearly makes a recommendation that the user enables (in this 
>  > case) the option, yet the default is the exact opposite. What is the point 
>  > in that?
>  > I don't see anything but confusion amongst users as the result of such 
>  > inconsistency.
> 
> This particular mismatch occurs because the Kconfig entry
> doesn't have a "default" line, so Kconfig defaults to "n".
> 
> It makes little sense to disable PERFCTR_VIRTUAL when
> PERFCTR is enabled, so providing a "default y" for
> PERFCTR_VIRTUAL is the right thing to do.
> (It's an option because the design allows several
> independent high-level services on top of the low-level
> code. Currently there's only one high-level service in
> 2.6-mm, but with several it's reasonable to allow users
> to enable only those they actually want.)
> 
I had not investigated it in detail since it was simply one randomly 
picked example out of several, but thank you for the detailed explanation.


>  > Would patches to change default configuration choices to match the 
>  > recommendation given in the help text (if any) be acceptable? If not I'd 
>  > be interrested in the reasons why not.
>  > 
>  > If such patches are acceptable/wanted I'll be happy to supply them.
> 
> Feel free to do so :-)
> 
I'll post such patches in a short while. Sepperate mails, one pr patch 
changing one kconfig default pr patch.


--
Jesper Juhl
