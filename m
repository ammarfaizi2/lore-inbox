Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263164AbTCTAuA>; Wed, 19 Mar 2003 19:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263183AbTCTAuA>; Wed, 19 Mar 2003 19:50:00 -0500
Received: from mail-1.tiscali.it ([195.130.225.147]:36668 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263164AbTCTAt6>;
	Wed, 19 Mar 2003 19:49:58 -0500
Date: Thu, 20 Mar 2003 02:00:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Mansfield <david@cobite.com>
Cc: David Mansfield <lkml@dm.cobite.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] cvsps support for parsing BK->CVS kernel tree logs
Message-ID: <20030320010032.GX30541@dualathlon.random>
References: <20030319223625.GS30541@dualathlon.random> <Pine.LNX.4.44.0303191837360.19298-100000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303191837360.19298-100000@admin>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 07:19:32PM -0500, David Mansfield wrote:
> On Wed, 19 Mar 2003, Andrea Arcangeli wrote:
> 
> > this is a critical feature for me, note that if Larry agreed of tagging
> > the tree with the atomic-date of the patchset extracting those patchset
> > would be an order of magnitude faster, I would pay for the RTT latency 1
> > per patchset, not once per file and it would be possible to teach cvsps
> > to learn diffing against the tag if it matches. Anyways stuff works now
> > so I'll just wait for the RTT all the time w/o being able to use the
> > real bandwidth provided by my link. As soon as the CVS tarball is
> > available I'll use it for the large patch extractions.
> 
> I just looked briefly at the 'cvs server' protocol.  It looks fairly easy 
> to have a 'keepalive' session with a server where multiple diffs of 
> multiple files are requested.  This isn't a 5 minute fix though, but I've 

this sounds an excellent plan if technically doable

> been bothered by the RTT per file as well, because we use 'ssh' to 
> authenticate cvs access here, and each file is a complete ssh handshake 
> which is very slow.

with ssh the latency would be exploded indeed, it takes quite some cpu too

> > One more feature wish (besides the python inteface for a quick gui) is
> > the C^c killing cvsps too during a -g patch extraction, you probably
> > should check the return code of cvs when extracting the patches. Right
> > now I press C^z and then I killall cvsps ;)
> 
> Already fixed in my code.  I won't bother you with a diff.

I'll fetch it with the next release, thanks.

Andrea
