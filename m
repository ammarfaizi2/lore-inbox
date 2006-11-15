Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162047AbWKOXRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162047AbWKOXRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162048AbWKOXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:17:54 -0500
Received: from nz-out-0102.google.com ([64.233.162.198]:27865 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1162047AbWKOXRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:17:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oWVgGv5rJSjo8ibFYiHkzsy6lHD3RLyylPxW+cI8sC1dFInl4tfordIkOkjezvkuuMJ89fLIAB8HXdMDIhsHYsager5Sb0p5bFGDvAvOMjYLvAJGFpF1ehpUYqPhbCpdAtAdWkzHtStBQAx5w3UKOLZCEmmb89OU9R8KaweD01E=
Message-ID: <9a8748490611151517r7779652ej910a33ca961ba025@mail.gmail.com>
Date: Thu, 16 Nov 2006 00:17:52 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "William D Waddington" <william.waddington@beezmo.com>
Subject: Re: [RFCLUE3] flagging kernel interface changes
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <455B9133.9030704@beezmo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <455B9133.9030704@beezmo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/06, William D Waddington <william.waddington@beezmo.com> wrote:
> I tried submitting a patch a while back:
> "[PATCH] IRQ: ease out-of-tree migration to new irq_handler prototype"
> to add #define __PT_REGS to include/linux/interrupt.h to flag the change
> to the new interrupt handler prototype.  It wasn't well received :(
>
> No big surprise.  The #define wasn't my idea and I hadn't submitted a
> patch before.  I wanted to see how the patch procedure worked, and
> hoped that the flag would be included so I could mod my drivers and
> move on...
>
> What I'm curious about is why flagging kernel/driver interface changes
> is considered a bad idea.  From my point of view as a low-life out-of-
> tree driver maintainer,
>
> #ifdef NEW_INTERFACE
> #define <my new internals>
> #endif
>
> (w/maybe an #else...)
>
> is cleaner and safer than trying to track specific kernel versions in
> a multi-kernel-version driver.  It seems that in some cases, the new
> interface has been, like HAVE_COMPAT_IOCTL for instance.
>
> I don't want to start an argument about "stable_api_nonsense" or the
> wisdom of out-of-tree drivers.  Just curious about the - why - and
> whether it is indifference or antagonism toward drivers outside the
> fold. Or ???
>

I would say that one reason is that cluttering up the kernel with
#ifdef's is ugly and annoying to maintain long-term. Especially when
it's expected that anyone who changes in-kernel interfaces also fix up
any user(s) of those interfaces, so the #ifdef's are pointless
(ignoring out-of-tree code that is).


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
