Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbQKBDDD>; Wed, 1 Nov 2000 22:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbQKBDCx>; Wed, 1 Nov 2000 22:02:53 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:15503 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S130614AbQKBDCm>;
	Wed, 1 Nov 2000 22:02:42 -0500
Date: Wed, 1 Nov 2000 22:02:26 -0500
Message-Id: <200011020302.WAA21358@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: tytso@MIT.EDU
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Jakub Jelinek <jakub@redhat.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
In-Reply-To: tytso@MIT.EDU's message of Wed, 1 Nov 2000 09:46:19 -0500,
	<20001101094619.A15283@trampoline.thunk.org>
Subject: Re: 2.4.0-test10-pre6: Use of abs()
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Wed, 1 Nov 2000 09:46:19 -0500
   From: tytso@MIT.EDU

   On Mon, Oct 30, 2000 at 05:14:34PM +0100, Martin Dalecki wrote:
   > Of corse right! BTW. There are tons of places where log2 is calculated
   > explicitly in kernel which should be replaced with the corresponding
   > built 
   > in functions as well (/dev/random code does it). And then If I remember
   > correctly
   > there is an attribute which is telling about internal functions
   > in declarations explicitly as well?


And in the case of /dev/random, since we know something about what the
possible inputs can be, I'm fairly certain that the "int_ln_12bits" used
by /dev/random is probably far better than the general purpose code
which GCC no doubt has to emit....

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
