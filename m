Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVB1Uad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVB1Uad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVB1Uac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:30:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26375 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261726AbVB1UaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:30:06 -0500
Date: Mon, 28 Feb 2005 21:30:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
Cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Message-ID: <20050228203002.GH4021@stusta.de>
References: <20050228164456.GB17559@sd291.sivit.org> <Pine.GSO.4.40.0502281817001.27182-100000@ensisun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.40.0502281817001.27182-100000@ensisun>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 06:29:39PM +0100, emmanuel.colbus@ensimag.imag.fr wrote:
> 
> 
> On Mon, 28 Feb 2005, Stelian Pop wrote:
> 
> > On Mon, Feb 28, 2005 at 04:06:14PM +0100, colbuse@ensisun.imag.fr wrote:
> >
> > > +               /* Setting par[]'s elems at 0.  */
> > > +               memset(par, 0, NPAR*sizeof(unsigned int));
> >
> > No need for the comment here, everybody understands C.
> 
> 
> I knew this code would be understood, but I like comments :-) .
> 
> Well, without it, it gives :
> 
> 
> 
> --- old/drivers/char/vt.c 2004-12-24 22:35:25.000000000 +0100
> +++ new/drivers/char/vt.c 2005-02-28 18:19:11.782717810 +0100
> @@ -1655,8 +1655,8 @@
> vc_state = ESnormal;
> return;
> case ESsquare:
> - for(npar = 0 ; npar < NPAR ; npar++)
> - par[npar] = 0;
> + memset(par, 0, NPAR*sizeof(unsigned int));
>...
> Any other comments/remarks, or is _this_ patch version acceptable?

- whitespace damage
- your sizeof is extremely fragile
  why don't you run sizeof on the array?
- please do any development against -mm
  you'll note that the code you are working against has significantely
  changed in -mm

> Emmanuel Colbus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

