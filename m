Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263773AbTDXSQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTDXSQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:16:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:31757 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263773AbTDXSQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:16:30 -0400
Date: Thu, 24 Apr 2003 20:27:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Timothy Miller <miller@techsource.com>
Cc: root@chaos.analogic.com, Chuck Ebbert <76306.1226@compuserve.com>,
       Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
Message-ID: <20030424182756.GA19290@alpha.home.local>
References: <200304241128_MC3-1-35DA-F3DA@compuserve.com> <Pine.LNX.4.53.0304241147420.32073@chaos> <3EA8114A.4020309@techsource.com> <Pine.LNX.4.53.0304241244430.32333@chaos> <3EA81BBB.3020709@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA81BBB.3020709@techsource.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Well, although I usually don't like these endless coding-style threads, why
don't you simply use this common form ? :

    return !!(foo & MASK);

I found that the compilers like it much and easily emit conditionnal set
instructions. Eg, on x86, this should be something like :

   testl MASK, foo
   setnz retcode

Cheers,
Willy

On Thu, Apr 24, 2003 at 01:15:39PM -0400, Timothy Miller wrote:
> >
> >
> >I meant return ((foo & MASK) && 1);
> >
> >Try it, you'll like it! No shifts, no jumps.
> >
> > 
> >
> 
> Looks sweet!  If the compiler is smart, that is.  I'll add that to my 
> repetoire.  I'll have to see what the asm output looks like.
