Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284615AbRLUP2S>; Fri, 21 Dec 2001 10:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284619AbRLUP2H>; Fri, 21 Dec 2001 10:28:07 -0500
Received: from hal.grips.com ([62.144.214.40]:16100 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S284615AbRLUP17>;
	Fri, 21 Dec 2001 10:27:59 -0500
Message-Id: <200112211527.fBLFR6X07357@hal.grips.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Gerold Jury <gjury@hal.grips.com>
To: <mingo@elte.hu>
Subject: Re: aio
Date: Fri, 21 Dec 2001 16:27:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>, <bcrl@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112211446370.5098-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0112211446370.5098-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 December 2001 14:48, Ingo Molnar wrote:
> On Fri, 21 Dec 2001, Gerold Jury wrote:
> > It is simply too early for sexy discussions. For me, the most
> > appealing part of AIO is the socket handling. It seems a little bit
> > broken in the current glibc emulation/implementation. Recv and send
> > operations are ordered when used on the same socket handle. Thus a
> > recv must be finished before a subsequent send will happen. Good idea
> > for files, bad for sockets.
>
> is this a fundamental limitation expressed in the interface, or just an
> implementational limitation? On sockets this is indeed a big problem, HTTP
> pipelining wants completely separate receive/send queues.
>
> 	Ingo
>

That is a very good question.

The Single UNIX ® Specification, Version 2 has the following to say.

If _POSIX_SYNCHRONIZED_IO is defined and synchronised I/O is enabled on the 
file associated with aiocbp->aio_fildes, the behaviour of this function is 
according to the definitions of synchronised I/O data integrity completion 
and synchronised I/O file integrity completion.

Maybe a was a little bit too fast in blaming glibc. I will go and look for 
more documentation about disabling synchronised I/O on a socket.

Dup()licating the socket handle is an easy workaround, but now i am 
convinced, a little bit man page digging will be lots of fun.

I hope the efforts of Benjamin LaHaise receive more attention and as soon as 
i know more about disabling synchronised I/O on sockets i will send an other 
email.

Gerold

--
I love AIO
