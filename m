Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTJCKrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 06:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263707AbTJCKrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 06:47:31 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14464 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263705AbTJCKra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 06:47:30 -0400
Date: Fri, 3 Oct 2003 11:47:28 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310031047.h93AlSWB000506@81-2-122-30.bradfords.org.uk>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: karim@opersys.com, linux-kernel@vger.kernel.org
In-Reply-To: <E1A5M5a-00057S-00@wisbech.cl.cam.ac.uk>
References: <E1A5M5a-00057S-00@wisbech.cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You might find that that's a dis-advantage as you scale up.
> 
> I should probably make it clear exactly how resources are muxed in the
> current version of Xen. 

[snip]

Ah, OK, I wasn't aware how far advanced you were on this.  I should
have read up a bit more :-).

> > What is the performance penalty of running an X86-Xeno port of an OS
> > natively on the hardware?  Some distributions may not be prepared to
> > support it in addition to native X86, but if they can make X86-Xeno
> > their main architecture...
> 
> Right, another good point. The performance penalty on a range of
> system benchmarks (including SPEC WEB99) shows that there's up to
> around 5% overhead for running x86-xen. This is far far less than any
> other virtualization of x86 that is capable of running full OSes.

I think we might be talking about different things -  what I meant was
if you run a kernel compiled to support Xen on X86 natively without
Xen, is there a big performance penalty, not if you run a single VM in
Xen?  I'm thinking that if $BigDistro's installation CD will install
just the same in a virtual machine as anywhere else it'll help to gain
acceptance, and if the performance penalty is low enough, there won't
be a problem there.  Or, to look at it another way, you're effectively
sidestepping the need to distribute a patched OS, because the patched
OS *is* the distributions normal OS.  On the other hand, we don't want
to introduce anything to mainline that is going to hurt embedded
applications, so I think it would be likely to be a distribution
thing.

> Device
> drivers would be written according to a well-defined interface,
> implemented within Xen, or within isolated "domains" running atop of
> Xen. This kind of fits with the previous observation -- we want
> zseries for x86 :-)

Z/Series represents a lot more than just virtualisation :-).

On the other hand, I'm sure there are installations where the
virtualisation is the only aspect that they couldn't live without.

John.
