Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUHZFcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUHZFcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267668AbUHZFcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:32:31 -0400
Received: from waste.org ([209.173.204.2]:32443 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267664AbUHZFcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:32:22 -0400
Date: Thu, 26 Aug 2004 00:32:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Nicholas Miell <nmiell@gmail.com>
Cc: Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826053200.GU31237@waste.org>
References: <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093496948.2748.69.camel@entropy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 10:09:08PM -0700, Nicholas Miell wrote:
> On Wed, 2004-08-25 at 21:44, Matt Mackall wrote:
> > On Wed, Aug 25, 2004 at 05:42:21PM -0700, Nicholas Miell wrote:
> > > On Wed, 2004-08-25 at 16:46, Wichert Akkerman wrote:
> > > > Previously Jeremy Allison wrote:
> > > > > Multiple-data-stream files are something we should offer, definately (IMHO).
> > > > > I don't care how we do it, but I know it's something we need as application
> > > > > developers.
> > > > 
> > > > Aside from samba, is there any other application that has a use for
> > > > them? 
> > > > 
> > > 
> > > Anything that currently stores a file's metadata in another file really
> > > wants this right now. Things like image thumbnails, document summaries,
> > > digital signatures, etc.
> > 
> > That is _highly_ debatable. I would much rather have my cp and grep
> > and cat and tar and such continue to work than have to rewrite every
> > tool because we've thrown the file-is-a-stream-of-bytes concept out
> > the window. Never mind that I've got thumbnails, document summaries,
> > and digital signatures already.
> > 
> > While the number of annoying properties of files with forks is
> > practically endless, the biggest has got to be utter lack of
> > portability. How do you stick the thing in an attachment or on an ftp
> > site? Well you can't because it's NOT A FILE. 
> > 
> > A file is a stream of bytes.
> 
> "OMG! It breaks tar and email!!!" argument doesn't fly. Things break all
> the time and are fixed. It's called progress.

What it breaks is the concept of a file. In ways that are ill-defined,
not portable, hard to work with, and needlessly complex. Along the
way, it breaks every single application that ever thought it knew what
a file was.

Progress? No, this has been done before. Various dead operating
systems have done it or similar and regretted it. Most recently MacOS,
which jumped through major hurdles to begin purging themselves of
resource forks when they went to OS X. They're still there, but
heavily deprecated.

> cp, grep, cat, and tar will continue to work just fine on files with
> multiple streams.

Find some silly person with an iBook and open a shell on OS X. Use cp
to copy a file with a resource fork. Oh look, the Finder has no idea
what the new file is, even though it looks exactly identical in the
shell. Isn't that _wonderful_? Now try cat < a > b on a file with a
fork. How is that ever going to work?

I like cat < a > b. You can keep your progress.

-- 
Mathematics is the supreme nostalgia of our time.
