Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUBRG4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 01:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUBRG4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 01:56:42 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:30900 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S263513AbUBRG4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 01:56:40 -0500
Date: Wed, 18 Feb 2004 07:56:36 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040218065636.GD1146@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk> <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk> <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402171251130.2154@home.osdl.org> <Pine.LNX.4.58.0402171407461.23115@sm1420.belits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171407461.23115@sm1420.belits.com>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 02:42:11PM -0700, Alex Belits <abelits@belits.com> wrote:
>   Pretty much every charset other than Unicode does not NEED encoding
> because it was already designed to work with existing system. The decision
> to make the basic representation of charset full of zero bytes was the
> reason that created the need for UTF-8.

As I told you privately, you continiously confuse charset, encoding and
codeset. As well as spreading misinformation e.g. with respect to language
tagging (which unicode supports, mabe not well, but certainly better than
koi8-r, iso-8859-1 etc.) :(

> not have planned for multilingual environments like they should've done,
> but they aren't stupid enough to require someone to "bless" them with a
> variable-length encoding.

The only other "encoding" that I know that supports (very limited)
language tagging and works in a multilingual environment is iso-2022.
(maybe emacs has something else, or is iso-2022 based, I don't know,
correct me please). iso-2022, is horrible to use and didn't catch on in
many places because of this.

So it seems that these are your only choices. If there is a problem with
unicode, it can be fixed (just as problems have been fixed in the past),
and the resulting standard will be called "Unicode" and will map to
UTF-8, just as _every_ codeset maps to UTF-8 that is <21 bit (in a strict
interpretation) or >64 bit (in a lax interpretation).

I don't understand why you are arguing against unicode so vehemently
without having any other option, and without the need for any other
option.

Please note that the examples you make (koi8-r etc.) fail miserably in a
multilingual environment. koi8-r even starts to fail in a place near you,
where people use koi8-u, often tagges as koi8-r, because most software has
no good means to tag their texts.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
