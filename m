Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270951AbUJVKJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270951AbUJVKJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270947AbUJVKJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:09:33 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:7707 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270952AbUJVKJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:09:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tinRb0OoOQXUVCiXMvzvvBNtt+ICYukgaj0yHG/KfChO4Sp5JXdhoEao1Nko02Py6DbTw9cu4Z/7uy9Ns2obscAbqi/kMIWU5bHtfMtTd5OyyQ0/595IqTxpvXsK6wxuSLlw2Ao0DOd7a/6Fkpqh2iOvSkOtlYq38Bo1mH5IMO4=
Message-ID: <1a56ea3904102203095d6122a9@mail.gmail.com>
Date: Fri, 22 Oct 2004 11:09:15 +0100
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
In-Reply-To: <35fb2e59041021142467941ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041021011714.GQ24619@dualathlon.random>
	 <417728B0.3070006@yahoo.com.au>
	 <20041020213622.77afdd4a.akpm@osdl.org>
	 <16759.38054.944944.610417@alkaid.it.uu.se>
	 <20041021124505.GD8756@dualathlon.random>
	 <Pine.LNX.4.58.0410211354160.1252@gradall.private.brainfood.com>
	 <1a56ea3904102113217018d925@mail.gmail.com>
	 <35fb2e59041021142467941ed1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 22:24:44 +0100, Jon Masters <jonmasters@gmail.com> wrote:
> On Thu, 21 Oct 2004 21:21:55 +0100, DaMouse <damouse@gmail.com> wrote:
> 
> 
> > On Thu, 21 Oct 2004 13:54:41 -0500 (CDT), Adam Heath <doogie@debian.org> wrote:
> > > On Thu, 21 Oct 2004, Andrea Arcangeli wrote:
> > >
> > > > On Thu, Oct 21, 2004 at 12:51:18PM +0200, Mikael Pettersson wrote:
> > > > > Have you verified that? GCCs up to and including 2.95.3 and
> > > > > early versions of 2.96 miscompiled the kernel when spinlocks
> > > > > where empty structs on UP. I.e., you might not get a compile-time
> > > > > error but runtime corruption instead.
> > > >
> > > > peraphs we should add a check on the compiler and force people to use
> > > > gcc >= 3?
> > > >
> > > > Otherwise adding an #ifdef will fix 2.95, just like the spinlock does in
> > > > UP.
> > > >
> > > > btw, the only machine where I still have gcc 2.95.3 is not uptodate
> > > > enough to run 2.6 regardless of the fact 2.6 could compile on such
> > > > machine or not.
> > >
> > > So compile a 2.6 kernel on the machine with 2.95.3 for another machine.
> > >
> >
> > I think what he was referring to was that most machines with 2.95.x
> > have older kernels anyway.
> 
> That's probably mostly true even for embedded folks, but I don't think
> it's a good idea to completely throw away 2.95 users just yet. Better
> to use ifdefs or somesuch for now.
> 
> Jon.
> 

Perhaps making gcc 4.x a target for 2.7 would be a good idea though?

-DaMouse

-- 
I know I broke SOMETHING but its there fault for not fixing it before me
