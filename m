Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314547AbSEBOcD>; Thu, 2 May 2002 10:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSEBOcC>; Thu, 2 May 2002 10:32:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34436 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314545AbSEBOb6>; Thu, 2 May 2002 10:31:58 -0400
Date: Thu, 2 May 2002 10:34:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "antonelloderosa@inwind.it" <antonelloderosa@inwind.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: Controlling the serial port at kernel level
In-Reply-To: <GVHJF8$22E1DB45CCF0A82248ED8BF5C4871821@inwind.it>
Message-ID: <Pine.LNX.3.95.1020502102019.14365A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, antonelloderosa@inwind.it wrote:

> Hallo,
> I would find the way of controlling the serial port at kernel
> level; more precisely I want to set the DTR or RTS pin of the serial
> port whenever my host send or receive an udp packet. 
> 
> Can you help me?
> 
> Please answer me as soon as possible!!!
> 
> Thanks a lot !!

If this is just a hack and you don't care if it screws up
somebody else using the UART, just....

#define BASE 0x3f8  // For first UART
#define MCR 0x3fc
#define DTR 0x01
#define RTS 0x02

... read/write directly to the MCR port, saving the bits you don't
want to change... You use the outb(value, port); and inb(port);
instructions for ports.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

