Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVHORiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVHORiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVHORiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:38:15 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:18361 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964831AbVHORiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:38:15 -0400
Date: Mon, 15 Aug 2005 19:45:55 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works fine.
Message-ID: <20050815174555.GA16842@aitel.hist.no>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no> <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no> <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 08:50:12AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 15 Aug 2005, Helge Hafting wrote:
> >
> > Ok, I have downlaoded git and started the first compile.
> > Git will tell when the correct point is found (assuming I
> > do the "git bisect bad/good" right), by itself?
> 
> Yes. You should see 
> 
> 	Bisecting: xxx revisions left to test after this
> 
> and the "xxx" should hopefully decrease by half during each round. And t 
> the end of it, you should get
> 
> 	<sha1> is first bad commit
> 
> followed by the actual patch that caused the problem.
> 
> > Is there any way to make git tell exactly where between rc4 and rc5
> > each kernel is, so I can name the bzimages accordingly?
> 
> You'd have to use the raw commit names, since these things don't have any 
> symbolic names. You can get that by just doing
> 
> 	cat .git/HEAD
> 
> which will give you a 40-character hex string (representing the 160-bit 
> SHA1 of the top commit). Not very readable, but it's unique, and if you 
> report that hex string to other git users, they can trivially recreate the 
> tree you have.
> 
Good.  I save those .git/HEAD strings to a separate file.
The first iteration
a46e812620bd7db457ce002544a1a6572c313d8a
seemed to turn out "good".  I test further during the compile of
the next one.

Thanks for all the instructions on using git.

Helge Hafting
