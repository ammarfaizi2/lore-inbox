Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbSKDLMj>; Mon, 4 Nov 2002 06:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSKDLMj>; Mon, 4 Nov 2002 06:12:39 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61444 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262325AbSKDLMj>; Mon, 4 Nov 2002 06:12:39 -0500
Message-Id: <200211041112.gA4BCmp32103@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Mon, 4 Nov 2002 14:04:42 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <1036340502.29642.36.camel@irongate.swansea.linux.org.uk> <1036372893.752.11.camel@phantasy>
In-Reply-To: <1036372893.752.11.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 23:21, Robert Love wrote:
> On Sun, 2002-11-03 at 11:21, Alan Cox wrote:
> > I would venture the reverse interpretation for modern processors,
> > the kernel inlines far far too much
>
> I agree 100% we mark too much as inline - but at the same time, some
> larger functions are inline simply because they were originally part
> of another function and pulled out for cleanliness.  They are only
> used once...  in other words, in some cases I hope the kernel
> developers know what they are doing when they mark stuff inline.

That's ok, but when function gets large inlining benefits are lost
in the noise.

But one day someone will add another call site. And sometimes people
forget to remove 'inline'. Then we lose big time.

> So I can see why bumping this limit very high is a good thing.

Frankly, I'd say we should not inline anything large
regardless of number of call sites, for reasons outlined above.

The limit is designed exactly for this purpose I think.
--
vda
