Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270105AbRHGGpy>; Tue, 7 Aug 2001 02:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270103AbRHGGpe>; Tue, 7 Aug 2001 02:45:34 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:27264 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S270099AbRHGGp0>;
	Tue, 7 Aug 2001 02:45:26 -0400
Date: Mon, 6 Aug 2001 23:45:33 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: John Polyakov <johnpol@2ka.mipt.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <200108070624.f776Ofl21096@www.2ka.mipt.ru>
Message-ID: <Pine.LNX.4.33.0108062338130.5491-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm, let us suppose, that i copy your crypted partition per bit to my
> disk.
> After it I will disassemble your decrypt programm and will find a key....
>
> In any case, if anyone have crypted data, he MUST decrypt them.
> And for it he MUST have some key.
> If this is a software key, it MUST NOT be encrypted( it's obviously,
> becouse in other case, what will decrypt this key?) and anyone, who have
> PHYSICAL access to the machine, can get this key.
> Am I wrong?

I think the point you are missing is that encrypted swap only needs to be
accessible for one power cycle.  Thus the computer can generate a key at
swapon using a cryptographically strong random number source.  The key is
kept in RAM.  When the computer powercycles again, the old key is lost
from RAM, and a new key is generated.  The old key, and thus the old
encrypted contents of swap, are permenently lost.

-Ryan

