Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVBGCLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVBGCLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 21:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVBGCLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 21:11:04 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:2990 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S261339AbVBGCKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 21:10:36 -0500
Date: Sun, 6 Feb 2005 18:10:30 -0800
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050207021030.GA25673@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	Roman Zippel <zippel@linux-m68k.org>,
	Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
References: <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <Pine.LNX.4.61.0502060025020.6118@scrub.home> <20050206173910.GB24160@bitmover.com> <Pine.LNX.4.61.0502061859000.30794@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502061859000.30794@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bzzt. Larry, I will make this one very easy, so that even you can follow 
> it. Let's take a simple file:
> 
> $ rlog REPORTING-BUGS,v | grep 'total revisions'
> total revisions: 3;	selected revisions: 3
> $ rlog REPORTING-BUGS,v | egrep '\(Logical change 1.[0-9]+\)'
> (Logical change 1.31)
> (Logical change 1.3)

Exactly.  The second one shows 2 revs, which is what you counted, and
the first shows 3 which is what is actually there.

See, all you have to do is look:

slovax /tmp/linux-2.5-cvs/linux-2.5 rlog REPORTING-BUGS,v 

RCS file: REPORTING-BUGS,v
Working file: REPORTING-BUGS
head: 1.3
branch:
locks: strict
access list:
symbolic names:
keyword substitution: o
total revisions: 3;     selected revisions: 3
description:
BitKeeper to RCS/CVS export
----------------------------
revision 1.3
date: 2002/02/05 18:07:03;  author: patch;  state: Exp;  lines: +3 -4
Import patch diff

(Logical change 1.31)
----------------------------
revision 1.2
date: 2002/02/05 17:40:40;  author: torvalds;  state: Exp;  lines: +58
-0
(Logical change 1.3)
----------------------------
revision 1.1
date: 2002/02/05 17:40:40;  author: torvalds;  state: Exp;
Initial revision

As for your pointer to the revision history on the web which shows 2
revs, you just don't understand BK.  There is a 1.0 delta in every file
that we hide by default.  That would be the matching delta to the RCS
1.1 delta.  

> > Fourth, it is your choice to not use BitKeeper because you want to compete
> > with the people who are helping you.  It's not that unreasonable that
> > you find yourself at something of a disadvantage because of that choice.
> > And the disadvantage is very slight as has been shown.  You can argue
> > all you want about the amount of disadvantage but it is your choice that
> > has placed you in that position.
> 
> Well, I'm not the one who claimed "We don't do lockins.  Period."
> I'm just trying to figure out what that means...

Hey, Roman, the statement above stands.  You made the choice that you want
to go write a competing system.  If you hadn't you could just use BK and
stop whining.  Since you have made that choice, which is your right,
how about you produce your competing system?  And stop whining that
we aren't giving you enough help.  What is that you say?  It's hard?
It's way harder if we don't give you a roadmap?  Well gosh darn, that
must really suck for you.  I'm really sorry that you can't figure it out
without our help but that's sort of the whole point, isn't it?  
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
