Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbSKAUhU>; Fri, 1 Nov 2002 15:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265774AbSKAUhU>; Fri, 1 Nov 2002 15:37:20 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:54800 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S265773AbSKAUhS>;
	Fri, 1 Nov 2002 15:37:18 -0500
Date: Fri, 1 Nov 2002 21:43:37 +0100
From: romieu@fr.zoreil.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021101214337.A12326@electric-eye.fr.zoreil.com>
References: <20021031181252.GB24027@tapu.f00f.org> <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com> <20021031194351.GA24676@tapu.f00f.org> <apu6cd$4db$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <apu6cd$4db$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Nov 01, 2002 at 03:25:01PM +0000
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> :
[...]
> Maybe not. The only numbers I have is the slowness of PCI.

Issue 'openssl speed' and wait for more numbers.

Short lived hybrid sessions kill (not that this or any of the current 
reasons for asynchronous crypto really matters imho).

Instant benchmark:
                  sign    verify    sign/s verify/s
rsa 1024 bits   0.0148s   0.0008s     67.7   1198.6 (PIV 2GHz)
                  sign    verify    sign/s verify/s
rsa 1024 bits   0.0478s   0.0026s     20.9    381.6 (PII 350MHz)

The 'numbers' are in 1000s of bytes per second processed.
type              8 bytes  64 bytes  256 bytes  1024 bytes  8192 bytes
des ede3         3930.00k  4027.43k   4032.30k    4002.19k    3973.12k (PIV)
type              8 bytes  64 bytes  256 bytes  1024 bytes  8192 bytes
des ede3         1058.51k  1061.25k   1090.70k    1097.44k    1091.36k (PII)

blowfish is ~10x faster btw.

--
Ueimor 
