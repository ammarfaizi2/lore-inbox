Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUC1SyX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUC1SyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:54:23 -0500
Received: from gprs214-54.eurotel.cz ([160.218.214.54]:19841 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262316AbUC1SyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:54:21 -0500
Date: Sun, 28 Mar 2004 20:54:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ivan Godard <igodard@pacbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel support for peer-to-peer protection models...
Message-ID: <20040328185410.GE406@elf.ucw.cz>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21> <20040327103401.GA589@openzaurus.ucw.cz> <066b01c41464$7e0ec9c0$fc82c23f@pc21> <20040328062422.GB307@elf.ucw.cz> <06ea01c4148e$67436c80$fc82c23f@pc21>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ea01c4148e$67436c80$fc82c23f@pc21>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I meant "User Mode Linux" == linux running under linux. Someone
> > probably has an URL.
> 
> Sorry - I plead ignorance :-)  As the protection is recursive and
> transitive, I suppose that you could do this. When the UMK (user mode
> kernel) went to change the "real" machine it would get a protection fault
> that would be handled by the KMK, emulating the effect. Getting it right and
> also performant would be tricky though - is UML a necessary feature?

No. Its just "nice to have", and it does not support too many
architectures.

> > Strange system.... If an application does not grant kernel access to
> > its space, how is kernel supposed to do its job? For example, that
> > "paranoid DLL" becomes unswappable, then?
> 
> Pretection is in the *virtual* space, not physical. The physical-page
> manager (who has the TLB and underlying mapping tables in its space) can see
> and deal with any physical address, which in turn has the usual aliasing
> relationship with virtual addresses. Of course, physical is just one of the
> virtual spaces (and is distinguished solely by the one-to-one
> virtual-physical mapping). So the protection can be penetrated by anyone who
> can see the underlying physical page - but that's always true.

Aha, so some part of kernel exist that has "absolute right". Ok, now I
can imagine that it can work.

> > If most changes are in arch/, it should be acceptable...
> 
> I fear that it might be more extensive than that :-)

Well, make patch and lets see... That means that 2.8 needs to be your
target. If impact outside of arch is not "total rewrite", you might
have a chance. If it is "total rewrite".... well you just need to be
very clever.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
