Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRBTJzn>; Tue, 20 Feb 2001 04:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRBTJze>; Tue, 20 Feb 2001 04:55:34 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:9491 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129363AbRBTJzR>; Tue, 20 Feb 2001 04:55:17 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: Newbie ask for help: cramfs port to isofs
Date: 20 Feb 2001 09:54:43 -0000
Organization: Alfie's Internet Node
Message-ID: <96tet3$3fn$1@alfie.demon.co.uk>
In-Reply-To: <877l2lyk3j.fsf@debian.org> <200102200935.KAA29865@sunrise.pg.gda.pl>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ankry@pg.gda.pl (Andrzej Krzysztofowicz) writes:
> "zhaoway wrote:"
> > -	int len;
> > -	int map;
> > +	int len = 0;
> 
> This will be the most probably rejected.
> Zero initializers are intentionally removed from the code to decrease
> the kernel image size.

A little knowledge is a dangerous thing.

The zero initializers can be removed from _static_ variables (those not
within function scope), where the initialization to zero is guarenteed.

In the case above, the variable being initialized is an automatic variable
(allocated on the stack), and so needs to be initialized.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
