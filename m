Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTJJPvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbTJJPvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:51:50 -0400
Received: from mark.mielke.cc ([216.209.85.42]:62983 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S262971AbTJJPvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:51:48 -0400
Date: Fri, 10 Oct 2003 11:50:07 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: William Lee Irwin III <wli@holomorphy.com>, G?bor L?n?rt <lgb@lgb.hu>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010155007.GA13825@mark.mielke.cc>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu> <20031010144723.GC727@holomorphy.com> <20031010144837.GB12134@mark.mielke.cc> <20031010150122.GD727@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010150122.GD727@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 08:01:22AM -0700, William Lee Irwin III wrote:
> On Fri, Oct 10, 2003 at 10:48:37AM -0400, Mark Mielke wrote:
> > Perhaps I've naive here, but - with hot-pluggable CPU machines, do you not
> > de-activate the CPU through software first, before pulling the CPU out, at
> > which point it is not in use?
> Well, you deleted my reply, but never mind that.

I wasn't responding to you. You're article just happened to be the one
that I pushed 'g' to... :-)

> This obviously can't work unless the kernel gets some kind of warning.
> Userspace and kernel register state, once lost that way, can't be
> recovered, and if tasks are automatically suspended (e.g. cpu dumps to
> somewhere and a miracle occurs), you'll deadlock if the kernel was in
> a non-preemptible critical section at the time.

Again, I'm perhaps naive here - I've never been able to afford such a
machine with hot-pluggable CPU's, however, I have heard from people who
have used them at work, that you use software (i.e. system calls to the
kernel) to instruct the kernel to no longer schedule tasks for the CPU.
Once the CPU is no longer scheduled for use, you can feel free to unplug
the CPU from the motherboard. Note that I didn't say that the software
approach could *guarantee* immediate success. You wouldn't unplug the
CPU until your had successfully deregistered the CPU from having anything
scheduled for it.

Is this not the way things (should) work?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

