Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSGRIRL>; Thu, 18 Jul 2002 04:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSGRIRL>; Thu, 18 Jul 2002 04:17:11 -0400
Received: from ns.suse.de ([213.95.15.193]:4108 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317169AbSGRIRK>;
	Thu, 18 Jul 2002 04:17:10 -0400
Date: Thu, 18 Jul 2002 10:20:09 +0200
From: Dave Jones <davej@suse.de>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020718102009.F9489@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D361091.13618.16DC46FB@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D361091.13618.16DC46FB@localhost>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 12:49:21AM -0400, Guillaume Boissiere wrote:

 > o New VM with reverse mappings                    (Rik van Riel)

Likely.

 > o Add Linux Security Module (LSM)                 (LSM team)

Unsure, depends on the LSM folks.

 > o Rewrite of the console layer                    (James Simmons)

In progress of being merged from -dj -> mainline.

 > o New MTRR (Memory Type Range Register) driver    (Patrick Mochel)

in -dj, being pushed next week when I get home.

 > o Add support for CPU clock/voltage scaling       (Erik Mouw, Dave Jones, Russell King, Arjan van de Ven)

A few last-minute niggles to work out, and this should go into mainline soon.

 > o Strict address space accounting                 (Alan Cox)

Probably a trivial merge once the more important vm changes have happened.

 > o USB gadget support                              (Stuart Lynne, Greg Kroah-Hartman)

As per Greg's comment.

 > o Add hardware sensors drivers                    (lm_sensors team)

There are a few folks doing various i2c work outside the lm_sensors
scope, which could find its way into the tree if its ready in time.
The actual sensors stuff, unknown. There were issues with some laptops,
I don't know if they got resolved ?

 > o Serial driver restructure                       (Russell King)

Hopefully ready in time.

 > o Add User-Mode Linux (UML)                       (Jeff Dike)

Ready-to-merge.

 > o Direct pagecache <-> BIO disk I/O               (Andrew Morton)

Andrew ?

 > o More complete NetBEUI stack                     (Arnaldo Carvalho de Melo, from Procom donated code)

Depending on how busy Arnaldo gets I guess. Non-critical.

 > o Fix device naming issues                        (Patrick Mochel, Greg Kroah-Hartman)

Yep. For example, how /dev/disk/ or whatever ends up working is still unclear
to myself and a few other folks.

Other items you listed in the post-freeze section that really needs
doing before the freeze imo:

 > o LVM (Logical Volume Manager) v2.0               (LVM team)

LVM1 in 2.5 is badly borken, Sistina don't want to fix it, and whilst
there is some work getting it 'mostly functional' in my tree, ongoing
development of LVM1 is counterproductive when there is a superior
solution in the wings.  All depends on whether they can pull it off
before the freeze of course.

 > o Asynchronous IO (aio) support                   (Ben LaHaise)

Again, this is likely to happen sooner rather than after the freeze.
This will break large amounts of kernel code, and having non-compilable
kernels /after/ the freeze is undesired considering we are then in the
'get things stable' zone.
 
 > After feature freeze:

Quite a few of these you listed either should wait until 2.7 or
get in before the freeze.  Some of them require non-trivial changes
to critical areas which we really shouldn't be poking too much in
an alleged 'stabilisation series'.

Instead I would rename this section 'non critical features' or
'nice to have' features. If they don't make it in time, there's
always 2.7

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
