Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVBBTJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVBBTJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVBBTEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:04:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17310 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262568AbVBBS7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:59:35 -0500
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <873bwfo8br.fsf@sulphur.joq.us>
References: <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu>
	 <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us>
	 <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us>
	 <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us>
	 <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us>
	 <20050127113530.GA30422@elte.hu>  <873bwfo8br.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 13:59:30 -0500
Message-Id: <1107370770.3104.136.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 23:10 -0600, Jack O'Quin wrote:
> > So in the Linux core code we have zero tolerance on crap. We are
> > doing this for the long-term fun of it.
> 
> So, we should never do anything boring, even though people actually
> need it?  
> 
> The fact that a large group of frustrated Linux audio developers could
> find no better outlet than to develop this solution is a rather strong
> indictment of the kernel requirements-gathering process.
> 
> > and if nobody ends up writing the 'proper' solution then there probably
> > wasnt enough demand to begin with ... We'll rather live on with one less
> > feature for another year than with a crappy feature that is twice as
> > hard to get rid of!
> 
> Is nobody responsible for figuring out what users need?  I didn't
> realize kernel development had become so disconnected.
> 

Interesting point.  The kernel development process has been written
about at length, but you don't hear much about the requirements
gathering process.

It seems like aside from the internal forces of kernel developers
wanting to improve the system, the big distros, do a lot of the
requirements gathering.  Makes sense, as the distros are in a very good
position to know what users want, and can commit developer resources to
get it done.  For example there has been a big push from the distros to
make Linux competitive with MS on the desktop, and it shows in the
direction of Linux development.  These days you can throw in a cd of a
modern distro and the installer will get you to a working desktop easier
than Windows (well, almost, your sound might not work ;-).

Really, if the Linux audio community wants to get its requirements
heard, then all the AGNULA and Planet CCRMA users should start to demand
that Fedora and Debian be usable OOTB for low latency audio.  If you
want to run JACK in realtime mode on RH or Debian you have to be root
for crying out loud.  There's no reason Linux audio users should have to
patch the kernel or install a bunch of specialized packages any more
than people who want to use it as a web server.  File bug reports,
complain on your distro's user mailing lists, whatever.

I do appreciate the progress that has been made, and that the Linux
kernel developers really stepped up to address the latency issues.  But,
most of the push has come from outside the kernel development community,
from individual Linux audio users and developers.  If we had waited for
the big distros to demand that low latency audio work OOTB, we would be
exactly where we were in 2001 (or this time last year) still using 2.4
+ll+preempt and struggling to get that old kernel to work on our new
hardware.

IMHO the requirements gathering process usually works well.  When
someone with a redhat.com (for example) address posts a patch there's an
implicit assumption that it addresses the needs of their gadzillions of
users.  Still, RH hires professional kernel developers, people who
produce known good code will always have an easier time getting patches
merged.  If Linus & co. don't know you from Adam and you show up with a
patch that claims to solve a big problem, then I would expect them to be
a bit skeptical.  Especially if the problem is either low priority or
not well understood by the major distros.

Lee

