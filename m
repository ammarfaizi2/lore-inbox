Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318250AbSIKAfK>; Tue, 10 Sep 2002 20:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSIKAeh>; Tue, 10 Sep 2002 20:34:37 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:26102
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318250AbSIKAdz>; Tue, 10 Sep 2002 20:33:55 -0400
Subject: Re: Linux 2.4.20-pre6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@fs.tum.de>
In-Reply-To: <20020910231424.GA30612@bougret.hpl.hp.com>
References: <20020910231424.GA30612@bougret.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 11 Sep 2002 01:41:51 +0100
Message-Id: <1031704911.2726.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 00:14, Jean Tourrilhes wrote:
> > This adds the use of TIOCM_MODEM_BITS to irtty.c but not the corresponding
> > addition of it to asm-i386/termios.h:
> 
> 	I would personally would have veto'ed that change, because it
> will work only on i386 (and PA-Risc), whereas the IrDA stack is
> routinely used on ARM and PPC and also work on Alpha.

The change got it by accident

> 	I would personally perfer the header to define a "default"
> value, and only the broken architecture would need to override it
> (#undef + #define).

absolutely

> 	So, as people like quick'n'dirty hacks, just make sure that
> TIOCM_MODEM_BITS is also defined in ARM, SH, PPC and Alpha (at least),
> just to make sure I'm the only one complaining.

They are in my tree.

