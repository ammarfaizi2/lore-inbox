Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRLULve>; Fri, 21 Dec 2001 06:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280027AbRLULvY>; Fri, 21 Dec 2001 06:51:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42148 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S279798AbRLULvR>;
	Fri, 21 Dec 2001 06:51:17 -0500
Date: Fri, 21 Dec 2001 14:48:42 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Gerold Jury <gjury@hal.grips.com>
Cc: Dan Kegel <dank@kegel.com>, "David S. Miller" <davem@redhat.com>,
        <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <200112211144.fBLBivK06638@hal.grips.com>
Message-ID: <Pine.LNX.4.33.0112211446370.5098-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Dec 2001, Gerold Jury wrote:

> It is simply too early for sexy discussions. For me, the most
> appealing part of AIO is the socket handling. It seems a little bit
> broken in the current glibc emulation/implementation. Recv and send
> operations are ordered when used on the same socket handle. Thus a
> recv must be finished before a subsequent send will happen. Good idea
> for files, bad for sockets.

is this a fundamental limitation expressed in the interface, or just an
implementational limitation? On sockets this is indeed a big problem, HTTP
pipelining wants completely separate receive/send queues.

	Ingo

