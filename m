Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937897AbWLGBFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937897AbWLGBFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937894AbWLGBFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:05:54 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:48480 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937863AbWLGBFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:05:53 -0500
Date: Thu, 7 Dec 2006 02:05:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Matthew Wilcox <matthew@wil.cx>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612070203520.1867@scrub.home>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org>
 <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
 <20061206220532.GF3013@parisc-linux.org> <Pine.LNX.4.64.0612070130240.1868@scrub.home>
 <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Linus Torvalds wrote:

> > > To be honest, it'd be much easier if we only defined these operations on
> > > atomic_t's.  We have all the infrastructure in place for them, and
> > > they're fairly well understood.  If you need different sizes, I'm OK
> > > with an atomic_pointer_t, or whatever.
> > 
> > FWIW Seconded.
> 
> I disagree.
> 
> Any _real_ CPU will simply never care about _anything_ else than just the 
> size of the datum in question.

..or alignment which a dedicated atomic type would allow to be attached.

bye, Roman
