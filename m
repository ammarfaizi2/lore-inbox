Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUBRGsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 01:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBRGsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 01:48:12 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:26292 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S261909AbUBRGsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 01:48:08 -0500
Date: Wed, 18 Feb 2004 07:48:05 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040218064805.GC1146@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk> <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk> <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk> <20040217204024.GE24311@mail.shareable.org> <200402172050.i1HKoLPG000210@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402171259440.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171259440.2154@home.osdl.org>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 01:04:14PM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> Admittedly you might need up to six octets for the worst case, but hey, 
> since you only need one for the most common case (by _far_), who cares?

Beign a fan of UTF-8, I still have to remark that this is a rather imperialistic view that only
happens to work in many western countries.

It starts to fail in greece, russia and asian countries, where text size
goes up by a factor of 1.5 .. 3.

This was _one_ of the major obstacles that utf-8 had to overcome in asian
countries.

Personally, I think that's not a big problem (memory for text storage is
cheap etc.. :), but I am living in a iso-8859-1 world with only occasional
voyages elsewhere.

> And with the same UTF-8 encoding, you could some day encode UCS-8 too if
> the idiotic standards bodies some day decide that 4 billion characters 
> isn't enough because of all the in-fighting. 

Four billion glyphs will be not be reached, of course, but it's not
impossible that some codeset space inflation will happen due to the
introduction of extra planes for strange purposes.

> Of course, since you like UCS-4, you don't care about backwards 
> compatibility. 

While UCS-2 is obviously useless, UCS-4 is useful in rare cases where you
either need fixed character sizes or the inflation to 5 or 6 byte values
becomes a problem (which should be never).

Using UCS-4 for filenames is just evil (of course :)

UTF-8 was invented for the purpose of mapping unicode to filenames, and
it certainly is the most sane encoding so far, since it doesn't share the
"artificial" limitations to 16, 21 or 32 bits that other unicode encodings
have.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
