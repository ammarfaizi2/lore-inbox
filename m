Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263762AbTCVT0e>; Sat, 22 Mar 2003 14:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263776AbTCVT0e>; Sat, 22 Mar 2003 14:26:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26011
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263762AbTCVT0d>; Sat, 22 Mar 2003 14:26:33 -0500
Subject: Re: [CHECKER] potential dereference of user pointer errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chris@wirex.com>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
In-Reply-To: <20030321141507.B646@figure1.int.wirex.com>
References: <200303041112.h24BCRW22235@csl.stanford.edu>
	 <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
	 <20030321141507.B646@figure1.int.wirex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048366179.9219.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 20:49:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 22:15, Chris Wright wrote:
> on first pass of the cmd.  However, this is inconsistent with the rest
> of the file, so here is a patch to use kcmd.resbuf.  I also added a NULL
> check, as done in similar funcitons in this file.  Alan, this look ok?

Looks slightly wrong to me

#1 ->resbuf = NULL is a completely acceptable if odd user choice. If invalid
its covered

#2 - We copy to the users nominated cmd->resbuf. You are correct there, 
that we should be using the kernel side copy. Fixed in my tree.

