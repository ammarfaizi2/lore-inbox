Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288566AbSBIHlh>; Sat, 9 Feb 2002 02:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288594AbSBIHl1>; Sat, 9 Feb 2002 02:41:27 -0500
Received: from bitmover.com ([192.132.92.2]:41608 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S288566AbSBIHlS>;
	Sat, 9 Feb 2002 02:41:18 -0500
Date: Fri, 8 Feb 2002 23:41:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020208234118.C8129@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <3C649F4F.7E190D26@mandrakesoft.com> <20020209002920.Z15496@lynx.turbolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020209002920.Z15496@lynx.turbolabs.com>; from adilger@turbolabs.com on Sat, Feb 09, 2002 at 12:29:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 12:29:20AM -0700, Andreas Dilger wrote:
> Yes, that would be my thought as well.  Sadly, running the command
> 
> bk send -d -r+ -wgzip_uu -
> 
> does not work as I would _hope_ it would, namely putting a regular context
> diff at the beginning of the email, and gzip_uu for only the CSET.  

Whoops, that's a bug.  Type "bk sendbug" and send us a bug report, we'll
fix it.  Sorry about that.

> > But this is still a trial run of BK, so who knows what will wind up to
> > be the best policy for casual submitters.
> > 
> > And there's nothing wrong at all with sending GNU patches...
> 
> Oh, I agree that for people without BK they can keep sending patches.

It occurs to me that there is no reason you can't generate a regular
patch from BK and mail it to the list w/ the changeset comments.  That
keeps all the non-BK users perfectly happy, nothing has changed for
them and they can use BK or not as they see fit.  In addition, you can
send off a BK patch to Linus and/or stuff a patch into a publicly
available BK tree and point him at it.

If you all can reach any sort of concensus on what is a pleasant patch
format for non-BK users, just tell me, and I'll make sure BK can generate
that sort of patch easily.

> This might also be possible if BK could export/import a whole changeset
> in patch form, plus some magic stuff at the beginning/end (gzip_uu) which
> had all of the BK metadata in it, but I don't know if that is possible or
> desirable.

Well, send -d is essentially that - it's two patches, a GNU patch and a
BK patch.  It was a mistake for us to wrap the whole thing, we should
leave the regular diffs alone and just wrap the BK stuff.  We can do
that.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
