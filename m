Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290729AbSAYQ5X>; Fri, 25 Jan 2002 11:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290732AbSAYQ5N>; Fri, 25 Jan 2002 11:57:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290726AbSAYQ4n>; Fri, 25 Jan 2002 11:56:43 -0500
Date: Fri, 25 Jan 2002 11:56:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: <simon@baydel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
In-Reply-To: <3C50FBAE.26883.8EF8C@localhost>
Message-ID: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002,  wrote:

> I am writing a module and would like to perform arithmetic on long 
> long variables. When I try to do this the module does not load due
> to the unresolved symbols __udivdi3 and __umoddi3. I notice these
> are normally defined in libc. Is there any way I can do this in a 
> kernel module.
> 
> Many Thanks
> 
> Simon.

Normally, in modules, the granularity is such that divisions can
be made by powers-of-two. In a 32-bit world, the modulus that you
obtain with umoddi3 (the remainder from a long-long, division) should
normally fit within a 32-bit variable. If you insist upon doing 64-bit
math in a 32-bit world, then you can either make your own procedures
and link them, of you can "appropriate" them from the 'C' runtime
library code, include them with your source, assemble, and link them
in.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


