Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUBRVZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUBRVZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:25:57 -0500
Received: from linux.us.dell.com ([143.166.224.162]:53922 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S268154AbUBRVYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:24:41 -0500
Date: Wed, 18 Feb 2004 15:24:03 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Clay Haapala <chaapala@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib routines
Message-ID: <20040218152403.A30333@lists.us.dell.com>
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com> <20040203175006.GA19751@chaapala-lnx2.cisco.com> <20040203185111.GA31138@waste.org> <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com> <20040203172508.B26222@lists.us.dell.com> <20040203233737.GD31138@waste.org> <yquj4qu6g6ui.fsf@chaapala-lnx2.cisco.com> <20040204172116.GF31138@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040204172116.GF31138@waste.org>; from mpm@selenic.com on Wed, Feb 04, 2004 at 11:21:16AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 11:21:16AM -0600, Matt Mackall wrote:
> On Wed, Feb 04, 2004 at 10:14:13AM -0600, Clay Haapala wrote:
> > On Tue, 3 Feb 2004, Matt Mackall said:
> > > On Tue, Feb 03, 2004 at 05:25:08PM -0600, Matt Domsch wrote:
> > >> > >> +MODULE_LICENSE("GPL and additional rights");
> > >> > > 
> > >> > > "additional rights?"
> > >> > > 
> > >> > Take it up with Matt_Domsch@dell.com -- it's his code that I
> > >> > cribbed, so that's the license line I used.
> > >> 
> > >> The crc32 code came from linux@horizon.com with the following
> > >> copyright abandonment disclaimer, which is still in lib/crc32.c:
> > >> 
> > >> /*
> > >>  * This code is in the public domain; copyright abandoned.
> > >>  * Liability for non-performance of this code is limited to the
> > >>  * amount you paid for it.  Since it is distributed for free, your
> > >>  * refund will be very very small.  If it breaks, you get to keep
> > >>  * both pieces.  */
> > >> 
> > >> Thus GPL plus additional rights is appropriate.
> > > 
> > > Ok, makes sense for CRC32 stuff which can be easily lifted from the
> > > kernel or 50 other places, but not for stuff that's depends on
> > > cryptoapi.
> > 
> > Matt is correct about crypto/crc32c.c -- that should be simply "GPL".
> > 
> > As for the derived-from-public-domain-CRC32 stuff, should one even
> > claim "GPL" on it?  That would be, in effect, licensing public-domain
> > code and placing restrictions on it, something only a copyright holder
> > should be able to do, and not the intent of the author, in this case.
> 
> Hard to guess what the author's intent was as he left no license, but
> perhaps you're right. However, public domain works are routinely
> relicensed by publishers when they make a trivially derived work, see
> any reprint of Shakespeare or Bach. 
> 
> As has been pointed out, _not_ putting some sort of license on it
> potentially opens people who ship it up to liability. Arguably, by
> compiling it into the kernel, you're accepting the GPL liability terms
> for that use. But that doesn't stop someone from taking crc32.c,
> incorporating it into something else, having it blow up disastrously,
> and then suing whoever sold them the kernel tarball. Sounds
> outlandish, but crazier things have happened.
> 
> As "dual GPL/public domain license" is an oxymoron, the best thing to
> do is probably to slap a dual GPL/2-clause BSD license on it to
> disclaim liability while minimally limiting all other rights. Matt,
> since you're the last one to touch this, I'll let you make the call,
> but here's what I would suggest (still needs an actual copyright
> notice):

After seeking advice from Dell's lawyers, they recommend simply adding
the GPL license text to the top of the file and be done with it.
It's public domain, we're free to include (and relicense) it as we
wish.  If someone else wants to use it in a non-GPL fashion, they'll
need to start from the original public domain submission, not this one
which clearly has been modified somewhat since we first received it,
with faster algorithms, creation of the table at compile time, etc.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
