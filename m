Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbULDQYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbULDQYF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 11:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbULDQYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 11:24:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35819 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262551AbULDQX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 11:23:59 -0500
To: Andrew Morton <akpm@osdl.org>
cc: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>, linux-kernel@vger.kernel.org,
       riel@redhat.com, mason@suse.com, ckrm-tech@lists.sourceforge.net,
       llp@CS.Princeton.EDU, acb@CS.Princeton.EDU, mlhuang@CS.Princeton.EDU,
       smuir@CS.Princeton.EDU
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management 
In-reply-to: Your message of Fri, 03 Dec 2004 16:40:34 PST.
             <20041203164034.2191957c.akpm@osdl.org> 
Date: Sat, 04 Dec 2004 00:33:29 -0800
Message-Id: <E1CaVM9-0005yy-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Dec 2004 16:40:34 PST, Andrew Morton wrote:
> "Marc E. Fiuczynski" <mef@CS.Princeton.EDU> wrote:
> >
> > I integrated CKRM with the kernel used by PlanetLab (www.planet-lab.org),
> > and I believe we (PlanetLab) are the first to use CKRM in a production
> > setting.
> > ...
> > Hope this helps.
> 
> It does, thanks.
> 
> A concern which I have about the CKRM implementation is that the patches
> which have been sent out appear to be simply the "core" of CKRM, plus
> minimally-intrusive hooks.  I have the impression that this core will not
> be terribly useful to real-world users and that follow-on patches will be
> required to add more functionality and to wire up more instrumentation and
> control points.
> 
> I would not like to be in a situation where we merge the "core" patch, but
> the as-yet-unseen follow-on patches which make CKRM useful and complete end
> up creating a big unmaintainable mess.  We end up not wanting to go
> forwards and being unable to go backwards.
> 
> IOW: I think we need to see a reasonably-close-to-final implementation of
> CKRM before we can take it much further.

Understood.  We do have a more complete set of patches floating around,
although most are ported to an existing distro rather than set for
current mainline adoption.  But if we can get general consensus on
the patches (once I finish the current round of cleanup and testing),
we do have work in memory management, IO scheduling, and even CPU
scheduling (the latter being the most debatable for mainline acceptance
given the rate of scheduler replacements in recent past) that are
being used today.

We can dump the current, raw distro patches or the rest of the e16
patch set from ckrm-tech on you although I believe they will need
some significant review/modification to be mainline acceptable yet.
One big problem is that these changes are somewhat hard to maintain as
distinct from mainline and yet remain relatively current.  There are
several developers working in distinct areas and each area moves at
its own pace.  Hence, I'd like to get to a more stable -mm compatible
core, and build up from there.  As we see that the entire set approaches
stability/utility, we can push from the core up through the working set
of resource controllers.

If getting you a set of patches for general concept review as based
on a current distro would help, just say the word.  However, getting
those up to current mainline, integrated with each other and fully
tested (while holding their development stable long enough to do that)
is the requirement, well, that will take us a fair bit longer.

Part of the goal of this posting was to start to stabilize a core
and improve on it, rather than try to deliver an entire project as a
moderately large set of changes as a fait accompli.  And, we are more
than willing to continue to tweak and tune this to be generally useful
to a wider audience, even though we have a set that works well for
some groups needing better workload management.

So, Andrew, can you clarify how much we need to put in your hands, how
well tested it needs to be and how clean and current the entire set needs
to be before this is ready for -mm testing?

gerrit
