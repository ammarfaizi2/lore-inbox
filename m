Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUDGLQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUDGLQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:16:52 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:2701 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262837AbUDGLQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:16:50 -0400
Date: Wed, 7 Apr 2004 13:16:48 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
In-Reply-To: <20040404120051.GF27362@lug-owl.de>
Message-ID: <Pine.LNX.4.55.0404071304170.5705@jurand.ds.pg.gda.pl>
References: <20040404101241.A10158@flint.arm.linux.org.uk>
 <20040404111712.GE27362@lug-owl.de> <20040404122958.A14991@flint.arm.linux.org.uk>
 <20040404120051.GF27362@lug-owl.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2004, Jan-Benedict Glaw wrote:

> Interrupt setup is a bit tricky on the VAXen. First, they actually have
> separated RX and TX IRQ and these aren't static. IRQ probing needs to be
> redone (at least can't be easily copied) since the new dz_init() is
> basically a complete new rewrite...

 I think we need to separate the chipset driver from the 
implementation-specific details.  There are at least three configurations 
in existence:

1. DECstation on-board serial ports for the 3100 (2100) and the 5000/200 
(there are minor differences which can be handled together, I think).

2. The PMAC-A TURBOchannel board.  This implies up to 24 ports in a single
system if we ever support the DEC 3000/900 (3000/800) Alpha systems; 16
ports otherwise. ;-)

3. VAX-based systems -- you know the details better.

Note the existence of #2 above implies there may be two different kinds of
such ports in a single system, be it a DECstation or a VAXstation (the
4000 series use these ports as well, don't they?).

> Old ./drivers/char/dz.c + VAX changes + SERIO changes, that is :)  I
> guess best practice is that VAX people first merge up with MIPS folks,
> then we snatch the old driver together and have a beer...

 It sounds like a plan. :-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
