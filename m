Return-Path: <linux-kernel-owner+w=401wt.eu-S1425607AbWLHQcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425607AbWLHQcN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425600AbWLHQcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:32:12 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3388 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760764AbWLHQcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:32:11 -0500
Date: Fri, 8 Dec 2006 16:31:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208163127.GD31068@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 08:06:23AM -0800, Christoph Lameter wrote:
> On Fri, 8 Dec 2006, Russell King wrote:
> 
> > I'm trying to suggest a better implementation for atomic ops rather
> > than just bowing to this x86-centric "cmpxchg is the best, everyone
> > must implement it" mentality.
> 
> cmpxchg is the simplest solution to realize many other atomic operations 
> and its widely available on a wide variety of platforms. It is the most 
> universal atomic instruction that I know of. Other atomic operations may 
> be more efficient but certainly cmpxchg is the most universal.
> 
> Having multiple instructions with restrictions of what can be done in 
> between just complicates the use and seems to be arch specific. I have not 
> seen a better solution. Are you really advocating the weirdly complex 
> ll/sc be adopted by other architectures?

You're advocating cmpxchg is adopted by all architectures.  It isn't
available on many architectures, and those which it can be requires
unnecessarily complicated coding.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
