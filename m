Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131242AbQKYVh5>; Sat, 25 Nov 2000 16:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131222AbQKYVhr>; Sat, 25 Nov 2000 16:37:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2823 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S131046AbQKYVhe>;
        Sat, 25 Nov 2000 16:37:34 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011252107.VAA02744@raistlin.arm.linux.org.uk>
Subject: Re: [PATCH] removal of "static foo = 0"
To: aeb@veritas.com (Andries Brouwer)
Date: Sat, 25 Nov 2000 21:07:08 +0000 (GMT)
Cc: rusty@linuxcare.com.au, tigran@veritas.com, linux-kernel@vger.kernel.org,
        Andries.Brouwer@cwi.nl
In-Reply-To: <20001125211939.A6883@veritas.com> from "Andries Brouwer" at Nov 25, 2000 09:19:39 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer writes:
> What a strange reaction. If I write
> 
>  static int foo;
> 
> this means that foo is a variable, local to the present compilation unit,
> whose initial value is irrelevant because it will be assigned to before use.

Wrong.  The initial value is well-defined.  Go and read any C standard you
choose.  Any C standard you care.  You will find out something really
interesting.  I can guarantee that you will find out that it will be
initialised to zero.  Unconditionally.  No question.  Absolutely.

> It is a bad programming habit to depend on this zero initialization.

Why?  Again, it is WELL defined, and is WELL defined in any C standard.

> Indeed, very often, when you have a program that does something
> you need to change it so that it does that thing a number of times.
> Well, put a for- or while-loop around it. But wait! The second time
> through the loop certain variables need to be reinitialized. Which ones?
> The ones that were initialized explicitly in your first program.
> Make the program into a function in a larger one. Same story.

Your point here is as clear as mud.

> If it is your intention to destabilize then you need not read the following.
> But let us assume that you try to make a perfect system.

There is absolutely NO destabilisation going on here.  Get a grip, read the
C standards, read the C startup code.  Then come back with something more
relevent.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
