Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317922AbSGYAEl>; Wed, 24 Jul 2002 20:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317994AbSGYAEk>; Wed, 24 Jul 2002 20:04:40 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:43206 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317922AbSGYAEk>;
	Wed, 24 Jul 2002 20:04:40 -0400
Date: Wed, 24 Jul 2002 17:07:52 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
Message-ID: <20020724170752.A14089@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote :
> But, on my UP:
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.28; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.28/kernel/net/irda/irda.o
> depmod: 	cli
> depmod: 	restore_flags
> depmod: 	save_flags
> 
> (and no, CONFIG_SMP is not set :)
> 
> 
> Ciao,
> 
> --alessandro

	IrDA is not going to get fixed soon. Over the time I've been
fixing the IrDA stack, I've slowly fixed some of most dangerous
locking problems, but fixing the remaining code will involve some
serious re-work and is unfortunately not just about sprinking a few
spinlocks there and there.
	That's life...

	Jean
