Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130704AbQKJADf>; Thu, 9 Nov 2000 19:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130735AbQKJADZ>; Thu, 9 Nov 2000 19:03:25 -0500
Received: from quechua.inka.de ([212.227.14.2]:14636 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130704AbQKJADJ>;
	Thu, 9 Nov 2000 19:03:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Module open() problems, Linux 2.4.0
In-Reply-To: <Pine.LNX.3.95.1001109154744.16836A-100000@chaos.analogic.com> <200011092105.WAA06502@ns.caldera.de>
Organization: private Linux site, southern Germany
Date: Fri, 10 Nov 2000 01:01:18 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E13u1dA-0005q2-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I suppose. Look at what you just stated! This means that a reported
> > value is now worthless.
>
> Correct.  And it was always worthless.

Right. The module "use count" is not a use count, it's a lock count.

E.g. a driver may well increase this counter on open and then again
when in a particular ioctl routine, if this situation isn't already
locked right by the kernel. This can happen when a driver has more
than one access point from user space, look at slip_open() in slip.c
from 2.2.

> It's the same de-facto standard as bogo-mips ~= CPU MHz.  It was so,
> but it was neither intended nor documented so.

Remember the Landmark Test and those silly CPU-speed displays
configured to show "Landmark MHz"? :-)

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
