Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312887AbSCZAQu>; Mon, 25 Mar 2002 19:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312888AbSCZAQj>; Mon, 25 Mar 2002 19:16:39 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:54289 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312887AbSCZAQd>; Mon, 25 Mar 2002 19:16:33 -0500
Date: Mon, 25 Mar 2002 20:11:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] smaller kernels
In-Reply-To: <3C9FBCDA.C898E977@zip.com.au>
Message-ID: <Pine.LNX.4.21.0203252010300.3409-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Mar 2002, Andrew Morton wrote:

> Marcelo Tosatti wrote:
> > 
> > I've just readded all asserts which you removed... if you really want to
> > remove any of those, please prove me that they are useless.
> 
> I grepped a year's lkml traffic - nobody is hitting any
> of them...

Anyway, they may catch bugs introduced by new modifications...

> The quotaops.h checks were useless:
> 
> 	if (pointer == NULL)
> 		BUG();
> 	dereference(pointer);
> 
> The others can become calls to out_of_line_bug() if
> you want.

Please do, thanks.


