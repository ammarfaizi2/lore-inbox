Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284199AbRLKXjf>; Tue, 11 Dec 2001 18:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284198AbRLKXjS>; Tue, 11 Dec 2001 18:39:18 -0500
Received: from rj.SGI.COM ([204.94.215.100]:36066 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S284182AbRLKXjF>;
	Tue, 11 Dec 2001 18:39:05 -0500
Date: Wed, 12 Dec 2001 10:37:39 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Implementing POSIX ACLs - was Re: [PATCH] Revised extended attributes interface
Message-ID: <20011212103739.Q70201@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <20011210115209.C1919@redhat.com> <20011211124115.E70201@wobbly.melbourne.sgi.com> <20011211134758.F2268@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211134758.F2268@redhat.com>; from sct@redhat.com on Tue, Dec 11, 2001 at 01:47:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Stephen,

On Tue, Dec 11, 2001 at 01:47:58PM +0000, Stephen C. Tweedie wrote:
> > - Andreas made attempt #1 to get a system call interface agreed on
> > over a year ago now.  He incorporated several peoples suggestions,
> > but eventually the discussion got sidetracked, died and nothing
> > further happened;
> 
> Yep, and I brought up all these points last time, too.
> 
> > > But the ACL encoding is still hobbled: ...
> > 
> > I have been on the acl-devel mailing list for a long time now,
> > and while these features all sound like good ideas or interesting
> > projects, I have never seen anyone post a patch or request any
> > specific changes to Andreas' ACL encoding in that time.
> 
> It was proposed over a year ago on fsdevel-list.  I've attached the

Yeah, I know - I've read it.  What I was trying to say with "post a
patch or request any specific changes" is that we can make proposals
till the cows come home, but someone has to do the work and it seems
noone has implemented these things in the intervening year.

The encoding should cater for these future changes, for sure - through
a version or features field, or an ACL "family" concept, or whatever
(these things shouldn't pollute the generic EA interfaces though).
If the current POSIX ACL format isn't good enough for the needs that
you've foreseen, then it would be a good idea to suggest your changes
to Andreas directly.

Yes, it would help if the current format was documented. ;)  But the
code is there and the format it implements hasn't changed at all in
the year that's gone.

> > ...
> > His POSIX ACL encoding has a version field in it
> 
> Umm, and where in the EA man pages is this described?  How does an
> application use the EA API?  That's what I'm concerned about.  
> 
> > ...
> > so if/when some
> > people step forward to implement these features you've described,
> > and if they require changes to the format, then there should be no
> > reason they can't do it cleanly and in a filesystem-independent
> > manner, right?
> 
> What format?  There _is_ no defined format.

These are valid points - I have only read Andreas' code and I
don't believe the format he has chosen is documented anywhere.
It really should be and (imo) all system attributes should be
documented and incorporated into the extended attributes docs.

cheers.

-- 
Nathan
