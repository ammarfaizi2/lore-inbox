Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130169AbRBWI6R>; Fri, 23 Feb 2001 03:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRBWI6K>; Fri, 23 Feb 2001 03:58:10 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130169AbRBWI5y>;
	Fri, 23 Feb 2001 03:57:54 -0500
Message-ID: <20010222214650.C14395@bug.ucw.cz>
Date: Thu, 22 Feb 2001 21:46:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrzej Krzysztofowicz <ankry@pg.gda.pl>, zhaoway <zw@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Newbie ask for help: cramfs port to isofs
In-Reply-To: <877l2lyk3j.fsf@debian.org> <200102200935.KAA29865@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200102200935.KAA29865@sunrise.pg.gda.pl>; from Andrzej Krzysztofowicz on Tue, Feb 20, 2001 at 10:35:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- vanilla-2.4.1/fs/isofs/dir.c	Sat Dec 30 01:13:45 2000
> > +++ cisofs/fs/isofs/dir.c	Mon Feb 19 18:40:16 2001
> > @@ -108,8 +111,7 @@
> >  	unsigned int block, offset;
> >  	int inode_number = 0;	/* Quiet GCC */
> >  	struct buffer_head *bh = NULL;
> > -	int len;
> > -	int map;
> > +	int len = 0;
> 
> This will be the most probably rejected.
> Zero initializers are intentionally removed from the code to decrease
> the kernel image size.

Definitely not zero initializers of _auto_ variables!!!
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
