Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310151AbSCFToh>; Wed, 6 Mar 2002 14:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310149AbSCFToT>; Wed, 6 Mar 2002 14:44:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24448 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292685AbSCFToO>; Wed, 6 Mar 2002 14:44:14 -0500
Date: Wed, 6 Mar 2002 14:44:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dario Bahena Tapia <dario.bahena@correo.unam.mx>
cc: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: getting process i/o wasted time ...
In-Reply-To: <200203061911.g26JB5e01303@est196.fciencias.unam.mx>
Message-ID: <Pine.LNX.3.95.1020306144031.13735A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Dario Bahena Tapia wrote:

> Hi linux hackers ...
> 
> I'd like to know, if there's a way to get the ammount of time wasted by a
> process, while it was making i/o. I've seen that the rusage
> makes available the ammount of i/o blocks, but I'm thinking in something
> like:
> 
>           process warawara ...
>           time wasted in disks i/o .... XXX
>           time wasted in net i/o   .... XXX
>           etc. ???
> 
> Doest it makes sense? it could be done in linux?
> 
> I supposed ,that I can insert some system calls in the right places
> in the program to make this... but I'm interested in a non-intrusive
> method ...
> 
> Thanks in advance
> 
> saludos
> dario estepario ...

Time for I/O is not generally "wasted" as you say. It is given to
other tasks. Of course if there are no other tasks that want the
CPU then, I guess, you could call it wasted.

You can measure the time from when you make a system call to
the time your code gets control back. There are several
high-resolution (rdtsc) and low resolution (gettimeofday) ways
to do this. 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

