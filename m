Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSBRUGA>; Mon, 18 Feb 2002 15:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBRUFv>; Mon, 18 Feb 2002 15:05:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50305 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S284933AbSBRUFj>; Mon, 18 Feb 2002 15:05:39 -0500
Date: Mon, 18 Feb 2002 15:08:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Xinwen - Fu <xinwenfu@cs.tamu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: weird ip sequence number
In-Reply-To: <Pine.SOL.4.10.10202180439080.14846-100000@dogbert>
Message-ID: <Pine.LNX.3.95.1020218150225.21701B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Xinwen - Fu wrote:

> Hi,
> 	Really weird!
> 
> 	I have two linux machines with kernel 2.4.17. When I ping one
> machine from the other machine, all the ping request ip packets have the
> same sequnce number 0. The ping reply packets have different ip
> sequence numbers. Moreover, when I send udp packets using general
> socket programming, all the udp packets have the same sequence number 0.
> 
> 	I use ethereal to check the packets.
> 
> 	What's the problem?
> 
> 	Thanks!
> 

The sequence numbers for 'ping' come from ping. They are not generated
by the kernel.

`strace` [snipped]
sendto(3, "\10\0\335\360\360T\0\0@^q<\202\34\v\0\10\t\n\v\f\r\16\17"...,
                              |________ sequence NR

sendto(3, "\10\0\237\v\360T\1\0A^q<\277\1\v\0\10\t\n\v\f\r\16\17\20"...,
                            |___________ sequence NR


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


