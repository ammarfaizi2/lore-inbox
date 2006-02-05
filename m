Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWBEJKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWBEJKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 04:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWBEJKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 04:10:04 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:6618 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751582AbWBEJKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 04:10:02 -0500
Date: Sun, 5 Feb 2006 10:09:59 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Marc Koschewski <marc@osknowledge.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>, dtor_core@ameritech.net,
       rlrevell@joe-job.com, 76306.1226@compuserve.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Wanted: hotfixes for -mm kernels
Message-ID: <20060205090959.GC5663@stiffy.osknowledge.org>
References: <200602021502_MC3-1-B772-547@compuserve.com> <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com> <20060203100703.GA5691@stiffy.osknowledge.org> <20060204083752.a5c5b058.mbligh@mbligh.org> <20060204185738.GA5689@stiffy.osknowledge.org> <20060204204139.GA4528@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204204139.GA4528@stusta.de>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g5b7b644c
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk <bunk@stusta.de> [2006-02-04 21:41:39 +0100]:

> On Sat, Feb 04, 2006 at 07:57:39PM +0100, Marc Koschewski wrote:
> > * Martin J. Bligh <mbligh@mbligh.org> [2006-02-04 08:37:52 -0800]:
> > > 
> > > > > > I doubt it - mm is an experimental kernel, hotfixes only make sense for
> > > > > > production stuff.  It moves too fast.
> > > > > >
> > > > > > A better question is what does -mm give you that mainline does not, that
> > > > > > causes you to want to "stabilize" a specific -mm version?
> > > > > >
> > > > > 
> > > > > Some people just run -mm so the hotfixes/* would help them to get
> > > > > their boxes running until the next -mm without having to hunt through
> > > > > LKML for bugs already reported/fixed. This will allow better testing
> > > > > coverage because most obvious bugs are caught almost immediately and
> > > > > then people can continue using -mm to find more stuff.
> > > > 
> > > > ... that's just why I so often wish to have a -git tree, Andrew. ;)
> > > 
> > > Why do people always thing a source code control system is magically going
> > > to fix all bugs and wipe their ass for them?
> > > 
> > > You still have to work out which patches are relevant and merge them. If 
> > > he's just merging a new set of changes constantly, it won't help you a damn. 
> > 
> > We talked about hotfixes for -mm. So why not check these into the -mm-git tree
> > then? This would make sense and would conform fully to my understanding of what
> > the -mm-git tree should be. I don't want to select 23 patches from LKML to make
> > the tree compile or work. I want to checkout. Why make it easy when you may get
> > it difficult.
> >...
> > What sense does an -mm tree make when there are people that cannot test it because of
> > known bugs that lead to the -mm tree not being bootable or - even worse - destroying
> > the system?
> 
> That's exactly what Andrew does now implement through the hot-fixes
> directory [1].
> 
> Git doesn't help for the problem that it's currently empty - it's more 
> important that people tell Andrew that this or that patch should be made 
> available there.
> 
> > git is you friend. Not only for Linus' tree, but as well for Andrew's tree.
> > It would just make debugging and testing -mm more convenient and less time
> > consuming for the testers. Instead of 1000 people seeking patches Andrew would
> > just check in and we all could pull it.
> >...
> 
> git is the SCM Linus developed to fit his workflow.
> 
> Andrew has a completely different workflow, and he has developed the 
> tools he needs for his workflow.
> 
> As long as they are able to interact (which seems to work without 
> problems), there's nothing forcing them to use the same tools.

I really didn't mean to 'force' anyone to use a specific tools or even type of
tool such as an 'SCM' generally. I didn't even suggest it. I just wish to have one
as I'm used to it and IMHO it makes thing easier. Applying is easier (where
'patch -p1 < ../file.patch is not really difficult either), getting back to a
specific date is easier, commenting is easier (check-in descriptions).

Moreover, just _one_ more thing which is most important at least to me:
If one can do a checkout on a daily basis with let's say 3 new patches checked
in, one can test these. The other day there are maybe another 2 new patches
applied which are to be tested. This would just speed up the testing cycle
whereas a 3 MB patch with tons of fixes and testing is just like a kick-down
with the hand-brake pulled. Sometimes I#M really overwhelmed by how many patches
came in with the recent -mm. ACPI, ALSA, VM, various FS stuff, ... It's quite
impossible to me to really test the patches in an effective manner due to having
my 2 eyes focussed on too many things at one. I do test ALSA with various types
of in/out operation while my reiserfs partition is on the way to hell. To me
that doesn't sound like effective testing.

This is just about testing and debugging time effectiveness and not about some
religious thing a la SCM vs. patches.

Marc
