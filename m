Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUBDQzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 11:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUBDQzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 11:55:25 -0500
Received: from intra.cyclades.com ([64.186.161.6]:11951 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262652AbUBDQzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 11:55:20 -0500
Date: Wed, 4 Feb 2004 14:46:01 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Kronos <kronos@kronoz.cjb.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 15/42]
In-Reply-To: <20040202194631.GO6785@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.58L.0402041445480.1324@logos.cnet>
References: <20040130204956.GA21643@dreamland.darkstar.lan>
 <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
 <20040202194631.GO6785@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Feb 2004, Kronos wrote:

>
> ../fdomain.c:565: warning: `fdomain_setup' defined but not used
>
> fdomain_setup isn't used when the driver is modular.
>
> diff -Nru -X dontdiff linux-2.4-vanilla/drivers/scsi/fdomain.c linux-2.4/drivers/scsi/fdomain.c
> --- linux-2.4-vanilla/drivers/scsi/fdomain.c	Sat Jan 31 15:54:42 2004
> +++ linux-2.4/drivers/scsi/fdomain.c	Sat Jan 31 17:21:13 2004
> @@ -561,6 +561,7 @@
>     printk( "\n" );
>  }
>
> +#ifndef MODULE
>  static int __init fdomain_setup( char *str )
>  {
>  	int ints[4];
> @@ -584,6 +585,7 @@
>  }
>
>  __setup("fdomain=", fdomain_setup);
> +#endif
>
>
>  static void do_pause( unsigned amount )	/* Pause for amount*10 milliseconds */

What?

from fdomain.c:

#ifdef MODULE
        if (fdomain)
                fdomain_setup(fdomain);
#endif


