Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTDIJOw (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTDIJOv (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:14:51 -0400
Received: from unthought.net ([212.97.129.24]:36803 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id S262942AbTDIJOu (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:14:50 -0400
Date: Wed, 9 Apr 2003 11:26:28 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-(bk) == horrible response times for non X11 applications
Message-ID: <20030409092628.GF10141@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0304061757240.2268-100000@montezuma.mastecende.com> <20030406182435.5a243297.akpm@digeo.com> <20030409064215.GC10141@unthought.net> <3E93D345.5090209@aitel.hist.no> <20030409085231.GD10141@unthought.net> <3E93E36A.1050206@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E93E36A.1050206@aitel.hist.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 11:10:02AM +0200, Helge Hafting wrote:
...
> >Look, I'm not trying to defend the boosting mechanism at all costs - I'm
> >just trying to argue that it's not fundamentally insane.   :)
> 
> I agree that it isn't fundamentally insane, but using the 2.5.66
> mechanism might force you to
> concider some apps "broken" that were fine before.  This forces the
> question of how hard it should be to write a user program.

That is a good and valid point

> 
> 100 screen updates per second doesn't mean it is important if it only
> is twiddling of a baton or some progress bar.  People simply stick such
> things in an outer loop - and that worked out to a update or two
> per second in 1989.  Same code on todays machines results in hundreds
> of updates per second.  Are we going to fix apps as our pcs becomes faster?

nice my_old_compute_intensive_app

We agree that only CPU intensive apps will cause the problem right?

So if we keep the CPU boosting mechanism, but only boost non-niced
processes (makes good sense in my twisted mind at least), we provide the
interactiveness benefits for the general case, and provide an easy way
to run unmaintained (or "semi broken" or whatever we will call them)
applications.

We end up "forcing" the user to nice some (hopefully few) CPU intensive
applications that didn't need nicing before.   I can see that that will
be a problem.

But will it be a bigger problem than not having the interactiveness
boost at all?

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
