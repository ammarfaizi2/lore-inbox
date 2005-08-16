Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVHPRFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVHPRFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVHPRFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:05:06 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:36093 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030246AbVHPRFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:05:05 -0400
Subject: Re: [PATCH] Convert sigaction to act like other unices
From: Steven Rostedt <rostedt@goodmis.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       rmk@arm.linux.org.uk, gerg@uclinux.org, jdike@karaya.com,
       sammy@sammy.net, lethal@linux-sh.org, wli@holomorphy.com,
       davem@davemloft.net, matthew@wil.cx, geert@linux-m68k.org,
       paulus@samba.org, davej@codemonkey.org.uk, tony.luck@intel.com,
       dev-etrax@axis.com, rpurdie@rpsys.net, spyro@f2s.com,
       Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <9a874849050814052035ad2838@mail.gmail.com>
References: <1123900802.5296.88.camel@localhost.localdomain>
	 <20050813123956.GN22901@wotan.suse.de>
	 <1123941614.5296.112.camel@localhost.localdomain>
	 <20050813212924.GQ22901@wotan.suse.de>
	 <9a874849050814052035ad2838@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 16 Aug 2005 13:04:23 -0400
Message-Id: <1124211863.5764.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-14 at 14:20 +0200, Jesper Juhl wrote:
> On 8/13/05, Andi Kleen <ak@suse.de> wrote:
> > On Sat, Aug 13, 2005 at 10:00:14AM -0400, Steven Rostedt wrote:
> > > On Sat, 2005-08-13 at 14:39 +0200, Andi Kleen wrote:
> > > > On Fri, Aug 12, 2005 at 10:40:02PM -0400, Steven Rostedt wroqte:
> > > > > Here's a patch that converts all architectures to behave like other unix
> > > > > boxes signal handling.  It's funny that I didn't need to change the m68k
> > > > > architecture, since it was the only one that already behaves this way!
> > > > > (the m68knommu does not!)
> > > >
> [snip]
> > 
> > My general feeling about the change is that it risks breaking programs
> > and doesn't seem to have any compelling advantages,
> > so unless there is a bug demonstrated I wouldn't apply it.
> > 
> > -Andi
> > 
> 
> As I see it, the advantages are that we would  a) match the
> documentation (man pages & posix/SUS) which makes things easier for
> application writers who won't have to scratch their beards wondering
> why Linux doesn't behave like the docs say. And  b) Linux behaviour
> would match what most (all?) other Unices do, so there'll be less
> hassle/bugs when porting apps from other systems to Linux.   To me,
> those look like significant bennefits.
> As for the "it may break programs" bit, that of course is a concern,
> but one way around that would be to stick it in -mm and let it cook
> for a few kernel releases. Say we stick it in -mm with a plan to merge
> it into 2.6.16-rc1, that should give it quite a bit of time to
> determine if it breaks apps (and if it does, to fix those apps).

Has there been a verdict on this.  Are we going to 

a) leave Linux "as-is" and be different than the man pages and POSIX as
well as pretty much every other Unix out there.  But..., we keep from
breaking any linux-only applications out there that actually depend on
this behaviour (if there were any).

b) add the patch (in -mm or early 14 or later), see if any applications
break, but we will finally match the man pages and etc.

Just curious.

-- Steve


