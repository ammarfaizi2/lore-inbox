Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbUCSLWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 06:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUCSLWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 06:22:54 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57056 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262697AbUCSLWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 06:22:46 -0500
Message-ID: <405AD755.7060705@us.ibm.com>
Date: Fri, 19 Mar 2004 03:19:49 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH Documentation] "SuccessfulProjects.txt"
References: <4054E77E.3090206@us.ibm.com> <20040317205159.6bad1ca2.akpm@osdl.org>
In-Reply-To: <20040317205159.6bad1ca2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote in an earlier thread:

> Apart from that, heck, why not?  Please run up a diff.

Here is the new version of the file, incorporating feedback.
Thanks!

Nivedita

---
File:	SuccessfulProjects.txt
Date:	3/14/04
Title:	How To Run A Successful Linux Project


" How to improve your chances of launching and sustaining
   a successful Linux project, get your code or technology
   accepted into the Linux kernel and adopted by the
   community, earn fame (or employment, or at least continued
   employment, or well, at least not completely waste your
   spare time), all without losing your hair and your sanity. "


Goal
====
- Increase the success rate of Linux development projects
- Reduce the burden on the kernel maintainers and the community
- Decrease the angst and conflict experienced by project developers
- Make software development faster and more efficient
- Make users, consumers of those software projects happier
- Use the kernel's review processes and testing base to
   increase the quality of your software


Introduction
============
Most of the information here is very basic, obvious and covered
frequently in a multitude of places, at length.  However, it is also
difficult to locate in one convenient place, and ignored frequently
enough to warrant the presence of this file in the Documentation
subdirectory of the kernel source.


Tips
====

1]. Become familiar with Linux kernel development!
--------------------------------------------------
1.1 Read Documentation/CodingStyle!
     If the code doesn't look like kernel code, you've just made things
     much harder for yourself.

     Read Documentation/SubmittingPatches.
     Read Documentation/SubmittingDrivers, if applicable.


1.2 Who are the maintainers affected?
     Learn who the maintainers are for the subsystems affected by your
     project, and for the various releases, especially for the releases
     you intend to provide code to.
	2.4 -> Marcelo Tosatti
	2.6 -> Andrew Morton
	development -> Linus
	./Maintainers file -> current list of maintainers


1.3 Which Linux source tree?
     Linux kernel versions are of the form:

	major.minor.merry_go_round

     The major number is only incremented when a new epoch is warranted,
     and they come very few and far between. Only one so far since 1.0.

     The minor number is the key here.  Even numbered minor versions are
     "stable" kernel releases, and odd numbered ones are "development"
     releases.  Typically, new development (especially major new features,
     subsystem overhauls, API breakages) is done in the development tree.

     The latest (3/18/04) stable kernel version is 2.6, and the next
     development version, 2.7, will be forked off 2.6 once it is deemed
     ready.  Earlier stable versions - 2.2 and 2.4 - continue to be updated.

     The "merry_go_round" number is incremented rapidly enough to render
     most followers dizzy, a good thing, since it allows for the rapid
     delivery of changes and bug fixes.

     Read the Linux FAQ
         http://en.tldp.org/FAQ/Linux-FAQ/index.html
         This is, admittedly, already slightly out of date.

     Also discover the various other source trees (-mm, -mjb, -osdl, ...)
     Read the Linux Kernel Newbies FAQ
         http://kernelnewbies.org/faq/

     Get advice from the community and your users on which kernel tree
     would be best to target for inclusion. Understand that kernel
     updates occur in parallel in various source trees, and you might
     need to provide support in multiple versions.


1.4 Which are the mailing lists you need?
     Learn which mailing lists cover development in the areas affected by
     your project.  It is always a good idea to involve the kernel community
     or sub-community as the case may be - which involves posting to the
     right mailing lists.  Solicit advice on which lists are appropriate.

     You can start by checking the MARC archives to find the right lists.
	http://marc.theaimsgroup.com/	


1.5 Learn Linux Kernel Mailing List (lkml) etiquette
     Read the Linux Kernel Mailing List FAQ
	http://www.tux.org/lkml/


2. Interact early, interact often
---------------------------------
2.1 Don't work in isolation
     It is not a good idea to spend several person-years working behind
     closed doors, or even within your own project environment.  Keep not
     only the project community involved, but also the maintainers concerned
     and the Linux kernel community, if appropriate, in the loop.

     In Andrew Morton's words:

	"But beware of being *too* disconnected from the
         lists@vger.kernel.org.  We don't want to get in
	the situation where you pop up with a couple of
	person-years' worth of work and other kernel developers
         have major issues with it.  Please find a balance - some
         way of regularly checkpointing."

	http://marc.theaimsgroup.com/?l=linux-kernel&m=107922697510704&w=2

	Even if you are in design/planning stages, it is worth a note to
	the community to say, "Hey, this is how we're going to go about
         it..."

	i.e. remain visible, and ensure that people know your project is
         alive and in good hands.

	
2.2 Avoid large code dumps
     Don't throw a massive, complex tarball of your final implementation
     at the kernel community and maintainers once you are done.  Break
     down your project into smaller pieces.  Submit easily digestible
     chunks at regular intervals.  If you're making some ghastly, widespread
     mistake, catch it early.  Get agreement from the community and the
     maintainers on your approach. Again, to quote Andrew from the link
     above:

	"That way everyone else can see the code evolving,
         and can help, and can understand.  And other people
         will fix your bugs for you, and update your code as
         kernel-wide changes are implemented.  And we all
	avoid nasty surprises and extensive rework."


2.3 Be responsive to input from the community
     Good open source project maintainers earn the trust of the larger
     community and kernel maintainers by demonstrating they are willing
     to work in tandem with the community.
	
     See Greg Kroah-Hartman's slides on dealing with the community.
     http://www.kroah.com/linux/talks/cgl_talk_2002_10_16/


3]. Where to start?
-------------------
3.1 Join an existing community
     If there already exists a project developing functionality foo that
     you are interested in, work with it.  Join the people who have
     already spent time and effort solving the problem.  Sometimes, this is
     easier said than done because projects might be open source in name,
     but far from it in reality.  A good open source project, however,
     will have a public web site, a public mailing list that invites
     discussion and source code available to play with.

     If you cannot convince this community of the value of your ideas,
     the going will only get tougher when taken to the Linux kernel
     community. Not always true, but true often enough.

     This is particularly true when APIs have to be designed and there
     are no mandated standards controlling what you should be implementing.
     Having multiple conflicting implementations brought to the Linux
     kernel mailing list puts the burden of sorting out basic issues
     related to your project on kernel maintainers, hardly a group with
     spare time on their hands.


3.2 Create an open source community if there is none
     If there is no existing project that meets your needs, create one.

     Maintain the public infrastructure that should ideally accompany a large
     project - a public website, mailing list, source code development
     infrastructure (SourceForge is a good place to start).  Described well
     in the link below.

     Read the Software Release Practices Howto.
	http://en.tldp.org/HOWTO/Software-Release-Practice-HOWTO/index.html



Do not take any of the above as gospel, confirm with the maintainers in
question. There are exceptions to every rule!.



