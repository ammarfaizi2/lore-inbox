Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267034AbUBRA4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267036AbUBRA4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:56:33 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S267034AbUBRA4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:56:31 -0500
Date: Wed, 18 Feb 2004 00:52:06 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402180052.i1I0q6Wh000340@81-2-122-30.bradfords.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Marc <pcg@goof.com>, Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402171318550.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org>
 <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de>
 <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org>
 <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org>
 <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
 <20040217204024.GE24311@mail.shareable.org>
 <200402172050.i1HKoLPG000210@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402171259440.2154@home.osdl.org>
 <200402172116.i1HLGESi000350@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402171318550.2154@home.osdl.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sane people choose compatibility. But it's your choice. You can always 
> normalize thing if you want to - but don't complain to me if it breaks 
> things. It will still break _fewer_ things than UCS-4 would, so even if 
> you always normalize you'd still be _better_ off with UTF-8 than you would 
> be with UCS-4.

Well, if all the UTF-8 diddling is eventually done by glibc, or some
other library, it might just be made to work.

The keep-it-in-UTF-8-all-the-time thing will still break down when a
user inputs a filename by copying the display of a badly encoded
filename using GPM, or in X, but that isn't a kernel issue.

I still don't really get what enforcing strictly standards compliant
UTF-8 has to do with backwards compatibility, though.

_But_ at least I'm about 5% more confident that filenames won't
suddenly blow up in my face, so I can sleep soundly tonight :-).

John.
