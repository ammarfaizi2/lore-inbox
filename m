Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274073AbRISO0s>; Wed, 19 Sep 2001 10:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274075AbRISO0j>; Wed, 19 Sep 2001 10:26:39 -0400
Received: from viper.haque.net ([66.88.179.82]:40619 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S274073AbRISO01>;
	Wed, 19 Sep 2001 10:26:27 -0400
Date: Wed, 19 Sep 2001 10:26:46 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Mark Orr <markorr@intersurf.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.10p12 net/netsyms.c -- unresolved symbol tty_register_ldisc
In-Reply-To: <20010919092109.2ea5f89c.markorr@intersurf.com>
Message-ID: <Pine.LNX.4.33.0109191026090.13213-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Mark Orr wrote:

> With this fix, it compiles.  But in using the PPP modules
> I find that it doesnt work -- the modem hangs up as soon as
> connect is made.  /var/log/messages reports:
>
> Sep 19 09:11:27 darkstar insmod: /lib/modules/2.4.10-pre12/kernel/drivers/net/ppp_async.o: insmod tty-ldisc-3 failed

Look in the changelog

--snip--
If you build ppp support as modules, you will need the following in
your /etc/modules.conf file:

alias char-major-108  ppp_generic
alias /dev/ppp    ppp_generic
alias tty-ldisc-3 ppp_async
alias tty-ldisc-14  ppp_synctty
alias ppp-compress-21 bsd_comp
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate

--snip--


See if those changes help.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

