Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUBQVJO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUBQVJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:09:10 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:24960 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266601AbUBQVHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:07:24 -0500
Date: Tue, 17 Feb 2004 21:06:51 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402172106.i1HL6pQe000331@81-2-122-30.bradfords.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Jamie Lokier <jamie@shareable.org>,
       Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402171251130.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
 <20040216200321.GB17015@schmorp.de>
 <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org>
 <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de>
 <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org>
 <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org>
 <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402171251130.2154@home.osdl.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Linus Torvalds <torvalds@osdl.org>:
> 
> 
> On Tue, 17 Feb 2004, John Bradford wrote:
> > 
> > Why not:
> 
> I'll start with the first one. That already kills the rest.
> 
> > * State that filenames are strings of 32-bit words.  UCS-4 should be
> >   the prefered format for storing text in them, but storing legacy
> >   encodings in the low 8 bits is acceptable, (but a Bad Thing for new
> >   installations).
> 
> UCS-4 is as braindamaged as UCS-2 was, and for all the same reasons.
> 
> It's bloated, non-expandable, and not backwards compatible.

Which I hardly see as real pain for filenames, especially as I covered
the backward compatibility bit anyway, and wanting to expand beyond
2^31 characters isn't really on my to-do list at the moment, which
just leaves filename bloat, which is laughably trivial in at least
99.9% of cases, and probably just a minor inconvenience the other
0.1%.

But, I don't think I care anymore, anyway, clearly we are going to end
up with UTF-8 filenames everywhere, and security vulnerabilities to go
with them, and as long as I'm aware of that fact, I should be OK.

John.
