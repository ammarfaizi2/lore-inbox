Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUBQVAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUBQVAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:00:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:59839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266534AbUBQVAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:00:05 -0500
Date: Tue, 17 Feb 2004 12:59:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Bradford <john@grabjohn.com>
cc: viro@parcelfarce.linux.theplanet.co.uk, Jamie Lokier <jamie@shareable.org>,
       Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58.0402171251130.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
 <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, John Bradford wrote:
> 
> Why not:

I'll start with the first one. That already kills the rest.

> * State that filenames are strings of 32-bit words.  UCS-4 should be
>   the prefered format for storing text in them, but storing legacy
>   encodings in the low 8 bits is acceptable, (but a Bad Thing for new
>   installations).

UCS-4 is as braindamaged as UCS-2 was, and for all the same reasons.

It's bloated, non-expandable, and not backwards compatible.

In contrast, UTF-8 doesn't measurably expand any normal text that didn't 
need it, is backwards compatible in the major ways that matter, and can be 
extended arbitrarily.

UCS-4 has _zero_ advantages over UTF-8. 

Please. Give it up. Anybody who thinks that _any_ other encoding format 
than UTF-8 is valid is just _wrong_. 

(Now, I'll give that a lot of people don't like Unicode, so I'll allow
that maybe you'd want to use the UTF-8 _encoding_scheme_ for some other
mapping, but I don't see that that is worth the pain any more. Unicode may
be a horrible enumeration, but in the end all font encodings are arbitrary
anyway, so the unicode haters might as well start giving up).

In short: even if you hate Unicode with a passion, and refuse to touch it
and think standards are worthless, you should still use the same
transformation that UTF-8 does to your idiotic character set of the day. 
Because the _transform_ makes sense regardless of character set encoding.

		Linus
