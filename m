Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbUL2Wqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUL2Wqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUL2Wqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:46:33 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:13488 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261386AbUL2Wq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:46:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kX/SEscvc4OZupORO3sNBmEsMIBp4dbGv6J36fcoC3lbpHjJWNNSs1+yiyZUZSjbnC141zLMBGU4zZ7ZECbXY74LHAdZWh+/IEif1rPr8FemrIvGucYI/JdkJ6ijCcAvh9eUACRHbgShBvpQNYXHYg2zIL54n2/giczm3AaOKv4=
Message-ID: <4d8e3fd304122914466b42c632@mail.gmail.com>
Date: Wed, 29 Dec 2004 23:46:27 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Trying out SCHED_BATCH
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
In-Reply-To: <41D31373.1090801@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <m3mzw262cu.fsf@rajsekar.pc> <41CD51E6.1070105@kolivas.org>
	 <04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak> <41D31373.1090801@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 07:28:35 +1100, Con Kolivas <kernel@kolivas.org> wrote:
> Maciej Soltysiak wrote:
> > Hi
> >
> > Con wrote:
> >
> >> Only the staircase scheduler currently has an implementation of
> >> sched_batch and you need 2 more patches on top of the staircase patch
> >> for it to work.
> >
> > Hmm, Is it feasable to write a sched_batch policy for the current linux
> > schedulers?
> 
> Yes.
> 
> The proper way to make a sched_batch implementation is more
> comprehensive than what is made for staircase to prevent a deadlock
> based on a batch task getting an important lock in the kernel and not
> being able to release it due to a sched_normal task being higher
> priority than it that is actually trying to get the lock. There is code
> in the staircase version to prevent this from happening but probably not
> complete enough in design to prevent everything. However it works and I
> haven't had any reports of lockups since I implemented the extra checking.
> 
> Would you like me to create a version like that? I don't have the time
> to try and make a more comprehensive solution and follow the debugging
> of such a beast.
> 
> > I mean, if there are people that want it bad, maybe it would be nice to
> > be able
> > to use a version of sched_batch that would work without the staircase
> > scheduler.
> > It is still experimental, right?
> 
> No it's not experimental. It is very stable and used in production systems.

Are you gointo  to push to Linus/Andrew ?

-- 
Paolo
