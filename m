Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319093AbSHSXZJ>; Mon, 19 Aug 2002 19:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319096AbSHSXZJ>; Mon, 19 Aug 2002 19:25:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32505 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319093AbSHSXZI>; Mon, 19 Aug 2002 19:25:08 -0400
Subject: Re: MAX_PID changes in 2.5.31
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 00:29:11 +0100
Message-Id: <1029799751.21212.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 23:34, Ingo Molnar wrote:
> 
> On Mon, 19 Aug 2002, Richard Gooch wrote:
> 
> > Are you saying that people running libc 5 or even glibc 2.1 will
> > suddenly have their code broken?
> 
> nope. Only if they use the 16-bit PID stuff in SysV IPC semaphores and
> message queues.

libc5 is very much 16bit pid throughout. It would make sense that our
default (proc settable) pid max is 30000 still so that it only breaks
stuff if you increase it

