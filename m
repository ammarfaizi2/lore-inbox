Return-Path: <linux-kernel-owner+w=401wt.eu-S1760842AbWLHSrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760842AbWLHSrZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760845AbWLHSrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:47:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48219 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760842AbWLHSrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:47:23 -0500
Date: Fri, 8 Dec 2006 10:46:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it 
In-Reply-To: <4595.1165597017@redhat.com>
Message-ID: <Pine.LNX.4.64.0612081045430.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com> 
 <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
 <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au>
 <20061208085634.GA25751@flint.arm.linux.org.uk>  <4595.1165597017@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2006, David Howells wrote:
> 
> In fact I think more things have LL/SC than have CMPXCHG.

But you cannot expose ll/sc to C, so that's a bogus argument.

If you do ll/sc, you need to program in assembly language.

		Linus
