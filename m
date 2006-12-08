Return-Path: <linux-kernel-owner+w=401wt.eu-S1425679AbWLHQ7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425679AbWLHQ7V (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425670AbWLHQ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:59:20 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2346 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425668AbWLHQ7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:59:18 -0500
Date: Fri, 8 Dec 2006 16:58:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208165856.GF31068@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com> <20061208163127.GD31068@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612080841560.15472@schroedinger.engr.sgi.com> <20061208164733.GE31068@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612080848220.15847@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612080848220.15847@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 08:53:22AM -0800, Christoph Lameter wrote:
> On Fri, 8 Dec 2006, Russell King wrote:
> 
> > > Not having cmpxchg is even worse because it requires the introduction and 
> > > maintenance of large sets of arch specific operations. Much more complex.
> > 
> > And which bit of "not available on many architectures" have you not grasped
> > yet?
> 
> We discussed various forms of emulating that functionality on this thread. 
> Seems to work satisfactorily. You can discover the information you skipped 
> by going back to some earlier messages of this thread.

Oh for god sake.  I've put forward a coherent argument.  I've disproved
every point put forward by people for my approach.

ARM continues to be broken because people like you are stuck with doing
things only one way.  Grow up and open your mind to other possibilities.

(It should be noted that LDREX/STREX is broken on some ARM implementations
at the moment - they will cause a livelock due to silicon bugs if both
CPUs have exactly the same number of cycles between LDREX and STREX.
This makes loops-within-loops implementations using cmpxchg _extremely_
expensive on ARM.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
