Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbTIHUnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTIHUnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:43:37 -0400
Received: from codepoet.org ([166.70.99.138]:47559 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S263670AbTIHUnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:43:35 -0400
Date: Mon, 8 Sep 2003 14:43:30 -0600
From: Erik Andersen <andersen@codepoet.org>
To: David Garfield <garfield@irving.iisd.sra.com>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>
Subject: Re: kernel header separation
Message-ID: <20030908204329.GA11418@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	David Garfield <garfield@irving.iisd.sra.com>,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk> <20030903014908.GB1601@codepoet.org> <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk> <20030905211604.GB16993@codepoet.org> <16220.58678.399619.878405@irving.iisd.sra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16220.58678.399619.878405@irving.iisd.sra.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 08, 2003 at 04:23:18PM -0400, David Garfield wrote:
> On the other hand, the ISO C99 definition is probably something like:
> an integral type capable of storing the values 0 through 255
> inclusive.  (ok, I don't have a copy of the new standard but I have
> seriously examined the old one.)  I would not count on uint8_t
> necessarily being unsigned on unusual hardware.  Linux on the other

While I can apprecieate the value of pure speculation
uncluttered by facts, I think you may want to actually read
what the ISO/IEC 9899:1999 (aka C99) has to say on the subject:

    7.18.1.1 Exact-width integer types

    1 The typedef name intN_t designates a signed integer type with
	width N, no padding bits, and a two's complement
	representation.  Thus, int8_t denotes a signed integer
	type with a width of exactly 8 bits.

    2 The typedef name uintN_t designates an unsigned integer type
	with width N. Thus, uint24_t denotes an unsigned integer
	type with a width of exactly 24 bits.

I had to buy my copy of C99, so I can't post the whole thing for
the world I'm afraid.  But you can visit the SuSv3 (which defers
to the C99 standard in cases where they differ) and read their
discussion of stdint.h, which is almost identical to the text in
C99 and is available online here:

    http://www.opengroup.org/onlinepubs/007904975/basedefs/stdint.h.html

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
