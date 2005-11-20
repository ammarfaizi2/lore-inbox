Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVKTBP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVKTBP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKTBP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:15:57 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:31001 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751122AbVKTBP4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:15:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X4utM6EwL45sSM/J2AXoejrliw0ZDfp6JSSX1by0Sv1KCGfTZQYViHuitXKOSdt/Qh2VReTq9qYpVjrF7s43c7HjtVpqXFxuzVFzKGY7cREha4lN173RtkLQlhC/GEFuNhRQO0IDEJhk44YYhX1enlEV1wvmE3BT++qAdcyY39A=
Message-ID: <9a8748490511191715x61057bc8i1431ca3a24cfb2e6@mail.gmail.com>
Date: Sun, 20 Nov 2005 02:15:56 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386, nmi: signed vs unsigned mixup
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20051119170818.5e16afae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511200010.33658.jesper.juhl@gmail.com>
	 <20051119162805.47796de9.akpm@osdl.org>
	 <9a8748490511191630r3ad3e24w4e6d21b3f3b0c3a7@mail.gmail.com>
	 <20051119170818.5e16afae.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/05, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > > -ETOOTRIVIAL.  The code as-is works OK, and we have these sorts of things
> >  > all over the tee.
> >  >
> >  Fair enough.
> >
> >  Would a patch to clean this sort of stuff up in bulk all over be of
> >  interrest or should I just leave it alone?
>
> Such a patchset would be pretty intrusive and it's not exactly trivial - at
> each site we need to decide whether we should be using signed or unsigned,
> then change one or the other, then do a full-scope check to see what the
> implications of that change are.
>
> I think the two risks of signedness sloppiness are a) inadvertent or
> premature overflow and b) comparisons, where the signed quantity went
> negative.
>
> Problem b) is more serious, and `gcc -Wsigned-compare' may be used to
> identify possible problems.  There are quite a lot of places need checking,
> iirc.
>
Ok, so does that mean that, if properly verified, patches for things
that "gcc -Wsigned-compare" flags will be appreciated?
I'll just restrict myself to that in that case.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
