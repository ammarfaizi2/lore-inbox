Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266588AbUBQVZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266608AbUBQVWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:22:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:3792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266654AbUBQVVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:21:19 -0500
Date: Tue, 17 Feb 2004 13:21:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Bradford <john@grabjohn.com>
cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <200402172116.i1HLGESi000350@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58.0402171318550.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
 <20040217204024.GE24311@mail.shareable.org> <200402172050.i1HKoLPG000210@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402171259440.2154@home.osdl.org>
 <200402172116.i1HLGESi000350@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, John Bradford wrote:
> > 
> > Wrong. UTF-8 can store UCS-4 characters just fine.
> 
> Does just fine include unambiguously?

If you don't care about backwards compatibility, then yes. You just have 
to use "strict" UTF-8.

>				  Sure, standards-conforming
> UTF-8 is unambiguous, but you've already said time and again that that
> doesn't happen in the real world.  I just don't agree on the UTF-8 can
> store UCS-4 characters just fine thing _at all_.

You get to choose between "throw the baby out with the bathwater" or "be 
compatible". 

Sane people choose compatibility. But it's your choice. You can always 
normalize thing if you want to - but don't complain to me if it breaks 
things. It will still break _fewer_ things than UCS-4 would, so even if 
you always normalize you'd still be _better_ off with UTF-8 than you would 
be with UCS-4.

		Linus
