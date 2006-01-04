Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbWADRkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbWADRkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWADRkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:40:12 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:11283 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965247AbWADRkL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:40:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ev98tTyiIB7hvIsr3y8c5IuTMXX/2ysi6a2l0Kuna75um8FpRfzriqkd7sxHbwInaCJew7FywsYCh+R3zNqHBroM9CfO2AfCtlUGA5H7wyHZ18stw6uEjkeA9y+izBW1PsH6bDbHXP2mjoecfCnXVl7V3/g1eZKCC1Kt83s1LSI=
Message-ID: <9a8748490601040940peb15b75n454e02a622f795e1@mail.gmail.com>
Date: Wed, 4 Jan 2006 18:40:10 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601041728.52081.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041710.37648.nick@linicks.net>
	 <9a8748490601040918p24674d86j132315e9c8875483@mail.gmail.com>
	 <200601041728.52081.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Nick Warne <nick@linicks.net> wrote:
> On Wednesday 04 January 2006 17:18, Jesper Juhl wrote:
>
> > > Is there one?
> >
> > No.
> >
> > What you do is you first revert the 2.6.14.5 patch so you are left
> > with a 2.6.14 kernel, then you apply the 2.6.15 patch.
> > For more info, please read Documentation/applying-patches.txt
> > (http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt)
>
> I thought about doing it that way, but convinced myself it was too
> complicated.
>
> I see it is the right way (whatever that is).
>
> I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5
>
If you did that you did it wrong. The -stable patches are *not*
incremental, they all apply to the base 2.6.x kernel.

What you should have done is :

2.6.14 -> 2.6.14.1
then before applying the 2.6.14.2 patch you should have reverted the
2.6.14.1 patch
2.6.14.1 -> 2.6.14
Then you go from 2.6.14 directly to 2.6.14.2
2.6.14 -> 2.6.14.2
etc...
2.6.14.2 -> 2.6.14
2.6.14 -> 2.6.14.3
2.6.14.3 -> 2.6.14
2.6.14 -> 2.6.14.4
2.6.14.4 -> 2.6.14
2.6.14 -> 2.6.14.5

If what you say you did above actually worked that's pure luck.

> I suppose I have to backtrack and revert all those patches in order?
>
No, just revert the 2.6.14.5 patch and you'll be left with a plain
2.6.14 to which you can then apply the 2.6.15 patch.

It's only ever "revert one, apply one".

I cover this in the "The 2.6.x.y kernels" section in
Documentation/applying-patches.txt , was that section not clear? If
not, then feel free to offer suggestions on how I can improve the
wording to make it more clear.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
