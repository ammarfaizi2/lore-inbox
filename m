Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263633AbREYI3j>; Fri, 25 May 2001 04:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263634AbREYI33>; Fri, 25 May 2001 04:29:29 -0400
Received: from [195.6.125.97] ([195.6.125.97]:33552 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S263633AbREYI3T>;
	Fri, 25 May 2001 04:29:19 -0400
Date: Fri, 25 May 2001 10:24:34 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: ankry@green.mif.pg.gda.pl,
        liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: [timer] max timeout
Message-Id: <20010525102434.59817908.sebastien.person@sycomore.fr>
In-Reply-To: <200105231458.QAA22388@sunrise.pg.gda.pl>
In-Reply-To: <20010523162801.38dabdff.sebastien.person@sycomore.fr>
	<200105231458.QAA22388@sunrise.pg.gda.pl>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, 23 May 2001 16:58:15 +0200 (MET DST)
Andrzej Krzysztofowicz <ankry@pg.gda.pl> a ecrit :

> "sebastien person wrote:"
> > Is it bad to do the following call ?
> > 
> > 	mod_timer(&timer, jiffies+(0.1*HZ));
> 
> Yes, it is bad. Don't use floating point in the kernel if you don't
need.

So, there is a good solution to fire the timer after 100 ms ?
And is there any max limitation on the expires value ?

e.g. what is the biggest time period we could have between timer call and
the execution of the timer function ?



> 
> > that might fire the timer 1/10 second later.
> 
> HZ/10 is much better ...
> 
> -- 
> =======================================================================
>   Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
>   phone (48)(58) 347 14 61
> Faculty of Applied Phys. & Math.,   Technical University of Gdansk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
