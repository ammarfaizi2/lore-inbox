Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129437AbQKYWlp>; Sat, 25 Nov 2000 17:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129091AbQKYWlg>; Sat, 25 Nov 2000 17:41:36 -0500
Received: from gondor.apana.org.au ([203.14.152.114]:49423 "EHLO
        gondor.apana.org.au") by vger.kernel.org with ESMTP
        id <S129524AbQKYWl3>; Sat, 25 Nov 2000 17:41:29 -0500
Date: Sun, 26 Nov 2000 09:11:18 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-Id: <200011252211.eAPMBIo21200@gondor.apana.org.au>
To: aeb@veritas.com (Andries Brouwer), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
X-Newsgroups: apana.lists.os.linux.kernel
In-Reply-To: <20001125211939.A6883@veritas.com>
Organization: Core
User-Agent: tin/pre-1.4-980226 (UNIX) (Linux/2.2.17 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aeb@veritas.com> wrote:
>
>  int foo = 0;  /* just for gcc */

> when the initialization in fact is not necessary.

Only for non-static foo.

> It is a bad programming habit to depend on this zero initialization.
> Indeed, very often, when you have a program that does something
> you need to change it so that it does that thing a number of times.
> Well, put a for- or while-loop around it. But wait! The second time
> through the loop certain variables need to be reinitialized. Which ones?
> The ones that were initialized explicitly in your first program.
> Make the program into a function in a larger one. Same story.

Again, this only applies to non-static variables.  For static ones, they're
initialised once only even when they go out of scope.

> Saving a byte in the binary image is not very interesting.
> Preserving information about the program is important.

No information is lost.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
