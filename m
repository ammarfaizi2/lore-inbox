Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283618AbRLEAgw>; Tue, 4 Dec 2001 19:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283616AbRLEAgn>; Tue, 4 Dec 2001 19:36:43 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:4244 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S283613AbRLEAgc>; Tue, 4 Dec 2001 19:36:32 -0500
Date: Wed, 5 Dec 2001 01:36:30 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
Message-ID: <20011205013630.C717@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch> <9uj5fb$1fm$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9uj5fb$1fm$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Dec 04, 2001 at 10:42:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 10:42:51AM -0800, H. Peter Anvin wrote:
> > As told above, it could be cleaner, but I don't know of a nice method of
> > accessing byteorder dependent data through structures.
> 
> This isn't the right way to deal with this.  The right way to deal
> with this is to get all systems to read cramfs the same way.

Yes, from a CS point of view. 

But practically cramfs is created once to contain some kind of
ROM for embedded devices. So if we never modify these data again,
why not creating it in the required byte order? 

Why wasting kernel cycles for le<->be conversion? Just because
it's more general? For writable general purpose file systems it
makes sense, but to none of romfs, cramfs etc.

So I would prefer the given patch.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
