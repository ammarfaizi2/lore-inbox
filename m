Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbQLHC2v>; Thu, 7 Dec 2000 21:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130396AbQLHC2l>; Thu, 7 Dec 2000 21:28:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22144 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129736AbQLHC2c>; Thu, 7 Dec 2000 21:28:32 -0500
Date: Thu, 7 Dec 2000 20:58:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rainer Mager <rmager@vgkk.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com>
Message-ID: <Pine.LNX.3.95.1001207205043.5530A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Rainer Mager wrote:

> Hi all,
> 
> 	I've searched around for a answer to this with no real luck yet. If anyone
> has some ideas I'd be very grateful.

Signal 11 just means that you "seg-faulted". This is usually caused
by a coding error. However, if you have tools (like the C compiler)
that has been running fine, but starts to seg-fault, this points to
the very real possibility of a hardware error.

Modern RAM (with no error correction), running outside of its
timing specifications, is often the culpret. Even power supplies can
cause this problem. All you need is a single-bit error in a pointer's
value and -- signal 11.

Also, a bad opcode fetched from RAM with an error, also traps to
the same handler.

Do:

char main[]={0xff,0xff,0xff,0xff};


Compile and run this (it will compile!). You will see what
bad opcodes will do.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
