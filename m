Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbTBHCUo>; Fri, 7 Feb 2003 21:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTBHCUn>; Fri, 7 Feb 2003 21:20:43 -0500
Received: from norwich.jmjones.com ([216.238.56.67]:17669 "EHLO
	mail.jmjones.com") by vger.kernel.org with ESMTP id <S266964AbTBHCUl>;
	Fri, 7 Feb 2003 21:20:41 -0500
Date: Fri, 7 Feb 2003 21:20:08 -0500 (EST)
From: jmjones@jmjones.com
To: Christoph Hellwig <hch@infradead.org>
cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
In-Reply-To: <20030206151820.A11019@infradead.org>
Message-ID: <Pine.LNX.3.96.1030207205056.31221A-100000@dixie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Christoph Hellwig wrote:

> Well, selinux is still far from a mergeable shape and even needed additional
> patches to the LSM tree last time I checked.  This think of submitting hooks
> for code that obviously isn't even intende to be merged in mainline is what
> I really dislike, and it's the root for many problems with LSM.

I disagree.  The code submitted BOTH addresses the current needs and
"vaguely anticipated future needs" (which I shall define as VAFN).  I've
applied this code to my "personal security solution" and found it
*largely* to address my needs.  Wanna see my code?  *NO*  I have other
plans for my code, but I still think LSM supports me more than the 2.4
kernel does and, therefore, *I* believe it is a move in the right
direction for the kernel.

> 
> There has been a history in Linux to only implement what actually needed
> now instead of "clever" overdesigns that intend to look into the future,
> LSM is a gross voilation of that principle.  Just look at the modules in
> the LSM source tree:  the only full featured security policy in addition
> to the traditional Linux model is LSM, all the other stuff is just some
> additionl checks here and there.
> 

This is correct, except in its overall evaluation of Linux.  Linux has
accepted only "actually needed" code, but it has FURTHER accepted
"actually needed but GENERALLY useful code."  If one can accept code that
already has a purpose AND support other "'clever' overdesigns that intend
to look into the future" which are "not-opposed-to-current-thinking", one
has moved one's project closer to an ideal. 
 
You can narrow AND widen, and Linux is the *best* example of that policy,
to date.  There's no dishonor in accepting solutions that do what they
advertise AND allow what they have not advertised... provided they not
allow things widely defined as "evil."
 
> I'm very serious about submitting a patch to Linus to remove all hooks not
> used by any intree module once 2.6.0-test.
 
This would be unfortunate.  Narrow is good when one approaches a narrow
target, but LSM targets a wide target: Linux Security.

> 
> Life would be a lot simpler if you got the core flask engine in a mergeable
> shapre earlier and we could have merged the hooks for actually using it
> incrementally during 2.5, discussing the pros and contras for each hook
> given an actual example - but the current way of adding extremly generic
> hooks (despite the naming they are in no ways tied to enforcing security
> models at all) without showing and discussing the code behind them simply
> makes that impossible.
> 

Open your mind.  LSM supports both all current solutions for object-level
security AND provides a valid basis for moving Linux toward providing, AS
AN OPTION, true security.  Personally, I don't think LSM is the "be all
and end all" of a security interface, at this point, but I *do* think it's
the best first-draft of a system that can lead to that end.

Give me THREE design attributes that would make it better.  Bet you can't
come up with ONE.

LSM is NOT the *perfect* solution.  But I defy you to find a better
"first step" toward the solution of making Linux a "secure operating
system".  Nobody says it's cheap and the idea of making it a config-out
solution addresses that. 

What's your REAL problem?  Somebody stepping on your territory?
J. Melvin Jones

*-------------------------------------------------------
* J. Melvin Jones                http://www.jmjones.com/
* Webmaster, System Administrator, Network Administrator
* ------------------------------------------------------



