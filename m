Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315219AbSDWNyN>; Tue, 23 Apr 2002 09:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315220AbSDWNyN>; Tue, 23 Apr 2002 09:54:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35459 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315219AbSDWNyL>; Tue, 23 Apr 2002 09:54:11 -0400
Date: Tue, 23 Apr 2002 09:56:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: gio zanei <il_boba@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: undefined reference to printk()
In-Reply-To: <F236cWcHoWRwE67G7lU00005dc6@hotmail.com>
Message-ID: <Pine.LNX.3.95.1020423095215.16072A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002, gio zanei wrote:

> hi to all,
> i need to compile a small program that i made. WHen i try to do it, it 
> compiles all right with the -c option ( that is i get the .o file), but if i 
> do even the linking it just keep giving me the undefined reference error to 
> some kernel functions that i need to use. In particular are the printk, 
> filp_open, generic_file_read....  I have included the header files that 
> declare them ( kernel.h and fs.h) and i have compiled the program with the 
> -D__KERNEL__ and other option used by the compiler when it wants to compile 
> a module in the kernel. I tried in many different ways but the error in the 
> linking is always the same.
> thank you,
> boba
> 

Stuff compiled to run in the kernel needs to be run in the kernel.
Stuff compiled to run in user-mode needs to be run in user-mode.
None the twain shall meet.

You can't make a 'program' that calls kernel functions. You make
a module and install it. Modules are not linked as user-mode
executables. They remain object files.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

