Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRABPiI>; Tue, 2 Jan 2001 10:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRABPh6>; Tue, 2 Jan 2001 10:37:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:55428 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129183AbRABPhq>; Tue, 2 Jan 2001 10:37:46 -0500
Date: Tue, 2 Jan 2001 10:07:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Matthew Galgoci <mgalgoci@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: iopener reboot
In-Reply-To: <20010102095134.A32445@redhat.com>
Message-ID: <Pine.LNX.3.95.1010102100037.11768B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Matthew Galgoci wrote:

> Hi,
> 
> I've gone and tried the ultimate acid test of crappy x86 hardware on the 
> vanilla prerelease kernel, and installed it on my iopener. The kernel 
> loads, uncompresses, initializes hardware, and then immediately reboots.
> 
> It all happens so fast that I do not really get a chance to see the last thing
> printed before it fails.
> 
> The last kernel that I had running on this was a test12 pre something.
> 
> Any ideas?
> 
> --Matt Galgoci
> 

Recompile as 'generic' as you can get. Pretend you have a '486. Use
a known good 'C' compiler even though it may not be 'optimum'. Once
this boots okay, try compiling for a Pentium '586' etc. You may
have found some problem with CPU identification.

A quick hack at the possibility of a BIOS reporting the wrong amount
of memory is to put append="mem=16m" in your LILO config just to
pretend that you only have 16 megabytes of RAM. Assuming you have
more than 16 megabytes, if the machine boots, you have isolated the
problem to bad BIOS reporting.

Step-by-step, using these kinds of tricks, you should be able to
find the problem.

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
