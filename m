Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWCBRfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWCBRfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWCBRfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:35:50 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:41854 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932294AbWCBRft convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:35:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gTTsSFlIeJ876n2ZgKJ/6ron76GypWGabZIXLxxtKSJXsxr1jirQnvNyr/GXPwrDvtnT3AAWoepkvQsNpdOLo9eJPx50tg+/w1hNsIF+mQBnmL8gPWHtXz5IsFezgtrZyf0KBv1Im8gfH/JGloAQb60umBybALMbwh2sGT1S7k0=
Message-ID: <9a8748490603020935h4936ae0eob4bcf107cc75c923@mail.gmail.com>
Date: Thu, 2 Mar 2006 18:35:48 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Steffen Weber" <email@steffenweber.net>
Subject: Re: Another compile problem with 2.6.15.5 on AMD64
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44072B88.1020406@steffenweber.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <44071AF3.1010400@steffenweber.net>
	 <200603021811.50765.jesper.juhl@gmail.com>
	 <44072B88.1020406@steffenweber.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Steffen Weber <email@steffenweber.net> wrote:
> Jesper Juhl wrote:
> > On Thursday 02 March 2006 17:18, Steffen Weber wrote:
> >> I´m getting a compile error with 2.6.15.5 on x86_64 using GCC 3.4.4
> >> (does not seem to be related to the NFS one):
> >>
> >>    CC      mm/mempolicy.o
> >> mm/mempolicy.c: In function `get_nodes':
> >> mm/mempolicy.c:527: error: `BITS_PER_BYTE' undeclared (first use in
> >> this function)
> >> mm/mempolicy.c:527: error: (Each undeclared identifier is reported only
> >> once
> >> mm/mempolicy.c:527: error: for each function it appears in.)
> >>
> >
> > Try the following (untested patch).
> Thanks for your reply, but this patch does not solve the problem (same
> error message). I´ve appended my .config in case that might help.
>

Hmm, types.h contains the

#define BITS_PER_BYTE 8

that mmpolicy.c needs, so including that header should do the trick... odd..
I'll look at the code a bit more.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
