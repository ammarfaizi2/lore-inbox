Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTBEWVS>; Wed, 5 Feb 2003 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbTBEWVS>; Wed, 5 Feb 2003 17:21:18 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:2835 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265065AbTBEWVR>; Wed, 5 Feb 2003 17:21:17 -0500
Date: Wed, 5 Feb 2003 22:30:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, torvalds@transmeta.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030205223047.A30669@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, "Stephen D. Smalley" <sds@epoch.ncsc.mil>,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <200302051647.LAA05940@moss-shockers.ncsc.mil> <20030205164948.A22628@infradead.org> <20030205220755.GA21652@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205220755.GA21652@kroah.com>; from greg@kroah.com on Wed, Feb 05, 2003 at 02:07:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 02:07:55PM -0800, Greg KH wrote:
> On Wed, Feb 05, 2003 at 04:49:48PM +0000, Christoph Hellwig wrote:
> > No it seems not pointless.  You add tons of undesigned cruft to 2.5 that
> > will have to be maintained through all of 2.6. unless Linus hopefully
> > pulls the plug soon enough.
> 
> I'm tired of reading this crap every time I submit a LSM patch.

And I'm tired of this hooks creaping all over the kernel like a cancer...

> I'll say it for the last time...  LSM was designed and didn't just plop
> into existence.  The group has published numerous design documents both
> explaining the decisions and rational behind the design and
> implementation of the project.  They are available at lsm.immunix.org,
> as you probably already know.  I know you don't like the implementation
> we currently have, but as no one has stepped up with a different
> implementation, that has been designed and tested to work for an
> extremely wide range of different security models, I suggest you stop
> this kind of attack.

Sorry, but I care for the Linux kernel and think adding this stuff all
over the place will not help us in the long term.  In fact I'm pretty sure
that > C2 grade security in a general purpose Operating System is a really
bad idea.  My first choice as a replacement would be throwing it out
of the kernel entirely.  As for less invasive and more though out design
if for whatever reason we still need to keep this we had tons of discussion
here on the lists and on irc.

The main point is that LSM in the current shape, with every single policy
detail left to the modules (compare that say to the linux filesystem code
where we have lots of very different filesystems and still have as much as
possible policy decision in the core code, this is one of the really strong
points of Linux!) is a very bad idea and I _really_ don't want to see
it in the next major stable release.

And no, I don't complain on every single patch, just those that are overly
ugly.

> > You still haven't even submitted a single example that actually uses
> > LSM into mainline.
> 
> Um, what's security/root_plug.c then?  :)

It's a small hack.  But if you think it's representative for LSM I'm
fine with that and I'll submit a patch removing every hook except of
the single one actually used by it.

