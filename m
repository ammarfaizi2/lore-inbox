Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129820AbRB0Tvv>; Tue, 27 Feb 2001 14:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRB0TvV>; Tue, 27 Feb 2001 14:51:21 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:29973 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129807AbRB0Tua>; Tue, 27 Feb 2001 14:50:30 -0500
Date: Tue, 27 Feb 2001 21:50:15 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Posible bug in gcc
Message-ID: <20010227215015.B14499@niksula.cs.hut.fi>
In-Reply-To: <E14XRyY-0001gE-00@the-village.bc.nu> <Pine.LNX.3.95.1010226130127.5731A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010226130127.5731A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Feb 26, 2001 at 01:02:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 01:02:45PM -0500, you [Richard B. Johnson] claimed:
> 
> Script started on Mon Feb 26 12:54:20 2001
> # gcc -o xxx bug.c
> # ./xxx
> Correct output: 5 2
> GCC output:  5 2
> # gcc --version
> egcs-2.91.66
> # gcc -O2 -o xxx bug.c
> # ./xxx
> Correct output: 5 2
> GCC output:  10 5
> # exit
> exit

Funny:

vherva@babbage:/tmp>/usr/bin/gcc  c.c -o c; ./c ; /usr/bin/gcc --version 
Correct output: 5 2
GCC output:  5 2
2.96
vherva@babbage:/tmp>/usr/bin/gcc -O2 c.c -o c; ./c ; /usr/bin/gcc --version
Correct output: 5 2
GCC output:  10 5
2.96
vherva@babbage:/tmp>/usr/bin/gcc -O6 c.c -o c; ./c ; /usr/bin/gcc --version
Correct output: 5 2
GCC output:  10 5
2.96
vherva@babbage:/tmp>rpm -q gcc
gcc-2.96-74

vherva@babbage:/tmp>kgcc c.c  -o c; ./c ; kgcc --version 
Correct output: 5 2
GCC output:  5 2
egcs-2.91.66
vherva@babbage:/tmp>kgcc c.c -O2 -o c; ./c ; kgcc --version
Correct output: 5 2
GCC output:  10 5
egcs-2.91.66
vherva@babbage:/tmp>kgcc c.c -O6 -o c; ./c ; kgcc --version
Correct output: 5 2
GCC output:  10 5
egcs-2.91.66
vherva@babbage:/tmp>rpm -q kgcc
kgcc-1.1.2-40

vherva@babbage:/tmp>/usr/local/bin/gcc c.c -o c; ./c ;/usr/local/bin/gcc --version    
Correct output: 5 2
GCC output:  5 2
pgcc-2.95.1
vherva@babbage:/tmp>/usr/local/bin/gcc c.c -O2 -o c; ./c ;/usr/local/bin/gcc --version
Correct output: 5 2
GCC output:  5 2
pgcc-2.95.1
vherva@babbage:/tmp>/usr/local/bin/gcc c.c -O6 -o c; ./c ;/usr/local/bin/gcc --version 
Correct output: 5 2
GCC output:  5 2
pgcc-2.95.1

I guess pgcc is not that buggy EVERY time. (Sorry for the off topic post, I
couldn't resist.)


-- v --

v@iki.fi
