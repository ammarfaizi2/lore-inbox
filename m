Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290944AbSAaFrW>; Thu, 31 Jan 2002 00:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290949AbSAaFrL>; Thu, 31 Jan 2002 00:47:11 -0500
Received: from zok.sgi.com ([204.94.215.101]:61316 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S290944AbSAaFqz>;
	Thu, 31 Jan 2002 00:46:55 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rob Landley <landley@trommello.org>
Cc: Larry McVoy <lm@bitmover.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Your message of "Thu, 31 Jan 2002 00:16:13 CDT."
             <20020131051505.MGLL25889.femail29.sdc1.sfba.home.com@there> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 16:46:43 +1100
Message-ID: <9396.1012456003@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 00:16:13 -0500, 
Rob Landley <landley@trommello.org> wrote:
>Linus himself seems to have denied this assumption.  Just because a 
>downstream developer took two months to come up with a subsystem and did 
>eight hundred seperate checkins of which only maybe 20% of the code made it 
>into the final version, does NOT mean that Linus cares.  That level of detail 
>IS more information, but there's a limit to how much information you want 
>before it becomes cruft in Linus's tree.

I agree with Rob on this.  My PRCS tree for 2.4 has 950+ patch sets in
it but there is no way I would inflict that level of detail on the rest
of the world.  I follow the model of check in often, even if it does
not work, so I can backtrack and take another branch if the code hits a
dead end.

Lots of small checkins and branching means a lot of history which is
useful to me but to nobody else.  When I release a patch I pick a start
point (base 2.4.17, patch set 17.1) and an end point (kdb v2.1 2.4.17
common-2, patchset 17.37) and prcs diff -r 17.1 -r 17.37.  That single
patch against 2.4.17 is all the outside world needs to see, the only
history is "kdb v2.1 2.4.17 common-2".  It does not matter if I
backtracked and discarded some twigs to get to that final end point,
the rest of the world only cares about the end point.

For that model to work (which is effectively what diff/patch does now),
developers need a repository system that can consolidate lots of little
changes into a single patchset.  Distribute and replicate the single
patchset, only the original developer retains the individual steps that
made up the combined patchset.

