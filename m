Return-Path: <linux-kernel-owner+w=401wt.eu-S1752411AbWLSE1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbWLSE1L (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbWLSE1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:27:11 -0500
Received: from iabervon.org ([66.92.72.58]:1387 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbWLSE1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:27:10 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 23:27:10 EST
Date: Mon, 18 Dec 2006 23:20:28 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Alexandre Oliva <aoliva@redhat.com>, Ricardo Galli <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612181839460.20138@iabervon.org>
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
 <orwt4qaara.fsf@redhat.com> <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
 <orpsah6m3s.fsf@redhat.com> <Pine.LNX.4.64.0612181134260.3479@woody.osdl.org>
 <or64c96ius.fsf@redhat.com> <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006, Linus Torvalds wrote:

> Static vs dynamic matters for whether it's an AGGREGATE work. Clearly, 
> static linking aggregates the library with the other program in the same 
> binary. There's no question about that. And that _does_ have meaning from 
> a copyright law angle, since if you don't have permission to ship 
> aggregate works under the license, then you can't ship said binary. It's 
> just a non-issue in the specific case of the GPLv2.

Under US law, the distinction is between works that are copyrightable 
themselves as "derivative works" and works that are derived from others, 
but aren't copyrightable. Provided you're allowed to ship aggregate works, 
the question is whether the output of "ld" is a copyrightable work 
distinct from the inputs.

I'd agree that "ar", like "mkisofs", doesn't create a derived work, but I 
think that "objcopy" does create a derived work, and "ld" does too, by 
virtue of modifying the objects it takes to resolve symbols. Now, you 
could distribute to somebody an ar archive of your program, and the 
recipient (given fair use rights to the copy of the program they received) 
could do "gcc program.a -o program" to link it. But I don't think you 
automatically get the right (under the "mere aggregation" permission) to 
distribute the result of relocating the symbols of gnutls around those of 
your program and vice versa, along with modifying the references to 
external symbols from each of these to point to specific locations.

	-Daniel
*This .sig left intentionally blank*
