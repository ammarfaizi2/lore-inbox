Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317414AbSFDJAj>; Tue, 4 Jun 2002 05:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSFDJAi>; Tue, 4 Jun 2002 05:00:38 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:34352 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S317414AbSFDJAh>;
	Tue, 4 Jun 2002 05:00:37 -0400
Date: Tue, 4 Jun 2002 11:00:32 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: [PATCH] 2.4.19-pre10 s/Efoo/-Efoo/ drivers/char/rio/*.c
Message-ID: <20020604110032.A28843@jaquet.dk>
In-Reply-To: <Pine.LNX.4.44.0206041643070.32156-100000@thor.cantech.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 04:48:58PM +0800, Anthony J. Breeds-Taurima wrote:
> Hello All,
> 	This is another cleanup patch changing positive return values into
> negative's.
> 
> 
> Yours Tony
> 
> Jan 22-26 2003      Linux.Conf.AU       http://conf.linux.org.au/
>          The Australian Linux Technical Conference!
> 
> --------------------------------------------------------------------------------
> diff -X dontdiff -urN linux-2.4.19-pre10.clean/drivers/char/rio/rio_linux.c linux-2.4.19-pre10/drivers/char/rio/rio_linux.c
> --- linux-2.4.19-pre10.clean/drivers/char/rio/rio_linux.c	Tue Apr 30 13:22:07 2002
> +++ linux-2.4.19-pre10/drivers/char/rio/rio_linux.c	Tue Jun  4 16:27:36 2002
> @@ -702,7 +702,7 @@
>    func_enter();
>  
>    /* The "dev" argument isn't used. */
> -  rc = -riocontrol (p, 0, cmd, (void *)arg, suser ());
> +  rc = riocontrol (p, 0, cmd, (void *)arg, suser ());

I'm sorry but since this code indeed changes the positive return
codes into negatives, what is the purpose of your patch? Have you
talked to the maintainer (R.E.Wolff)?


Rasmus
