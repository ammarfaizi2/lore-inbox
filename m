Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbRBVSW7>; Thu, 22 Feb 2001 13:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbRBVSWu>; Thu, 22 Feb 2001 13:22:50 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:65276 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S130510AbRBVSWh>;
	Thu, 22 Feb 2001 13:22:37 -0500
Date: Thu, 22 Feb 2001 16:25:25 -0300 (EST)
From: Fernando Fuganti <fuganti@conectiva.com.br>
To: Marcus Ramos <marcus@ansp.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Building a new module from an existing one
In-Reply-To: <3A95470B.E273C637@ansp.br>
Message-ID: <Pine.LNX.4.21.0102221621370.991-100000@ze.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Feb 2001, Marcus Ramos wrote:

> Hello,
> 
> I plan to make a few changes to 3c90x.c (Ethhernet driver) located at
> /usr/src/linux-2.2.16/drivers/net, in RH7. Since the correspondent
> object file 3c90x.o resides in /lib/modules/2.2.16-20/net, I ask: how
> shall I proceed in order to have the C file properly compiled and placed
> in the right place, so that the modified version replaces the previous
> one after system boot up ?

after you compile it with something like this command line
gcc -c 3c90x.c -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer \
    -fno-strength-reduce -pipe -m486 -malign-loops=2 \
    -malign-jumps=2 -malign-functions=2 -DCPU=486 -DMODULE -D__KERNEL__

just copy the generated 3c90x.o to /lib/modules/2.2.16-20/net, overwriting
the old 3c90x.o (made a backup if you wish)



Fernando Fuganti


