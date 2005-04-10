Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVDJRpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVDJRpv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVDJRpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:45:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52964 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261536AbVDJRpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:45:35 -0400
Date: Sun, 10 Apr 2005 19:45:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Willy Tarreau <willy@w.ods.org>
Cc: Petr Baudis <pasky@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410174512.GA18768@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410174221.GD7858@alpha.home.local>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Willy Tarreau <willy@w.ods.org> wrote:

> > >   I will also need to do more testing on the linux kernel tree.
> > > Committing patch-2.6.7 on 2.6.6 kernel and then diffing results in
> > > 
> > > 	$ time gitdiff.sh `parent-id` `tree-id` >p
> > > 	real    5m37.434s
> > > 	user    1m27.113s
> > > 	sys     2m41.036s
> > > 
> > > which is pretty horrible, it seems to me. Any benchmarking help is of
> > > course welcomed, as well as any other feedback.
> > 
> > it seems from the numbers that your system doesnt have enough RAM for 
> > this and is getting IO-bound?
> 
> Not the only problem, without I/O, he will go down to 4m8s (u+s) which 
> is still in the same order of magnitude.

probably not the only problem - but if we are lucky then his system was 
just trashing within the kernel repository and then most of the overhead 
is the _unnecessary_ IO that happened due to that (which causes CPU 
overhead just as much). The dominant system time suggests so, to a 
certain degree. Maybe this is wishful thinking.

	Ingo
