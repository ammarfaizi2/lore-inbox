Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292930AbSB0WUy>; Wed, 27 Feb 2002 17:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292994AbSB0WU2>; Wed, 27 Feb 2002 17:20:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61326 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292993AbSB0WUQ>; Wed, 27 Feb 2002 17:20:16 -0500
Date: Wed, 27 Feb 2002 17:23:41 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Allo! Allo! <lachinois@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel module ethics.
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com>
Message-ID: <Pine.LNX.3.95.1020227164752.16918A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Allo! Allo! wrote:

> Hi,
> 
> The company for whom I work wants to make a linux driver for some of its 
> hardware. On my side I would like the driver to be completely open sourced, 
> and from a customer point of view, its a big plus (a real PITA to maintain 
> closed sourced drivers). On the other hand, the company wants a clear way to 
> make "profit" from the work while still catering to it's customers whish to 
> recompile the driver for just about any kernel version.

[SNIPPED...]

I've thought about this and think that "Open Source" is not "Free
Software". If I purchase some sheet music it has a copyright notice
that basically implies that I can play this all I want. I can even
make money playing this at a bar. What I can't do is claim that
it's my own composition. I can't copy it and put my own name on the
chart as the author. However, I can certainly play or even write
my own "Variations on the Theme of ..." and claim that the variations
are my own.

The same should be true of any software (sheet music is software for
machines called instruments). I should be able to write a module
under GPL and, in a separate file, provide the source code with its
proprietary notice and proprietary copyright notice.

But what happens then is, since its published, it's no longer "trade
secret". You can't keep something secret by publishing it. So your
company loses its claim to the software as trade secret, but not its
claim against somebody copying it and calling it their own.

Unfortunately, the whole reason for software copyright is to maintain
trade secrets. The company pays you and others, what it thinks is
an enormous amount of money, and they don't expect you to give away
all that expense, especially to competitors.

In fact, hardware designs that took several million dollars of NRE to
develop, can be compromised if the source code necessary to manipulate
it becomes available to competitors. A competitor doesn't have to spend
a million dollars. Instead, they just buy the product like any other
customer. The PWB shows how to build it, and the software shows how to
run it. For a few thousand dollars, they could be selling your product
to your potential customers, and you lose your job.

So, enter the compromise. Make your proprietary stuff in separate file(s)
known only to your company. This keeps them trade secret. Compile them
into a library. Provide that library with your module. The functions
contained within that library should be documented as well as the
calling parameters (a header file). This helps GPL maintainers
determine if your library is broken.

The main module code is GPL and it is linked with your proprietary
library. If you have a customer that requires access to the trade-secret
source-code, you have them sign a standard NDA so the lawyers can kill
them if necessary, in the courts of course!

That said, there may be responses from others who say; "No you can't
do that!" The FSF makes free software, etc. I won't be responding
to those because I understand that nothing I do at work is free.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

