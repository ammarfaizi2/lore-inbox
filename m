Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317480AbSFMGiQ>; Thu, 13 Jun 2002 02:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSFMGiP>; Thu, 13 Jun 2002 02:38:15 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:4765 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S317480AbSFMGiO>;
	Thu, 13 Jun 2002 02:38:14 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206130638.XAA08477@csl.Stanford.EDU>
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
To: viro@math.psu.edu (Alexander Viro)
Date: Wed, 12 Jun 2002 23:38:12 -0700 (PDT)
Cc: bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
In-Reply-To: <Pine.GSO.4.21.0206121824140.16357-100000@weyl.math.psu.edu> from "Alexander Viro" at Jun 12, 2002 06:26:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 12 Jun 2002, Benjamin LaHaise wrote:
> 
> > On Sun, Jun 09, 2002 at 08:56:30PM -0700, Dawson Engler wrote:
> > > Here are 37 errors where variables >= 1024 bytes are allocated on a function's
> > > stack.
> > 
> > Is it possible to get checker to determine the stack depth of a worst 
> > case call chain (excluding interrupts)?  I've found that deep call chains 
> > are far more likely to cause stack overflows than short and bounded paths.
> 
> Not realistic - we have a recursion through the ->follow_link(), and
> a lot of stuff can be called from ->follow_link().  We _do_ have a
> limit on depth of recursion here, but it won't be fun to deal with.

You mean following function pointers is not realistic?  Actually the
function pointers in linxu are pretty easy to deal with since, by
and large, they are set by static structure initialization and not
really fussed with afterwards.

