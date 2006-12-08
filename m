Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1426169AbWLHTit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426169AbWLHTit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426166AbWLHTit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:38:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54200 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426169AbWLHTir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:38:47 -0500
Date: Fri, 8 Dec 2006 11:37:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061208193116.GI31068@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612081136230.3516@woody.osdl.org>
References: <20061206195820.GA15281@flint.arm.linux.org.uk>
 <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk>
 <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk>
 <4595.1165597017@redhat.com> <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com>
 <20061208171816.GG31068@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612080919220.16029@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612081101280.3516@woody.osdl.org> <20061208193116.GI31068@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2006, Russell King wrote:
> 
> I utterly disagree.  I could code atomic_add() as:

Sure. And Alpha could do that too. If you write the C code a specific way, 
you can make it work. That does NOT mean that you can expose it widely as 
a portable interface - it's still just a very _nonportable_ interface that 
you use internally within one architecture to implement other interfaces.

			Linus
