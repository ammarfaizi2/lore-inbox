Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVF2GSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVF2GSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 02:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVF2GSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 02:18:12 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:39333 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262445AbVF2GSI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 02:18:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FXVqI7BIVnqJhAUE6ZhPCwNS9x68CvScx6XIvULLZCt8L6W1zRNCRbNar3rFx1Bb68Gtwtk/yzq++cQbJE+al8mtcn32zqN3zZXyVMwHg6b1g3hippxRewFp6CWwg6DRWtB9oRPmAOObLDPQW9+EHIKlgnymzGk56BwvszHiwP0=
Message-ID: <84144f02050628231814e9e6db@mail.gmail.com>
Date: Wed, 29 Jun 2005 09:18:07 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: reiser4 merging action list
Cc: Andrew Morton <akpm@osdl.org>, tytso@mit.edu, mjt@nysv.org,
       vonbrand@inf.utfsm.cl, ninja@slaphack.com, alan@lxorguk.ukuu.org.uk,
       jgarzik@pobox.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, lord@xfs.org, vs <vs@thebsh.namesys.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <42C2348F.3000908@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42BB7B32.4010100@slaphack.com>
	 <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>
	 <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org>
	 <42C0578F.7030608@namesys.com> <20050627212628.GB27805@thunk.org>
	 <42C084F1.70607@namesys.com> <20050627162303.156551b4.akpm@osdl.org>
	 <42C2348F.3000908@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > There's also the custom list, hash and debug code.  We should either
> >
> > a) remove them or
> >
> > b) generify them and submit as standalone works or
> >
> > c) justify them as custom-to-reiser4 and leave them as-is.

On 6/29/05, Hans Reiser <reiser@namesys.com> wrote:
> either b) or c) is ok with me for the list code.  The debug code should
> be c) I think.
> 
> Probably vs can offer a more detailed and accurate opinion,

I completely agree that the current state of the generic hashing
facilities is somewhat poor but I fail to see why you can't use
<linux/list.h>.

As for the debugging code, I would love to see that turned into
something generic (every subsystem has their own now) but it is
definitely not something that should stop you from merging.

                                Pekka
