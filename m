Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266203AbUHGA5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUHGA5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 20:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUHGA5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 20:57:14 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:8671 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266203AbUHGA5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 20:57:12 -0400
Date: Fri, 6 Aug 2004 21:01:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
In-Reply-To: <cf10v3$h9l$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.58.0408062100430.19619@montezuma.fsmlabs.com>
References: <20040805200622.GA17324@logos.cnet> <20040806155328.GA21546@logos.cnet>
 <4113B752.7050808@vlnb.net> <20040806170931.GA21683@logos.cnet>
 <cf10v3$h9l$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, H. Peter Anvin wrote:

> Followup to:  <20040806170931.GA21683@logos.cnet>
> By author:    Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> In newsgroup: linux.dev.kernel
> > > >
> > > >Yes correct. *mb() usually imply barrier().
> > > >
> > > >About the flush, each architecture defines its own instruction for doing
> > > >so,
> > > > PowerPC has  "sync" and "isync" instructions (to flush the whole cache
> > > > and instruction cache respectively), MIPS has "sync" and so on..
> > >
> > > So, there is no platform independent way for doing that in the kernel?
> >
> > Not really. x86 doesnt have such an instruction.
> >
>
> Actually it does (sfence, lfence, mfence); they only apply to SSE
> loads and stores since all other x86 operations are guaranteed to be
> strictly ordered.

How about the, rather brutal, wbinvd?
