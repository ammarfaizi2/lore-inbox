Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSF0VEe>; Thu, 27 Jun 2002 17:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSF0VEd>; Thu, 27 Jun 2002 17:04:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3078 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316969AbSF0VEc>; Thu, 27 Jun 2002 17:04:32 -0400
Date: Thu, 27 Jun 2002 17:11:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: David Schwartz <davids@webmaster.com>
Cc: Hugh Dickins <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shm_destroy lock hang
In-Reply-To: <20020627202415.AAA1385@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.4.44.0206271711120.11790-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jun 2002, David Schwartz wrote:

>
> >Just please avoid doing that locking nastyness:
> >
> >function() {
> >unlock();
> >}
> >
> >
> >lock();
> >if (something)
> >    function();
> >else
> >    unlock();
>
> 	What do you do in cases where 'function' looks like this:
>
> function() {
>  something();
>  unlock();
>  something_else();
> }
>

Move something() outside function().

