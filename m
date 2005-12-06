Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVLFVXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVLFVXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVLFVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:23:47 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55721 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030256AbVLFVXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:23:46 -0500
Message-Id: <200512061808.jB6I6D9P017470@laptop11.inf.utfsm.cl>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Florian Weimer <fw@deneb.enyo.de>, Rob Landley <rob@landley.net>,
       Lee Revell <rlrevell@joe-job.com>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Steven Rostedt <rostedt@goodmis.org> 
   of "Mon, 05 Dec 2005 20:26:12 CDT." <Pine.LNX.4.58.0512052018290.29880@gandalf.stny.rr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Tue, 06 Dec 2005 15:06:13 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 06 Dec 2005 18:21:46 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 6 Dec 2005, Florian Weimer wrote:
> > > Actually, they are already maintaining 2.6.x.y, (x => 11, 12, ...)

> > I think the 2.6.x.y series is no longer maintained once 2.6.x+1 has
> > been released for some time (surely after 2.6.x+2).

> The same can still go for this, but instead of stopping at 2.6.x+2 we could
> stop at 2.6.x+6 (or +5), and just not care about 2.6.x+[1-4].  But that
> would be strong enough for those that would like the stable branch to
> maintain it themselves.  Currently it'l hard to pick a 2.6.x that you want
> to stay with since the 2.6.x.y is stopped right after 2.6.x+1 is out.  But
> if not all 2.6.x has a .y, then that would focus more distrobutions or
> whatever to pick the same one to support.

OK, let's step back and...

- People work on Linux (or whatever other stuff) because it is /fun/ and
  /exciting/. 
- People who don't actively work on a piece of code won't know it
  intimately, so they'll make mistakes when looking for bugs/fixes
- There is little excitement in just fixing bugs in frozen code, developers
  will just migrate elsewhere if there is no fun here

- "Experimental versions" are only run by masochists and bored people who
  need fireworks now and then to know they are still alive. End users don't
  even consider them, when the software is stable enough for the crazier
  ones to unleash on the world as "stable" is when the bugs surface
  (Remember the disaster of the early 2.4s? Ever heard of "Let's wait for
  X.<even>.10 or so, by then it will be stable enough for everyday use"?).
- End users /don't/ test "prereleases", they deem them too risky... so the
  "releases" usually ship with lethal bugs for some people. Decreeing that
  each 5th (or whatever) release will be "golden" will just get people to
  skip all the others, resulting in /much more/ serious bugs in the end

- Backporting new features into a different setting is almost as hard, or
  perhaps much harder, than developing said features in the first place.
  Backpòrting bug fixes is a thankless job.
- Distributions /do/ have the infrastructure in place to collect bug
  reports and correlate them with hardware and software configurations,
  moreover they work with /one/ (or at most a few) kernel configuration,
  not with the almost random assortment of kernel configurations you'll
  find with self-built ones. They also have the (paid) manpower to extract
  conclusions from the above data. 
- If all distributions work from approximately the same base, much
  duplicate/wasted work (yes, backporting is mostly wasted effort IMHO) is
  saved.

- Tools for kernel work are /much/ better now, it is reasonable to maintain
  patches out-of-vanilla and keep the base syncronized with the standard
  kernel source. Lots of people do so now, when it previously was a
  full-time job for the incredibly productive gnome community known
  collectively as "Alan Cox" to do so. There is thus much less need for
  "odd" series in which to integrate new stuff.

All of the above led to the current kernel development model. Users might
not be too happy about it, but the key developers are. And the important
people, the ones you /have/ to keep happy in the OSS development model,
aren't the users. Besides, everybody moaning about the new development
model want something impossible: Fast development, timely integration of
support for newest hardware, while bug free all the time. Won't ever
happen.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
