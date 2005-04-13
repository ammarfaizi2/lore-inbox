Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVDMJqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVDMJqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVDMJql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:46:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9899 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261282AbVDMJqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:46:21 -0400
Date: Wed, 13 Apr 2005 11:46:19 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413094619.GQ16489@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <20050413103521.D1798@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413103521.D1798@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 13, 2005 at 11:35:21AM CEST, I got a letter
where Russell King <rmk+lkml@arm.linux.org.uk> told me that...
> On Mon, Apr 11, 2005 at 03:57:58PM +0200, Petr Baudis wrote:
> >   here goes git-pasky-0.3, my set of patches and scripts upon
> > Linus' git, aimed at human usability and to an extent a SCM-like usage.
> 
> I tried this today, applied my patch for BE<->LE conversions and
> glibc-2.2 compatibility (attached, still requires cleaning though),
> and then tried git pull.  Umm, whoops.
> 
> Here's just a small sample of what happened:
> 
> diff: /9a30ec42a6c4860d3f11ad90c1052823a020de32/show-files.c: No such file or directory
> diff: /85bf824bd24f034896f5820a2628148a246f8fd1/show-files.c: No such file or directory
> mkdir: cannot create directory `/9a30ec42a6c4860d3f11ad90c1052823a020de32': Permission denied
> mkdir: cannot create directory `/85bf824bd24f034896f5820a2628148a246f8fd1': Permission denied
> ./gitdiff-do: /9a30ec42a6c4860d3f11ad90c1052823a020de32/update-cache.c: No such
> file or directory
> ./gitdiff-do: /85bf824bd24f034896f5820a2628148a246f8fd1/update-cache.c: No such
> file or directory
> diff: /9a30ec42a6c4860d3f11ad90c1052823a020de32/update-cache.c: No such file or
> directory
> diff: /85bf824bd24f034896f5820a2628148a246f8fd1/update-cache.c: No such file or
> directory
> patch: **** Only garbage was found in the patch input.

I'll bet at the top of this you have a mktemp error.

mktemp turns out to be a PITA to use - on some older systems (e.g.
Mandrake 10 stock install) it has incompatible usage to the rest of the
world. When I will get a convenient infrastructure for making a shell
library, I will probably add a test for this to it.

Try to upgrade your mktemp. That Mandrake 10 user said that urpmi should
have a newer (correct) version.

I will make a patch which will refer to ?time instead instead of
?tim.sec for seconds. That should fix your problem.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
