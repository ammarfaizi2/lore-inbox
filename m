Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbTGJDQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268864AbTGJDQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:16:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8926 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S268851AbTGJDQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:16:52 -0400
Date: Thu, 10 Jul 2003 00:29:06 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "J.A. Magallon" <jamagallon@able.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] do_generic_direct_write: bad flag check
In-Reply-To: <20030709231348.GC18564@werewolf.able.es>
Message-ID: <Pine.LNX.4.55L.0307100028320.6629@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
 <20030709231348.GC18564@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Jul 2003, J.A. Magallon wrote:

>
> On 07.10, Marcelo Tosatti wrote:
> >
> > Hi,
> >
> > Here goes -pre4. It contains a lot of updates and fixes.
> >
>
> --- linux-2.4.22-pre2-jam1/mm/filemap.c.orig	2003-06-28 01:55:36.000000000 +0200
> +++ linux-2.4.22-pre2-jam1/mm/filemap.c	2003-06-28 01:55:45.000000000 +0200
> @@ -3223,7 +3223,7 @@
>  	if (err != 0 || count == 0)
>  		goto out;
>
> -	if (!file->f_flags & O_DIRECT)
> +	if (!(file->f_flags & O_DIRECT))
>  		BUG();
>
>  	remove_suid(inode);
>
> ...but sure the fix in -ac is better.

What is the difference between the fix in -ac and yours?
