Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131894AbRAZSdO>; Fri, 26 Jan 2001 13:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136424AbRAZSdE>; Fri, 26 Jan 2001 13:33:04 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:22544 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131894AbRAZScr>; Fri, 26 Jan 2001 13:32:47 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <200101261753.JAA11559@adam.yggdrasil.com>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 26 Jan 2001 18:32:42 +0000
In-Reply-To: <200101261753.JAA11559@adam.yggdrasil.com> ("Adam J. Richter"'s message of "Fri, 26 Jan 2001 09:53:49 -0800")
Message-ID: <m2k87inoz9.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> 	I am surprised that anyone is seriously considering denying
> service to sites that do not implement an _experimental_ facility
> and have firewalls that try to play things safe by dropping packets
> which have 1's in bit positions that in the RFC "must be zero."

Nobody is suggesting requiring other sites to *implement* ECN. If
these sites either ignore the ECN bits or set them to 0, then there is
no problem - an ECN capable system will still interwork fine. The
problem is that they do not tolerate the fact that we are using the
experimental facility and block connections when we indicate our
willingness to use this facility. 

The RFC does *not* say that these bits must be checked for zero. What
it states (as least as I read it) is that the bits are reserved for a
use not defined at the time the RFC (793) was written and that until
such time as the usage of these bits is defined (which ECN now has)
implementations must *set* the bits to zero so as not to confuse which
do use these bits (for the at the time unknown, but now defined,
purpose). Therefore the instruction is "until such time as these bits
are defined, they must be set to zero in outgoing packets". 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
