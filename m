Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264850AbSJaLUw>; Thu, 31 Oct 2002 06:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSJaLUw>; Thu, 31 Oct 2002 06:20:52 -0500
Received: from mail.scram.de ([195.226.127.117]:27333 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S264850AbSJaLUw>;
	Thu, 31 Oct 2002 06:20:52 -0500
Date: Thu, 31 Oct 2002 12:21:30 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
In-Reply-To: <Pine.LNX.4.44.0210311138490.7997-100000@gfrw1044.bocc.de>
Message-ID: <Pine.LNX.4.44.0210311220260.7997-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 31 Oct 2002, Jochen Friedrich wrote:

> 2.4.45 compile on Alpha fails:

the old patch from Ivan Kokshaysky <ink@jurassic.park.msu.ru> fixed this,
but then i hit the next one:

  gcc -Wp,-MD,drivers/char/.eventpoll.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=eventpoll
-DEXPORT_SYMTAB  -c -o drivers/char/eventpoll.o drivers/char/eventpoll.c
drivers/char/eventpoll.c:226: warning: initialization from incompatible
pointer type
drivers/char/eventpoll.c: In function `write_eventpoll':
drivers/char/eventpoll.c:993: `POLLREMOVE' undeclared (first use in this
function)
drivers/char/eventpoll.c:993: (Each undeclared identifier is reported only
once
drivers/char/eventpoll.c:993: for each function it appears in.)
drivers/char/eventpoll.c: In function `ep_poll':
drivers/char/eventpoll.c:1056: warning: comparison is always false due to
limited range of data type
make[2]: *** [drivers/char/eventpoll.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

--jochen

