Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269002AbRHCNDc>; Fri, 3 Aug 2001 09:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHCNDW>; Fri, 3 Aug 2001 09:03:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:57984 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269002AbRHCNDI>; Fri, 3 Aug 2001 09:03:08 -0400
Date: Fri, 3 Aug 2001 09:03:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Frank Torres <frank@ingecom.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate console output to a RS232C and keep keyb where it is
In-Reply-To: <014101c11c17$a6dd21a0$66011ec0@frank>
Message-ID: <Pine.LNX.3.95.1010803085542.16919A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Frank Torres wrote:
> 
> The RS232C is a serial port with 12V and there I have a BA63 20x4 display
> connected. (info worldwide)
> It is setted with the right speed, parity, etc. I use echo whatever
> >/dev/ttyS2 and it works.

It has probably been set okay after boot by `setserial` in some boot 
script.

> If I use the command line parameter everybody says:  (odd and 8 data bits is
> what I use)
>             serial=2,9600o8
>             console=ttyS2,9600o8 console=tty0

This is not valid. You cannot reasonably have parity and 8 bits. One
of them has to go. Either use 8 bits and no parity or 7 bits with
parity.

This is because there are 10 bits/baud. The "stop" bit is a timing
interval equal to one of these bits, between characters. Therefore, you
can have many stop bits, this just spaces the characters.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


