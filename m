Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263994AbRFFSby>; Wed, 6 Jun 2001 14:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbRFFSbo>; Wed, 6 Jun 2001 14:31:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4140 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S263994AbRFFSb0>; Wed, 6 Jun 2001 14:31:26 -0400
To: Derek Glidden <dglidden@illusionary.com>
Cc: John Alvord <jalvo@mbay.net>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
	<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jun 2001 12:27:42 -0600
In-Reply-To: <3B1E5316.F4B10172@illusionary.com>
Message-ID: <m1wv6p5uqp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Glidden <dglidden@illusionary.com> writes:

> John Alvord wrote:
> > 
> > On Wed, 06 Jun 2001 11:31:28 -0400, Derek Glidden
> > <dglidden@illusionary.com> wrote:
> > 
> > >
> > >I'm beginning to be amazed at the Linux VM hackers' attitudes regarding
> > >this problem.  I expect this sort of behaviour from academics - ignoring
> > >real actual problems being reported by real actual people really and
> > >actually experiencing and reporting them because "technically" or
> > >"theoretically" they "shouldn't be an issue" or because "the "literature
> > >[documentation] says otherwise - but not from this group.
> > 
> > There have been multiple comments that a fix for the problem is
> > forthcoming. Is there some reason you have to keep talking about it?
> 
> Because there have been many more comments that "The rule for 2.4 is
> 'swap == 2*RAM' and that's the way it is" and "disk space is cheap -
> just add more" than there have been "this is going to be fixed" which is
> extremely discouraging and doesn't instill me with all sorts of
> confidence that this problem is being taken seriously.

The hard rule will always be that to cover all pathological cases swap
must be greater than RAM.  Because in the worse case all RAM will be
in thes swap cache.  That this is more than just the worse case in 2.4
is problematic.  I.e. In the worst case: 
Virtual Memory = RAM + (swap - RAM).

You can't improve the worst case.  We can improve the worst case that
many people are facing.

> Or are you saying that if someone is unhappy with a particular
> situation, they should just keep their mouth shut and accept it?

It's worth complaining about.  It is also worth digging into and find
out what the real problem is.  I have a hunch that this hole
conversation on swap sizes being irritating is hiding the real
problem.  

Eric
