Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131333AbRCHMBN>; Thu, 8 Mar 2001 07:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131335AbRCHMBC>; Thu, 8 Mar 2001 07:01:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59147 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131333AbRCHMA5>; Thu, 8 Mar 2001 07:00:57 -0500
Subject: Re: aic7xxx funcs without return values
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 8 Mar 2001 11:56:32 +0000 (GMT)
Cc: jamagallon@able.es (J . A . Magallon),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <200103080053.f280rpO33821@aslan.scsiguy.com> from "Justin T. Gibbs" at Mar 07, 2001 05:53:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14az23-0002ot-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They don't return a value because doing so is meaningless.  You aren't
> going to get past the panic.  The compiler should know that assuming
> panic is properly tagged as a function that cannot return.
> 
> You may also want to check up on your C since having a break after
> a return is, well, kinda silly.  In all the usage of this inline, the
> width is constant, so gcc should completely optimize away the switch
> and surrounding code.

Yep.

The bigger problem with that driver for pedants is that it contains globals with
names like 'hard_error' which are asking for clashes . Bizarrely all
the static functions are carefully named ahc_* and the globals are called
things like 'restart_squencer'

The EISA probe code is also horrible, but thats not Justin's fault. Someone
needs to put some eisa_* bus functions into the kernel for that and some
of the other drivers.



