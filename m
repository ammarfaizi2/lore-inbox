Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310628AbSCHAnz>; Thu, 7 Mar 2002 19:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310629AbSCHAno>; Thu, 7 Mar 2002 19:43:44 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:9226 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310628AbSCHAne>;
	Thu, 7 Mar 2002 19:43:34 -0500
Date: Thu, 7 Mar 2002 21:43:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Jonathan A. George" <JGeorge@greshamstorage.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <3C8805EC.3000602@greshamstorage.com>
Message-ID: <Pine.LNX.4.44L.0203072137530.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Jonathan A. George wrote:
> Rik van Riel wrote:

> >1) working merges
>
> Can you be more specific?

You do a merge of a particular piece of code once.
After that the SCM remembers that this merge was done
already and doesn't ask me to do it again when I move
my code base to the next official kernel version.

> >2) atomic checkins of entire patches, fast tags
>
> I was thinking about something like automatically tagged globally
> descrete patch sets.  It would then be fairly simple to create a tool
> that simply scanned, merged, and checked in that patch as a set.  Is
> something like this what you have in mind?

Yes, but doing this with the CVS storage as back-end
would just be too slow.  Also, the CVS model wouldn't
be able to easily clean out the tree afterwards if a
checkin is interrupted halfway through.

> >3) graphical 2-way merging tool like bitkeeper has
> >   (this might not seem essential to people who have
> >   never used it, but it has saved me many many hours)
>
> Would having something like VIM or Emacs display a patch diff with
> providing keystroke level merge and unmerge get toward helpful for
> something like this, or is the need too complex to address that way?

That would work, but you really need to try bitkeeper's
graphical 2-way merge tool (or even a screenshot) to see
how powerful such a simple thing can (and should) be.

> >4) distributed repositories
>
> Can you be more specific?  (i.e. are you looking for merging,
> syncronization, or copies?  In other words what do you need that CVS +
> rsync are unacceptable for?)

I'm looking for the ability to make changes to my local tree while
away from the internet.

I want to be able to make a branch for some new VM stuff while I'm
sitting on an airplane, without needing to "register" the branch
with the SCM daemon on Linus's personal workstation.

Another thing to consider here is that you'll have dozens, if not
hundreds, of people creating branches to their tree simultaneously.
How would you ever convince rsync to merge those ?

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

