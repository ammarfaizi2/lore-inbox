Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289924AbSAPNaM>; Wed, 16 Jan 2002 08:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289923AbSAPNaD>; Wed, 16 Jan 2002 08:30:03 -0500
Received: from gw.wizards.com ([209.221.142.132]:25039 "EHLO
	fungusaur.wizards.com") by vger.kernel.org with ESMTP
	id <S289924AbSAPN3u>; Wed, 16 Jan 2002 08:29:50 -0500
Message-Id: <5.1.0.14.0.20020116141606.00a961e0@popmail.libero.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 Jan 2002 14:28:53 +0100
To: Harald Welte <laforge@gnumonks.org>
From: Luca Adesso <ladesso@libero.it>
Subject: Re: iptables and 2.4.17
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020116130317.H30850@sunbeam.de.gnumonks.org>
In-Reply-To: <5.1.0.14.0.20020116115713.00a96ec0@popmail.libero.it>
 <5.1.0.14.0.20020116115713.00a96ec0@popmail.libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13.03 16/01/02 +0100, you wrote:
>On Wed, Jan 16, 2002 at 12:13:11PM +0100, Luca Adesso wrote:
> > There is some problem with iptables modules and kernel 2.4.17 ?
> > I'm using 2.4.10 and it works fine; I tried on another computer at work 
> the
> > 2.4.17 but I got unresolved symbol errors
> > ip_tables.o: unresolved symbol nf_unregister_sockopt
> > ip_tables.o: unresolved symbol nf_register_sockopt
>
>Strange. Are you sure you really did it in the following order:
>make clean (better: make mrproper)
>- configure the kernel
>make bzImage
>- install your new bzImage
>make modules
>make modules_install
>- boot into your new kernel
Sure I always do in the same way!
I go in /usr/src and rm -r linux and rm linux-2.4.5 (the kernel installed 
with Slackware 7.0) then downloaded kernel 2.4.17
make mrproper and reconfigured my kernel.
I create a script to compile the kernel, so I'm sure I do al the same 
everytime.
The script is:
#mkernel begin
#!/bin/sh
make dep && make clean && make bzImage && make modules
make modules_install
cp System.map /boot
cp arch/i386/boot/bzImage /boot
lilo
#mkernel end

>We haven't had any bug report regarding your problem, and I'm personally
>also running plain 2.4.17 on one of my boxes without any problems.
I have problem with iptables.o and with apm.o.
For apm I haven't found help and I never create a working modules so I 
compiled it in the kernel.
I was sure that iptables works like modules and now it's working fine on 
that system with 2.4.16

Any suggestions?

