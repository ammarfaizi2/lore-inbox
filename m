Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310767AbSCHJco>; Fri, 8 Mar 2002 04:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310766AbSCHJcf>; Fri, 8 Mar 2002 04:32:35 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:48401 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S310764AbSCHJcW>;
	Fri, 8 Mar 2002 04:32:22 -0500
Date: Fri, 8 Mar 2002 10:32:11 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
cc: "Jonathan A. George" <JGeorge@greshamstorage.com>
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <Pine.LNX.4.44L.0203072137530.2181-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0203081004190.2580-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Rik van Riel wrote:

> On Thu, 7 Mar 2002, Jonathan A. George wrote:
> > Rik van Riel wrote:

I'd recommend everybody to give arch a try. It's still in an early 
development stage but functional. More testing is needed to make it 
progress. http://www.regexps.com/

> > >1) working merges
> >
> > Can you be more specific?
> 
> You do a merge of a particular piece of code once.
> After that the SCM remembers that this merge was done
> already and doesn't ask me to do it again when I move
> my code base to the next official kernel version.

You can do that, can have separate branches, distributed repository, any 
normal development tree can be an arch. You have reconcile among 
distributed versions, star-merge, patches replay or update in any 
direction. You choose what you want to merge, you can always list the 
missing patches, you can generate the needed patches to join the 
branches...

> > >2) atomic checkins of entire patches, fast tags
> >
> > I was thinking about something like automatically tagged globally
> > descrete patch sets.  It would then be fairly simple to create a tool
> > that simply scanned, merged, and checked in that patch as a set.  Is
> > something like this what you have in mind?
> 
> Yes, but doing this with the CVS storage as back-end
> would just be too slow.  Also, the CVS model wouldn't
> be able to easily clean out the tree afterwards if a
> checkin is interrupted halfway through.

Patchsets are available too.

> > >3) graphical 2-way merging tool like bitkeeper has
> > >   (this might not seem essential to people who have
> > >   never used it, but it has saved me many many hours)
> >
> > Would having something like VIM or Emacs display a patch diff with
> > providing keystroke level merge and unmerge get toward helpful for
> > something like this, or is the need too complex to address that way?
> 
> That would work, but you really need to try bitkeeper's
> graphical 2-way merge tool (or even a screenshot) to see
> how powerful such a simple thing can (and should) be.

No fancy graphical tools, but great text tools by now.

> > >4) distributed repositories
> >
> > Can you be more specific?  (i.e. are you looking for merging,
> > syncronization, or copies?  In other words what do you need that CVS +
> > rsync are unacceptable for?)
> 
> I'm looking for the ability to make changes to my local tree while
> away from the internet.

Doable, BTW it's the normal way of working in arch.

> I want to be able to make a branch for some new VM stuff while I'm
> sitting on an airplane, without needing to "register" the branch
> with the SCM daemon on Linus's personal workstation.

That's what you are expected to do, you work in your code derived from a 
concret point in the, let's call, reference repository.
You can always see the differences, move them from one branch to the 
other, make the mavailable to others to "get"... No need to register 
anything, only to get a remote public archive you need to specify the 
location and version that you want to download.

> Another thing to consider here is that you'll have dozens, if not
> hundreds, of people creating branches to their tree simultaneously.
> How would you ever convince rsync to merge those ?

You can't. But you can pull from the branches you need the patchsets you 
choose to. And make your branches public and available for others. It's 
very easy if you understand what's your development branch and your 
private branch. You move patches back and forth automatically. Even 
patches coming from the original trunk.

Pau

