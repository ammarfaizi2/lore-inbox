Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWIYAtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWIYAtD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 20:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWIYAtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 20:49:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751708AbWIYAtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 20:49:01 -0400
Date: Sun, 24 Sep 2006 17:48:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sean <seanlkml@sympatico.ca>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Lennert Buytenhek <buytenh@wantstofly.org>,
       Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, davidsen@tmr.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
In-Reply-To: <BAYC1-PASMTP03A93CF0AD4CEACDC36DF0AE270@CEZ.ICE>
Message-ID: <Pine.LNX.4.64.0609241741210.3952@g5.osdl.org>
References: <45130533.2010209@tmr.com> <45130527.1000302@garzik.org>
 <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com>
 <20060922083542.GA4246@flint.arm.linux.org.uk> <20060922154816.GA15032@redhat.com>
 <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org> <20060924074837.GB13487@xi.wantstofly.org>
 <20060924092010.GC17639@flint.arm.linux.org.uk> <20060924142353.6c725128.seanlkml@sympatico.ca>
 <20060924230948.GG12795@flint.arm.linux.org.uk> <BAYC1-PASMTP03A93CF0AD4CEACDC36DF0AE270@CEZ.ICE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Sep 2006, Sean wrote:
> 
> When Thomas makes a sweeping statement about the applicability of one
> tool over another people will respond to him.  But if _you_ make such
> a statement yourself (even if it's based on his conclusions) then
> you better accept that people who disagree will respond to your statement.

I think it's unquestionable that sometimes it's better to work with 
patches. The thing is, git by its very design is about tracking things 
where history is firmly "set in stone", and that's not always what you 
want.

We've done a number of things to help people relax that a bit (notably 
"git rebase" and "git cherry-pick"), and there are projects like stgit 
that are more of a patch-management system on top of git, but even during 
the early design phases I said that it's likely that git will be used in 
_conjunction_ with tools like quilt etc, that are less strict than git is.

So I don't think we need to attack the notion of using non-git tools at 
all. Especially if you don't know where you're going, git's very strict 
immobile history can be a bit daunting.

(Of course, once you get really used to git, you use git _anyway_, and 
then you use cherry-pick and other tools to re-write a cleaned-up version 
of the thing that you originally screwed up because you didn't know what 
you were doing. So you _can_ do this too with git, but that doesn't mean 
that git would necessarily be the best way to do it).

That said, maybe we could help the "fixup" phases evenmore using git. For 
example, right now you can do "git cherry-pick" to transfer individual 
patches, but if you want to combine two commits while cherry-picking, it 
immediately gets more involved (still quite doable: use cherry-pick 
multiple times with the "-n" flag, but it's not as obvious any more).

			Linus
