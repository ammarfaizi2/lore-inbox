Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbSKGWVP>; Thu, 7 Nov 2002 17:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbSKGWVP>; Thu, 7 Nov 2002 17:21:15 -0500
Received: from crack.them.org ([65.125.64.184]:34568 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266606AbSKGWVO>;
	Thu, 7 Nov 2002 17:21:14 -0500
Date: Thu, 7 Nov 2002 17:28:54 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Cc: jw schultz <jw@pegasys.ws>
Subject: Re: Why are exe, cwd, and root priviledged bits of information?
Message-ID: <20021107222854.GA31412@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, jw schultz <jw@pegasys.ws>
References: <Pine.LNX.4.33L2.0211071052540.8252-100000@rtlab.med.cornell.edu> <20021107160521.GA18270@nevyn.them.org> <20021107221615.GA2249@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107221615.GA2249@pegasys.ws>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 02:16:15PM -0800, jw schultz wrote:
> On Thu, Nov 07, 2002 at 11:05:21AM -0500, Daniel Jacobowitz wrote:
> > On Thu, Nov 07, 2002 at 10:57:06AM -0500, Calin A. Culianu wrote:
> > > 
> > > In the /prod/PID subset of procfs, why are the exe, cwd, and root symlinks
> > > considered priviledged information?
> > > 
> > > Exe is the big one for me, as this one can be usually infered from reading
> > > /prod/PID/maps.  Root I guess can't be inferred in any unpriviledged way,
> > > and neither can cwd.  At any rate.. I am not sure behind the philosophy to
> > > make these symlinks' destinations priviledged...  can someone clarify
> > > this?
> > 
> > This came up a little while ago.  The answer is that maps should be
> > priviledged also.
> > 
> > For instance:
> >   You can protect a directory by giving its parent directory no read
> > permissions.  The name of the directory is now secret.  You don't want
> > to reveal it in cwd.
> > 
> 
> Daniel is correct in that the issue came up recently.  He
> gives _his_ answer above.  If you believe in security
> through obscurity you will agree with him.  I don't.
> I will agree that there should be no real reason to need
> access to this information.
> 
> With ACLs you will be able to explicitly grant access and
> you won't have to depend on keeping shared info secret.
> Then this will be less of an issue.

I recommend you go think about what security through obscurity actually
_means_.  If you think that an unreadable directory and a
randomly-generated subdirectory is security through obscurity, then in
what way is it actually different from a _password_?  That's what it
is.

Yes, this is poor-man's-ACLs.  It works in a lot of places when ACLs
won't.  For instance, an anonymous FTP server...

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
