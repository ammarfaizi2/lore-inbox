Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbUK0ERr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUK0ERr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUK0D6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:58:50 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262457AbUKZTas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:48 -0500
Date: Thu, 25 Nov 2004 19:39:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 22/51: Suspend2 lowlevel code.
Message-ID: <20041125183923.GK1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296166.5805.279.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101296166.5805.279.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +#include "../../../kernel/power/suspend.h"

Ouch.

> +#define loaddebug(thread,register) > +               __asm__("movl %0,%%db" #register  > +                       : /* no output */ > +                       :"r" ((thread)->debugreg[register]))

This should be already defined somewhere...

> + * Note that the context and timing of this function is pretty critical.
> + * With a minimal amount of things going on in the caller and in here, gcc
> + * does a good job of being just a dumb compiler.  Watch the assembly output
> + * if anything changes, though, and make sure everything is going in the right
> + * place. 

You should include assembly source (unless you can test all the compilers...). Feel free
to include C version, too, but #ifdef it out.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

