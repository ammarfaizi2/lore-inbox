Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUAXVMl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUAXVMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:12:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:12993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262123AbUAXVMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:12:39 -0500
Date: Sat, 24 Jan 2004 13:12:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Kevin O'Connor" <kevin@koconnor.net>
cc: David Lang <david.lang@digitalinsight.com>,
       David Ford <david+hb@blue-labs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to
 public posts
In-Reply-To: <20040124201437.GA7133@arizona.localdomain>
Message-ID: <Pine.LNX.4.58.0401241307490.10144@home.osdl.org>
References: <20040121194315.GE9327@redhat.com> <Pine.LNX.4.58.0401211155300.2123@home.osdl.org>
 <1074717499.18964.9.camel@localhost.localdomain> <20040121211550.GK9327@redhat.com>
 <20040121213027.GN23765@srv-lnx2600.matchmail.com>
 <pan.2004.01.21.23.40.00.181984@dungeon.inka.de> <1074731162.25704.10.camel@localhost.localdomain>
 <yq0hdyo15gt.fsf@wildopensource.com> <401000C1.9010901@blue-labs.org>
 <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com>
 <20040124201437.GA7133@arizona.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Jan 2004, Kevin O'Connor wrote:
> 
> A good Bayesian spam filter isn't nearly as susceptible to random words as
> some people think.  Words that are likely to be spam (along with words that
> are frequently "ham") are given _exponentially_ more weight than other
> words.

Especially if the "random words" in the spam end up being weighted by real
frequency, you just _cannot_ use single-word bayes filters on it. Or if 
you do, you'll eventually have those words either being neutral, or (worst 
of all cases) you'll have real mail be marked as spam after having 
aggressively trained the filter for the spams.

It might not be that big of a deal especially if you have a fairly narrow 
scope of emails in your ham-list, but people who get mail from varied 
sources _will_ get screwed by this, one way or the other.

Of course, the spam filters will catch on to other things. I find that the 
DNS lookups take care of most of it, to the point where the other rules 
don't even much matter. 

		Linus
