Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263787AbTCVUKO>; Sat, 22 Mar 2003 15:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263795AbTCVUKO>; Sat, 22 Mar 2003 15:10:14 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:49904 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263787AbTCVUKM>; Sat, 22 Mar 2003 15:10:12 -0500
Date: Sat, 22 Mar 2003 12:19:57 -0800
From: Chris Wright <chris@wirex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chris@wirex.com>, Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030322121957.A2865@figure1.int.wirex.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chris Wright <chris@wirex.com>, Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	mc@cs.stanford.edu
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU> <20030321141507.B646@figure1.int.wirex.com> <1048366179.9219.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1048366179.9219.38.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Mar 22, 2003 at 08:49:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Fri, 2003-03-21 at 22:15, Chris Wright wrote:
> > on first pass of the cmd.  However, this is inconsistent with the rest
> > of the file, so here is a patch to use kcmd.resbuf.  I also added a NULL
> > check, as done in similar funcitons in this file.  Alan, this look ok?
> 
> Looks slightly wrong to me
> 
> #1 ->resbuf = NULL is a completely acceptable if odd user choice. If invalid
> its covered

OK, I wasn't sure if it was valid.  I noticed the other routines in that
file making similar checks.

> #2 - We copy to the users nominated cmd->resbuf. You are correct there, 
> that we should be using the kernel side copy. Fixed in my tree.

Great, thanks.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
