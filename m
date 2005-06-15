Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVFOU4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVFOU4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVFOUzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:55:03 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:42410 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261564AbVFOUuV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:50:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMlVez88HDrHlDZClV8055ImmNj23V+GIG7A7Y3qnE6jHghgL4AEsIzTw6JgAcU+VZN9XO33ucCgVEnDID1vFc7YcitliqVdTAgYInEF+7//3A+I/XAvMa9FloYX2OpZ5Rx+u/C1u5ZAOMP2mfFfbwkIFkVUT2UptSEt6zr3WSY=
Message-ID: <f192987705061513503afb73cb@mail.gmail.com>
Date: Thu, 16 Jun 2005 00:50:15 +0400
From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Reply-To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1118690448.13770.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <1118669746.13260.20.camel@localhost.localdomain>
	 <f192987705061310202e2d9309@mail.gmail.com>
	 <1118690448.13770.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2005-06-13 at 18:20, Alexey Zaytsev wrote:
> > Yes, that's how it works, but if I want ext or reiser or whatever to
> > have NLS, I'll have to make them support it (btw, if I do so, wont it
> > be rejected?). I want to move the NLS one level upper so the
> > filesystem imlementations won't have to worry about it any more. I
> > don't have much kernel experience, and none in the fs area, so I can't
> > explain it any better, but hope you get the idea.
> 
> An ext3fs is always utf-8. People might have chosen to put other
> encodings on it but thats "not our fault" ;)
> 
> There are some good technical reasons too
> 
> Encodings don't map 1:1 - two names may cease to be unique
> 
> Encodings vary in length - image a file name that is longer than the
> allowed maximum on your system with your encoding choice - that could
> occur with KOI8-R to UTF-8 I believe

> 
> That said it ought to be possible to use the stackable fs work (FUSE
> etc) to write a layer you can mount over any fs that does NLS
> translation.

Now I quite agree that it isn't a Great Idea to do such conversion in
the kernel, but the problem still remains and there is no other place
we can do it. I belive that it should be done now and removed after
the world finishes to move to utf. Maybe it should not be applyed to
the main kernel tree, but I'm sure that at least Russian linux
distributions will like it.
