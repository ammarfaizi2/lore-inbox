Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262299AbRERLdF>; Fri, 18 May 2001 07:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbRERLcz>; Fri, 18 May 2001 07:32:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51211 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262294AbRERLcp>; Fri, 18 May 2001 07:32:45 -0400
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
To: andrewm@uow.edu.au (Andrew Morton)
Date: Fri, 18 May 2001 12:29:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), alborchers@steinerpoint.com,
        linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, tytso@mit.edu,
        pberger@brimson.com (Peter Berger)
In-Reply-To: <3B04F4C2.C472C6D7@uow.edu.au> from "Andrew Morton" at May 18, 2001 08:09:06 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150iRw-0006zV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - implements tty->ldisc_sem to plug race between do_tty_hangup()
>   and tty_set_ldisc().  Is this the ldisc race to which you refer?

Actually I'd missed that one. I was referring to the module race on the ldisc

> +#ifdef CONFIG_MODULES
> +	struct module *owner;
> +#endif

I'd rather the field was always there.  THIS_MODULE is correctly NULL for non
modules. Doing that makes all the ifdefs vanish and probably makes it a lot
more likely to pass Linus


