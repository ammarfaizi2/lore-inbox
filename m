Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289115AbSA3OPb>; Wed, 30 Jan 2002 09:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSA3OPV>; Wed, 30 Jan 2002 09:15:21 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:64405 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289115AbSA3OPP>; Wed, 30 Jan 2002 09:15:15 -0500
Date: Wed, 30 Jan 2002 16:05:49 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Michel Angelo da Silva Pereira <michelpereira@uol.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.18-pre3-ac2 with Intel ServerRAID Controller
In-Reply-To: <20020130113337.A2140@josephine.e-mail4you.com.br>
Message-ID: <Pine.LNX.4.44.0201301602510.2726-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Michel Angelo da Silva Pereira wrote:

> 
> 	Here is what I got on /var/log/messages
> 
> Jan 30 10:27:21 servmail kernel: Loading Adaptec I2O RAID: Version 2.4 Build 5
> Jan 30 10:27:21 servmail kernel: Detecting Adaptec I2O RAID controllers...

Could you send an lspci listing as well... Looks like the dpt i2o probe 
didn't find a supported card.

> Jan 30 10:27:39 servmail kernel: Linux I2O PCI support (c) 1999 Red Hat Software.
> Jan 30 10:27:39 servmail kernel: I2O Core - (C) Copyright 1999 Red Hat Software

> And here is the Oops
> 
> CPU:1
> EIP:0010:[<fcc40243>] not tained
> EFLAGS: 00010046
> 
> EAX: 0000001d EBX: 03f686d0 ECX: f232a000 EDX: 00000001 ESI: c3f686d0
> EDI: 00000000 EBP: f236ad60 ESP: c1b75ef4
> DS: 0018    ES: 0018  SS: 0018
> 
> process swapper (pid:0, stackpage=c1b75000)
> 
> stack: 31d4cd00 f236ad60 00000020 00000016 f236ad013 0b000020 00000000
>        f8c33f79 fcc415f4 f236ad60 f1d4cd00 f1ddddf80 04000001 f8c3112c
>        f236ad60 c01086c4 00000016 f236ad60 c1b75f7c c032fde0 c0305ac0
>        00000016 c1b75f74 c01088b6
> 
> call trace: [<f8c33f79>] [<fcc415f4>] [<f8c3112c>] [<c01086c4>]
>             [<c01088b6>] [<c01053c0>] [<c01053c0>] [<c01053c0>]
>             [<c01053ec>] [<c0105452>] [<cd117298>] [<c01171a3>]
> 
> code: 8b 47 24 5d 68 c2 0e c4 fc e8 3f 63 4d c3 83 c4 08 fa f0 fe

Could you run this through ksymoops and send the decoded oops + trace, man 
ksymoops has lots of information on how to best do this.

Regards,
	Zwane Mwaikambo


