Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269335AbUICP3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269335AbUICP3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269416AbUICPWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:22:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40610 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268989AbUICPUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:20:41 -0400
Date: Fri, 3 Sep 2004 17:19:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.dk
Subject: Re: Nasty IDE crasher in 2.6.9rc1
Message-ID: <20040903151928.GE1717@suse.de>
References: <20040831142335.GA15841@devserv.devel.redhat.com> <20040903145054.GQ1631@suse.de> <1094219998.7975.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094219998.7975.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03 2004, Alan Cox wrote:
> On Gwe, 2004-09-03 at 15:50, Jens Axboe wrote:
> > (suse.dk is not related to suse.de and it helpfully eats all messages
> > sent to unknown users. not so great :(
> 
> Ah sorry.
> 
> > > Another problem with barrier is that it can take several minutes worst case
> > > for the command to complete on a large modern drive (timings c/o friendly
> > > ide drive engineer). That causes two problems I've pointed out to Jens that
> > > we need to fix before barriers are IMHO production grade
> > 
> > Can you pass me his results?
> 
> I can ask. Its NDA data (not Maxtor). Or Eric might have public info ?
> The later mail I reported my tests trying to make it as slow as possible
> and I couldn't get worse than 7 seconds for the command.

IIRC, 7 seconds is the magic number that Microsoft uses for when a
command times out in the kernel... That might make the results a little
suspicious :)

> 
> > > 2.	The timeouts on the command issue appear to be too small, and
> > > 	we will time out and reset the drive in loaded situations. 
> > 
> > You don't seem to address that in your patch?
> 
> I'm not sure what the right answer is.

I guess as a first measure just increasing the timeout two-fold will
cover most of the problem.

-- 
Jens Axboe

