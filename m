Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRAYA7g>; Wed, 24 Jan 2001 19:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYA71>; Wed, 24 Jan 2001 19:59:27 -0500
Received: from jalon.able.es ([212.97.163.2]:14041 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129441AbRAYA7L>;
	Wed, 24 Jan 2001 19:59:11 -0500
Date: Thu, 25 Jan 2001 01:58:53 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Justin T . Gibbs" <gibbs@scsiguy.com>
Subject: Re: warning in 2.4.1pre10
Message-ID: <20010125015853.A2839@werewolf.able.es>
In-Reply-To: <20010125004454.C930@werewolf.able.es> <20010124184500.B6941@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010124184500.B6941@cadcamlab.org>; from peter@cadcamlab.org on Thu, Jan 25, 2001 at 01:45:00 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.25 Peter Samuelson wrote:
> 
> [J. A. Magallon]
> > It is harmless, 'cause the last sentence in the funtion is a panic,
> > but it is good to add the 'return 0', just to shut up the compiler.
> 
> The correct fix is __attribute__((noreturn)) in the panic() prototype.
> As it happens, this has already been done....
> 

I know Linux will never be compiled with any other thing than gcc. But
what I do not understand is why if there is a standard C way of doing
something you have to use an strange extension of gcc.
Same happens with 'return' and 'break'. You type the same to add a
'/* DO NOT REMEMBER THE PRECISE COMMENT */' to shut up the compiler
instead of just writing
case X:
	...
	return xxx;
	break;

???
Size optimization for the couple of bytes of the jump in return or break ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-pre10 #4 SMP Wed Jan 24 00:20:15 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
