Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317579AbSGUAGk>; Sat, 20 Jul 2002 20:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSGUAGj>; Sat, 20 Jul 2002 20:06:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57586 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317579AbSGUAGf>; Sat, 20 Jul 2002 20:06:35 -0400
Subject: Re: [PATCH] VM strict overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: akpm@zip.com.au, Linus Torvalds <torvalds@transmeta.com>,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027209468.1555.893.camel@sinai>
References: <1027196403.1086.751.camel@sinai> 
	<1027211556.17234.55.camel@irongate.swansea.linux.org.uk> 
	<1027207835.1116.861.camel@sinai> 
	<1027213161.16818.65.camel@irongate.swansea.linux.org.uk> 
	<1027213626.16819.74.camel@irongate.swansea.linux.org.uk> 
	<1027209468.1555.893.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 02:21:32 +0100
Message-Id: <1027214492.16818.79.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 00:57, Robert Love wrote:
> No problem.
> 
> > Lets go with a sysctl tuned value and see what the 2.5 world finds the
> > best numbers to be ?
> 
> Great idea.  This allows pedants with swap to use 0, others to use 50,
> and those without swap to pick whatever works for them (e.g. 65% as you

On a swapless box you are unlikely to ever achieve 65% used by anonymous
pages in real world applications. Its suprising how much of memory is
file backed when you actually try it out. One exception in the future
might be a system with extensive amounts of XIP, where very little of
the binaries is actually pulled into RAM and thus counted into the
figures.

