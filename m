Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316938AbSEWTPa>; Thu, 23 May 2002 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316990AbSEWTPa>; Thu, 23 May 2002 15:15:30 -0400
Received: from sepp-host209.dsl.visi.com ([209.98.241.209]:39326 "EHLO
	crash.reric.net") by vger.kernel.org with ESMTP id <S316938AbSEWTP2>;
	Thu, 23 May 2002 15:15:28 -0400
Date: Thu, 23 May 2002 14:15:28 -0500
From: Eric Seppanen <eds@reric.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: via timer/clock problem workaround
Message-ID: <20020523141528.A28780@reric.net>
Mail-Followup-To: Eric Seppanen <eds@reric.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020522221859.A24041@reric.net> <3CECB24E.D41B1527@mvista.com> <20020523103340.A27767@reric.net> <3CED076C.20C24B23@mvista.com> <20020523113943.A28069@reric.net> <3CED1AF4.7170970@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that most of this thread occurred off-list and this is the tail end.

It looks as though the timer tick interrupt is going away.  If true, 
that's well outside the scope of what can be detected/repaired from inside 
do_gettimeofday().  So the workarounds posted on this list that I've seen 
look like the wrong approach.  That includes the fix that's in 2.4.18.


On Thu, May 23, 2002 at 09:38:12AM -0700, george anzinger wrote:
> Eric Seppanen wrote:
> > george anzinger wrote:
> > > The unfortunate thing about the fix is that execution of the
> > > detection code requires some one to request the time of
> > > day.  This, of course, could be delayed by an arbitrary
> > > time, depending on system activity.
> > 
> > Good point.  Looking at it from that perspective, it may be a waste of
> > time to put fixes in do_gettimeofday().  A dead timer is pretty serious,
> > and I can't think of a simple way to detect it.

On this note, if anybody has any hints on why the timer may be dying, how 
to debug it, or better places to detect/fix it, I'd be grateful.
