Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263524AbSJGWRH>; Mon, 7 Oct 2002 18:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263525AbSJGWRH>; Mon, 7 Oct 2002 18:17:07 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:52486 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S263524AbSJGWRF>;
	Mon, 7 Oct 2002 18:17:05 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: simon@baydel.com, "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
References: <3DA16A9B.7624.4B0397@localhost>
	<3DA1CF36.19659.13D4209@localhost>
	<1034022158.26550.28.camel@irongate.swansea.linux.org.uk>
From: Christer Weinigel <christer@weinigel.se>
Date: 08 Oct 2002 00:22:42 +0200
In-Reply-To: <1034022158.26550.28.camel@irongate.swansea.linux.org.uk>
Message-ID: <87smzhzy6l.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Also my original comments were much more aimed at the core stuff. People
> who made existing and especially core stuff smaller could send the stuff
> out. Several of us want to compile a CONFIG_TINY option, and suprisingly
> enough small is good on high end boxes. My L1 cache is 8 times faster
> than my L2 cache is 7 times faster than my memory. Or to put it another
> way, going to main memory costs me maybe 100 instructions.
> 
> My Athlon thinks small is good too!

Regarding this, has anyone been thinking of splitting printk into a
bunch of macros such as:

#ifndef CONFIG_TINY
#define printk_debug(xxx...) printk(KERN_DEBUG, xxx...)
#define printk_info(xxx...) printk(KERN_INFO, xx...)
#else
#define printk_debug(xxx...) do { } while (0)
#define printk_info(xxx...) do { } while (0)
#endif

and so on?  This way debug messages could very simply be compiled to
oblivion when CONFIG_TINY is enabled.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
