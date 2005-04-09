Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVDIUHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVDIUHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 16:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVDIUHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 16:07:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10443 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261379AbVDIUHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 16:07:12 -0400
Date: Sat, 9 Apr 2005 22:07:09 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050409200709.GC3451@pasky.ji.cz>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Ross Vandegrift <ross@jose.lug.udel.edu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dear diary, on Sat, Apr 09, 2005 at 09:45:52PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> The good news is, the data structures/indexes haven't changed, but many of 
> the tools to interface with them have new (and improved!) semantics:
> 
> In particular, I changed how "read-tree" works, so that it now mirrors
> "write-tree", in that instead of actually changing the working directory,
> it only updates the index file (aka "current directory cache" file from
> the tree).
> 
> To actually change the working directory, you'd first get the index file
> setup, and then you do a "checkout-cache -a" to update the files in your
> working directory with the files from the sha1 database.

that's great. I was planning to do something with this since currently
it really annoyed me. I think I will like this, even though I didn't
look at the code itself yet (just on my way).

> Also, I wrote the "diff-tree" thing I talked about: 
..snip..

Hmm, I wonder, is this better done in C instead of a simple shell
script, like my gitdiff.sh? I'd say it is more flexible and probably
hardly performance-critical to have this scripted, and not difficult at
all provided you have ls-tree. But maybe I'm just too fond of my
script... ;-) (Ok, there's some trouble when you want to have newlines
and spaces in file names, and join appears to be awfully ignorant about
this... :[ )

BTW, do we care about changed modes? If so, they should probably have
their place in the diff-tree output.

BTW#2, I hope you will merge my ls-tree anyway, even though there is no
user for it currently... I should quickly figure out some. :-)

> Can you guys re-send the scripts you wrote? They probably need some 
> updating for the new semantics. Sorry about that ;(

I'll try to merge ASAP.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
