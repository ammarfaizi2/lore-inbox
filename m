Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVBFRjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVBFRjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVBFRjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:39:19 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:15009 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S261250AbVBFRjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:39:12 -0500
Date: Sun, 6 Feb 2005 09:39:10 -0800
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050206173910.GB24160@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	Roman Zippel <zippel@linux-m68k.org>,
	Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <Pine.LNX.4.61.0502060025020.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502060025020.6118@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, Roman, always a joy to hear from you.

> > 			CVS		BitKeeper	% in CVS
> > 	file deltas	210,609		218,742		96%
> > 	changsets	26,603		59,220		44%
> > 
> > In other words, the CVS tree is missing no more than 4% of the deltas
> > to the source files.
> > 
> > READ THAT AGAIN, PLEASE.
> > 
> > The CVS tree has 96% of all the deltas to all your source files.  96%.  
> 
> Before you start shouting, how about you get your numbers right? Your 
> first numbers were wrong and the second numbers are still wrong:
> 
> $ find -name \*,v -a ! -path ./BitKeeper\* -a ! -name ChangeSet,v | xargs rlog | egrep '\(Logical change 1.[0-9]+\)' | wc -l
> 187576

Bzzt.  You forgot all the intial deltas which are not marked with the
logical change comment.  And just to double check my logic I tried it
with rlog (much slower but whatever):

$ /tmp/linux-2.5-cvs find linux-2.5/ -name '*,v' |
xargs rlog | grep 'total revisions' |
awk 'BEGIN { n = 0 }; { n = n + $NF };  END { print n }'
237338
$ /tmp/linux-2.5-cvs perl REVS
files=22966 revs=237338

Imagine that, the numbers match perfectly.

It's always possible I've made a mistake but you really ought to check
your work a little bit before making false claims.  It's trivial to do
what I did which is run the script over a single file and hand verify
that it is correct.  

> > My good friend Stelian would have you believe that you are missing 50%
> > of your data when in fact you are missing NONE of your data, you have 
> > ALL of your data in an almost the identical form.
> 
> [Questionable complaints that he isn't getting enough information]

First, you can get all the granularity that you want from bkbits.net.
Find the file you want, find the revision, and go backwards to the
changeset.  It takes you a few clicks to do that.  

Second, your numbers are just plain wrong.  You have 96% of the data
and anyone can validate that.

Third, as someone else pointed out you have the bk-commits list so you
have an archive of the patches and the commits.

Fourth, it is your choice to not use BitKeeper because you want to compete
with the people who are helping you.  It's not that unreasonable that
you find yourself at something of a disadvantage because of that choice.
And the disadvantage is very slight as has been shown.  You can argue
all you want about the amount of disadvantage but it is your choice that
has placed you in that position.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
