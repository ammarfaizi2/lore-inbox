Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270436AbTGNNet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270351AbTGNNdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:33:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58559 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270150AbTGNNbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:31:50 -0400
Date: Mon, 14 Jul 2003 10:44:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>,
       Oleg Drokin <green@namesys.com>
Subject: Re: PATCH: use the right function in reiserfs (resend #3)
In-Reply-To: <200307141230.h6ECUvx9030962@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307141042320.18257@freak.distro.conectiva>
References: <200307141230.h6ECUvx9030962@hraefn.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you reiserfs people have anything pending (so you could merge Alan
patch) or can I apply ?

On Mon, 14 Jul 2003, Alan Cox wrote:

> #ra1
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/fs/reiserfs/prints.c linux.22-pre5-ac1/fs/reiserfs/prints.c
> --- linux.22-pre5/fs/reiserfs/prints.c	2003-07-14 12:27:42.000000000 +0100
> +++ linux.22-pre5-ac1/fs/reiserfs/prints.c	2003-07-06 14:06:59.000000000 +0100
> @@ -159,7 +159,7 @@
>
>    *skip = 0;
>
> -  while ((k = strstr (k, "%")) != NULL)
> +  while ((k = strchr (k, '%')) != NULL)
>    {
>      if (k[1] == 'k' || k[1] == 'K' || k[1] == 'h' || k[1] == 't' ||
>  	      k[1] == 'z' || k[1] == 'b' || k[1] == 'y' || k[1] == 'a' ) {
>
