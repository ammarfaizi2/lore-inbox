Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132045AbRDFQnK>; Fri, 6 Apr 2001 12:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRDFQmu>; Fri, 6 Apr 2001 12:42:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131990AbRDFQms>; Fri, 6 Apr 2001 12:42:48 -0400
Date: Fri, 6 Apr 2001 12:41:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Norbert Preining <preining@logic.at>
cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc oopses with 2.4.3
In-Reply-To: <20010406183303.A20867@alpha.logic.tuwien.ac.at>
Message-ID: <Pine.LNX.3.95.1010406124016.5189A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Norbert Preining wrote:

> On Fre, 06 Apr 2001, Chris Mason wrote:
> > sigbus from gcc usually points to the ram, have you run a tester?
> 
> But sig 4 is sigill (whatever this may be) and 1ig11 sigsegv, so
> no sigbus!?
> 
> BTW: The last lines of a kernel compile:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o tcp_output.o tcp_output.c
> gcc: Internal compiler error: program cc1 got fatal signal 11
> make[3]: *** [tcp_output.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.3-ac3/net/ipv4'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.3-ac3/net/ipv4'
> make[1]: *** [_subdir_ipv4] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.3-ac3/net'
> make: *** [_dir_net] Error 2
> 
> Best wishes
> 
> Norbert

SIGSEGV, still looks like a bad RAM simptom. Think linked-list, bad
pointer.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


