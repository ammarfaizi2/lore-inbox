Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVA1Pqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVA1Pqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVA1Pqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:46:40 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:9357 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261456AbVA1Pqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:46:37 -0500
Date: Fri, 28 Jan 2005 15:46:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
In-Reply-To: <20050128151839.GI6703@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0501281534420.7304@goblin.wat.veritas.com>
References: <20050128133927.GC6703@wotan.suse.de> 
    <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com> 
    <20050128143010.GE6703@wotan.suse.de> 
    <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com> 
    <20050128151839.GI6703@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Andi Kleen wrote:

> > Forgive me for not wading through the code, but it really needs to
> > be spelt out in the comments: what's wrong with the existing kernel,
> > with "noapic nolapic" in the distro's bootstring by default?
> 
> It's harder to explain and traditionally in LILO you couldn't remove
> any options (in grub you can now).

And it's just that initial installation boot, via grub, which really
matters.  Thereafter can be edited, before perhaps switching to LILO.

> I think it makes much more sense
> to have an positive option for this too, not a negative one. 

I do agree that positives are easier to understand than negatives,
and if it were some C variable I'd be arguing the same way.

But we seem to have a long tradition of "no" boot options to disable
features, and you're asking to reverse that tradition: fair enough,
but let's be clear about that.  Might be easiest to understand if
every "no" has a no-"no".  (But then where does the CONFIG come in?)

> Also I must add my patch fixes real bugs in the code, not just
> adding the new option.

Good, but then they should be in a separate patch.

> > I'm not going to be the only one confused by this!
> 
> I think there is much more confusion in the current way.

I'll shut up now, let's see what others think.

Hugh
