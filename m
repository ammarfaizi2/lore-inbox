Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWCBEZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWCBEZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWCBEZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:25:25 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:50318
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751139AbWCBEZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:25:24 -0500
Date: Wed, 1 Mar 2006 20:24:55 -0800
From: Greg KH <gregkh@suse.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Greg KH <greg@kroah.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, perex@suse.cz, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060302042455.GB10464@suse.de>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org> <20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org> <20060301003452.GG23716@kroah.com> <1141175870.2989.17.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141175870.2989.17.camel@entropy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 05:17:49PM -0800, Nicholas Miell wrote:
> On Tue, 2006-02-28 at 16:34 -0800, Greg KH wrote:
> > On Tue, Feb 28, 2006 at 01:32:07AM -0500, Theodore Ts'o wrote:
> > > On Mon, Feb 27, 2006 at 03:45:25PM -0800, Greg KH wrote:
> > > > > So I just don't see any upsides to documenting anything private or 
> > > > > unstable. I see only downsides: it's an excuse to hide behind for 
> > > > > developers.
> > > > 
> > > > So should we just not even document anything we consider "unstable"?
> > > > The first trys at things are usually really wrong, and that only can be
> > > > detected after we've tried it out for a while and have a few serious
> > > > users.  Should we brand anything new as "testing" if the developer feels
> > > > it is ready to go?
> > > 
> > > How about "we don't let anything into mainline that we consider
> > > 'unstable' from an interface point of view"?
> > 
> > In a perfect world, where we are all kick-ass programmers and never get
> > anything wrong and can always anticipate exactly how people will use the
> > interfaces we create, sure we could say this.
> > 
> > But until then, there's no way this can happen :)
> > 
> > For example, look at all of the gyrations that the sys_futex call went
> > through.  It took people really using the thing before the final version
> > of how it would work could be added.
> > 
> > And another example, /proc.  How many times over the past 15 years have
> > we had to upgrade the procps package to handle the addition or change of
> > one thing or another?  We evolve over time to handle the issues that
> > come up with different architectures and needs.  That's what makes Linux
> > so great.
> 
> This is a really bad example.
> 
> All the /proc related contortions are a direct result of the fact that
> the multitudes of /proc "formats" are completely undocumented,
> non-extensible, and largely unintended for programmatic usage[1]. (/sys
> was supposed to solve some of these things, but it seems to be going the
> same route, unfortunately.)

sysfs is not going that same route at all.  Sure there are a small
majority of files that are multi-line, but they are in the minority by
far.

> Honestly, despite what the ASCII fetish crowd[2] may say, Solaris got it
> right by just exporting C structs. The parsing is certainly a hell of a
> lot easier when you're dealing with actual C datatypes instead of
> character strings and people hacking on /proc are probably less likely
> to make ABI breaking changes when they're dealing with a struct instead
> of a sprintf statement.

Even Solaris documents the maturity level of its interfaces, that is all
I am trying to do here.  I'm not trying to pass judgement on the quality
of any of these interfaces.

thanks,

greg k-h
