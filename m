Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVKWSEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVKWSEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVKWSEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:04:43 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:23171 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932138AbVKWSEm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:04:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=axlHya36Q2Za1wY9jEPBjYx4HENeWIpgZqrGkvqBgdT61Mfw4miAJpB6yWRqM1I4Z3TRbLXLnov+rwVOV7D3W9naHCaZ4FeEAR8lNZU5bgOwiU1WUBALuw5BuQ/XuKyKcEz+2ix0W3PWfmMv7LVOmsTDecsKtHS6+Ul6hkIWIvg=
Message-ID: <9a8748490511231004l36edcf57mf0fb63c4a9e17f49@mail.gmail.com>
Date: Wed, 23 Nov 2005 19:04:41 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Over-riding symbols in the Kernel causes Kernel Panic
Cc: Ashutosh Naik <ashutosh.lkml@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4384AAED.3070804@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c216304e0511230610x2b983e59h42c10517acd59e63@mail.gmail.com>
	 <4384AAED.3070804@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Bill Davidsen <davidsen@tmr.com> wrote:
> Ashutosh Naik wrote:
> > Hi,
> >
> > I made e1000 ( or for that matter anything) a part of the 2.6.15-rc1
> > kernel and booted the kernel. Next I compiled e1000 as a module (
> > e1000.ko ), and tried to insmod it into the kernel( which already had
> > e1000 a compiled as a part of the kernel). I observed that
> > /proc/kallsyms contained two copies of all the symbols exported by
> > e1000, and I also got a Kernel Panic on the way.
> >
> > Is this behaviour natural and desirable ?
>
> No, trying to insert a module into a kernel built with the functionality
> compiled in is a vile perverted act, and probably illegal in Republican
> states! ;-)
>
> The other day I mentioned that reiser4 will find bugs because people
> will do bizarre things with it when it is more widely used. I think you
> have hit a "no one would ever do that" bug in the module loader, and
> demonstrated my point in the process.
>
> The panic isn't desirable, but I'm not sure what "correct behaviour"
> would be, I can't imagine that this is intended to work. The issues of
> removing such a module gracefully are significant.

Wouldn't the desired behaviour be that when the kernel attempts to
load a module it checks if it is already present build-in and if so
simply refuse to load it at all?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
