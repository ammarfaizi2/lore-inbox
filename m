Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbTDIIkz (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 04:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTDIIky (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 04:40:54 -0400
Received: from unthought.net ([212.97.129.24]:18115 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id S262926AbTDIIkx (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 04:40:53 -0400
Date: Wed, 9 Apr 2003 10:52:31 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-(bk) == horrible response times for non X11 applications
Message-ID: <20030409085231.GD10141@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0304061757240.2268-100000@montezuma.mastecende.com> <20030406182435.5a243297.akpm@digeo.com> <20030409064215.GC10141@unthought.net> <3E93D345.5090209@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E93D345.5090209@aitel.hist.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 10:01:09AM +0200, Helge Hafting wrote:
> Jakob Oestergaard wrote:
> >On Sun, Apr 06, 2003 at 06:24:35PM -0700, Andrew Morton wrote:
> [...]
> >>the problem with setiathome is that it displays something every now and
> >>then - so it gets a backboost from X, and hovers at a relatively high
> >>priority.
> >
> >
> >Why are niced processes boosted?   Does that make sense?
> >
> >If only non-niced processes were boosted, wouldn't that pretty much fix
> >the problem?
> >
> You'd have exactly the same problem for any non-niced cpu hog
> that displays something now and then. A non-niced cpu hog is supposed
> to be ok because the interactive processes are boosted above them.

A non-niced CPU hog that has interactivity, like eh, Descent or
Half-Life (under Wine) - well, I want those to get one heck of a lot
more boost than my seti...  or my emacs...

glxgears - if I run it (I don't know why I would, but let's say I wanted
to) - I don't want it to drop frames to favour my emacs or kword or
whatever (in the case of glxgears maybe I would - but I wouldn't run it
in the first place - let's just assume that glxgears is really some
important real-time visualization application).  If emacs behaves "less
interactively" than glxgears, then this is because glxgears is doing
something intensive, eg. it really gets hurt if it is not heavily
boosted.   Yes, you would be insane to run glxgears and some other
interactive application simultaneously, and expect that both can get 90%
of the resources - but this is the problem of limited resources and no
amount of cleverness is going to solve that.

> 
> Gui is becoming popular, so many compute tasks get some sort of
> display, even if it only is a progress bar.

And if they update the progress bar 100 times per second, then either it
is crucially important that this is not delayed, or the app needs
fixing.

You can break Linux in a million ways from user space by writing poor
user space code.

It wouldn't update 100 times per second unless it was important would
it?   And if it is important, then it's a lot better to make sure it
happens, than to ensure that the bash in the xterm next door gets it's
timeslices exactly when it wants them.   After all, you can type in a
laggy terminal (and if you type enough, it will get similar
interactiveness boost and we're back to the problem of limited
resources).

Look, I'm not trying to defend the boosting mechanism at all costs - I'm
just trying to argue that it's not fundamentally insane.   :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
