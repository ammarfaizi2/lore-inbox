Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318234AbSGWXQc>; Tue, 23 Jul 2002 19:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSGWXQb>; Tue, 23 Jul 2002 19:16:31 -0400
Received: from [195.223.140.120] ([195.223.140.120]:23620 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318234AbSGWXQb>; Tue, 23 Jul 2002 19:16:31 -0400
Date: Wed, 24 Jul 2002 01:20:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
Subject: Re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
Message-ID: <20020723232019.GV1117@dualathlon.random>
References: <m37kjmik0g.fsf@ccs.covici.com> <1027441872.31787.139.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027441872.31787.139.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 05:31:12PM +0100, Alan Cox wrote:
> On Tue, 2002-07-23 at 15:41, John Covici wrote:
> > In the latest release notes of sendmail I have read the following:
> > 
> > 		NOTE: Linux appears to have broken flock() again.  Unless
> > 			the bug is fixed before sendmail 8.13 is shipped,
> > 			8.13 will change the default locking method to
> > 			fcntl() for Linux kernel 2.4 and later.  You may
> > 			want to do this in 8.12 by compiling with
> > 			-DHASFLOCK=0.  Be sure to update other sendmail
> > 			related programs to match locking techniques.
> > 
> > Can anyone tell me what this is all about -- is there any basis in
> > reality for what they are saying?
> 
> First I've heard of it, so it would be useful if someone has access to
> the sendmail problem report/test in question that shows it and I'll go
> find out.

fix is in -aa from Matthew Wilcox:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa1/00_drop-broken-flock-account-1

fcntl API never obeyed to the accounting anyways.

Andrea
