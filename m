Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVCCASv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVCCASv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVCCAQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:16:17 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:11698 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261392AbVCCALv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:11:51 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 3 Mar 2005 11:11:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.22078.129692.140147@cse.unsw.edu.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: message from Linus Torvalds on Wednesday March 2
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If I understand you correctly, what you are effectively saying is that
people don't test the -rc releases enough, so you are going to start
giving these releases a more formal name: 2.6.ODD.
That will encourage more people to test them, so that when you do a
real release (now called 2.6.EVEN instead of 2.6.X), it will be more
stable.

I don't buy this.  You won't fool anyone.  People will just start
using the .EVEN releases and you won't get any more testing than you
currently do.

A different approach would be to not release a 'stable' kernel at all,
but rather release 'fixup' patches.
i.e. you release 2.6.X as a 'testing' kernel and then start work on
2.6.X+1.
When a patch comes along that fixes a *real*problem* in 2.6.X, you add
that to a list of addenda for 2.6.X.  People who run 2.6.X can monitor
that list, applying patches that might be relevant to them.
You keep the addenda for 2.6.X going until 2.6.X+2 is released.

This way there is no clear distinction between "stable" and "testing"
kernels.  There is, instead, gradual transition.  People who want to
be cautious can decide to use
   A testing kernel that has been out for at least 2 weeks - plus addenda
as their definition of 'stable'.  Others might prefer
   A testing kernel that has been out for at least 6 weeks - plus relevant addenda
as their definition.

People who don't want to think, can pay a distributor to choose a
suitable definition of 'stable'.

This way, you are giving your army of beta-testers clear information
on their level of risk, and allowing them to choose precisely  what
level they want.  Giving people information and choice is always good
when you want them to help you.


That is the 'testing' side of the equation.  The other side is the
'developing' side.

I have been (naively?) assuming that Andrew Morton is the 2.6 kernel
maintainer, because that is what was announced, and I haven't seen any
announcement to alter that.  
So I have been sending all my patches to Andrew to go in the -mm tree,
with the understanding that he would forward them on to Linus as
appropriate, and this has been working quite well.
I feel free to send any patch to Andrew at any time, but try to make
it clear which ones should be considered "work-in-progress", which
should be considered 'important-bug-fix' and which sit in between.

I had (even more naively?) been assuming that this is what other
developers were doing.  i.e. that this was the approved approach.

But more recently I have discovered that quite a few key developers
develop against Linus' kernel and submit patches directly to him,
apparently bypassing Andrew.  This leads to them holding back patches
when a release is approaching, rather than sending them straight to
Andrew for -mm and wider testing.  This doesn't sound like a good
thing.


Now, I know our movement is all about freedom (and openness), and you
don't want to force developers into any behaviour patterns that aren't
essential, but I think it would be nice if there was some uniform
perspective on how patches should flow so that we all understood what
each other were doing.

My own preference would be:
  - all patches go to Andrew and appear in -mm promptly
  - Linus only gets patches from -mm
     - most patches are only passed to Linus after they have
       been in an -mm release for at least ....   1 week (?)
     - some patches go straight to Linus even before a -mm
       release if maintainer + Andrew + Linus review and agree
     - some patches stay in -mm for extended periods getting refined
       before making their way to Linus.
     - some patches get ditched from -mm and never make it to Linus.

Is this too restrictive?
Is it too much work for Andrew?
Is it too little work for Linus :-?


Whatever the final answer, the key is to give all your volunteer
supporters (both testers and developers) good information and good
choices (and don't try to deceive them).

NeilBrown
