Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVBZUls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVBZUls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 15:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVBZUls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 15:41:48 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:9935 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261275AbVBZUlq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 15:41:46 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: arch/xen is a bad idea
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Sat, 26 Feb 2005 20:41:48 -0000
Message-ID: <A95E2296287EAD4EB592B5DEEFCE0E9D1E32B9@liverpoolst.ad.cl.cam.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: arch/xen is a bad idea
Thread-Index: AcUbidwQdhRSARx0REq9RcDjPuhoDQAuBVhQ
From: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <ak@suse.de>, <riel@redhat.com>, <linux-kernel@vger.kernel.org>,
       <Ian.Pratt@cl.cam.ac.uk>, <Steven.Hand@cl.cam.ac.uk>,
       <Christian.Limpach@cl.cam.ac.uk>, <Keir.Fraser@cl.cam.ac.uk>,
       <ian.pratt@cl.cam.ac.uk>, <ian.pratt@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > I think there's an interim compromise position that 
> everyone might go
> > for:
> > 
> > Phase 1 is for us to submit a load of patches that squeeze 
> out the low
> > hanging fruit in unifying xen/i386 and i386. Most of these will be
> > strict cleanups to i386, and the result will be to almost halve the
> > number of files that we need to modify.
> 
> OK.  It would be good to have a phase 0: any refactoring, 
> abstracting, etc
> to the core kernel and to i386 which is a preparatory step, prior to
> introducing any Xen code.  After phase 0 everything should 
> still compile
> and run.  The subsequent Xen patches should merely add stuff 
> and not move
> existing code around.

I think my phase 1 and your phase 0 are actually the same. I'm not
proposing that we put any Xen code in the tree at this point, but that
we do the many easy cleanups to i386 which will mean that we can remove
modifications to files from the arch/xen tree we maintain .

Example cleanups would be: use a macro for testing to see whether you're
in the kernel or not; use isa_bus_to_virt instead of phys_to_virt for
the access the address of the VGA console etc etc.

> What would you propose doing with the i386 header files?  Such as the
> pagetable handling?

We'd certainly still need to have xen-specific versions of some of the
i386 header files. Perhaps the neatest thing is to have an
include/asm-i386/xen ahead of include/asm-i386 on the include search
path?  Not sure.


Ian 
