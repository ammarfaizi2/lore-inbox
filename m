Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131955AbQKZADm>; Sat, 25 Nov 2000 19:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131975AbQKZADc>; Sat, 25 Nov 2000 19:03:32 -0500
Received: from gondor.apana.org.au ([203.14.152.114]:18192 "EHLO
        gondor.apana.org.au") by vger.kernel.org with ESMTP
        id <S131955AbQKZAD2>; Sat, 25 Nov 2000 19:03:28 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 26 Nov 2000 10:33:10 +1100
To: Andries Brouwer <aeb@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126103310.A21757@gondor.apana.org.au>
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au> <20001125234624.A7049@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001125234624.A7049@veritas.com>; from aeb@veritas.com on Sat, Nov 25, 2000 at 11:46:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 11:46:24PM +0100, Andries Brouwer wrote:
> 
> But if the program
> 
>   static int a = 0;
> 
>   int main() {
> 	  /* do something */
>   }
> 
> is used as part of a larger program, it has to become
> 
>   static int a;
> 
>   int do_something() {
> 	  a = 0;
> 	  ...
>   }

Only if the person doing the change follows this convention, if that happens
to be you, not a problem.  But in a project like Linux, it's not very likely
to happen.

It's much better to put a comment above the definition.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
