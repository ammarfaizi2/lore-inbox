Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbRE3BEk>; Tue, 29 May 2001 21:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262537AbRE3BEb>; Tue, 29 May 2001 21:04:31 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:59115 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262536AbRE3BEX>;
	Tue, 29 May 2001 21:04:23 -0400
Date: Tue, 29 May 2001 18:04:20 -0700
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, tori@unhappy.mine.nu,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
Message-ID: <20010529180420.A14639@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl>; from ankry@green.mif.pg.gda.pl on Wed, May 30, 2001 at 02:48:24AM +0200
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 02:48:24AM +0200, Andrzej Krzysztofowicz wrote:
> 
> The following patch removes some zero initializers from statics
> 
> Andrzej

	If I were you, I would fix gcc rather than making my code
unreadable.

	I write source code in C rather than coding ASM in hex because
of the semantic attached to what I write, which make the code readable
by me and by other, and make my code portable to other environments
(for example user space). Initialisating a variable to zero as opposed
to leaving it undefined has plenty of semantic attached to it.
	It's the job of the compiler to make sure that all this kind
of stupid optimisation are done and the code produced is as efficient
as possible and adapted to the exact characteristics of the operating
envirtonment. Especially that it's probably 10 lines to add the proper
option to gcc command line.

	Therefore, Alan, please do not apply those kind of patches to
my drivers.

	Thanks...

	Jean
