Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTFANg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264613AbTFANg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:36:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28432 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264612AbTFANgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:36:25 -0400
Date: Sun, 1 Jun 2003 15:49:42 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Larry McVoy <lm@work.bitmover.com>, Steven Cole <elenstev@mesatop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601134942.GA10750@alpha.home.local>
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601132626.GA3012@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry !

On Sun, Jun 01, 2003 at 06:26:26AM -0700, Larry McVoy wrote:
> On Sat, May 31, 2003 at 11:56:16PM -0600, Steven Cole wrote:
> > Proposed conversion:
> > 
> > int foo(void)
> > {
> >    	/* body here */
> > }	
> 
> Sometimes it is nice to be able to see function names with a 
> 
> 	grep '^[a-zA-Z].*(' *.c

This will return 'int foo(void)', what's the problem ?

> which is why I've always preferred
> 
> int
> foo(void)
> {
> 	/* body here */
> }	
> 
> Is there some reason that I'm missing that the kernel folks like it the other
> way?  

It will only return 'foo(void)', and you won't find its return type.
Personally, I strongly prefer getting maximum information in one line, and
I find it useful to have the return type, the name and the args together.

If you still need the name and only the name, use some sed on the output :

   sed 's/^\([^ ]* \)*\([^]*\)(.*/\2/'

Cheers,
Willy
