Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbSKOGpd>; Fri, 15 Nov 2002 01:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSKOGpd>; Fri, 15 Nov 2002 01:45:33 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:42640 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S265880AbSKOGpc>; Fri, 15 Nov 2002 01:45:32 -0500
Date: Thu, 14 Nov 2002 21:44:57 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] eliminate pci_dev name
Message-ID: <20021114214457.I628@nightmaster.csn.tu-chemnitz.de>
References: <3DD3EB3D.8050606@pobox.com> <Pine.LNX.4.44.0211141031500.3323-100000@home.transmeta.com> <20021114184431.E30392@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20021114184431.E30392@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Thu, Nov 14, 2002 at 06:44:31PM +0000
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18CaL4-0005bW-00*UQFaFs4mWbk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thu, Nov 14, 2002 at 06:44:31PM +0000, Matthew Wilcox wrote:
> Sure, I can do that.  That leads me to think that maybe we should
> delete name from struct device and just use the one in struct kobject
> (which is already a mere 16 bytes).  But if we're going to go as far
> down as the kobject... that has a dentry.  And dentrys have names.
> So how about eliminating that too and just creating a dentry with the
> almost infinitely long name?
> 
> Maybe that's too much at this stage of the game.

Using the dentry the PERFECT cleanup, because it removes ALL the
redundacy and provides infinite length (which is sometimes
needed) as well as an optimization for small
(DNAME_INLINE_LEN_MIN) names.

So it's the perfect string container, if needed anyway.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
