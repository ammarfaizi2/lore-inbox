Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269386AbRHCOu1>; Fri, 3 Aug 2001 10:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269234AbRHCOuS>; Fri, 3 Aug 2001 10:50:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269390AbRHCOuE>; Fri, 3 Aug 2001 10:50:04 -0400
Date: Fri, 3 Aug 2001 10:50:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Frank Torres <frank@ingecom.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate console output to a RS232C and keep keyb where it is
In-Reply-To: <018201c11c24$cd2af730$66011ec0@frank>
Message-ID: <Pine.LNX.3.95.1010803104534.343A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Frank Torres wrote:
> 
> Richard:
> I must tell you I am the one who sets the speed, IRQ and the rest of the
> parameters of the serial port in an /etc/rc.serial built by me only with the
> settings I need. The original rc.serial was producing some error when
> executed by rc.sysinit (kern. 2.4.2-2)
> I have to configure ttyS2 with both, setserial and stty, 'cause of the
> parity and the stop bit, etc.
> I tested the following configurations:
>     8, no parity, stop b.
>     8, no parity, no stop b.
>     7, parity on, parity odd, stop b.
>     7, no parity, no stop b.
> All showed wrong or no characters in the display. It only worked with 8,
> parity on, parity odd, stop b. (also with no stop b.)
> The Linux is installed in a Beetle/M POS.
> Perhaps it can't be done? I mean to obtain the video through the serial port
> without modifying the normal keyb entry?
> Thanx
> 

This works fine here (in /etc/lilo.conf):

 append  = "console=ttyS1,9600"       # RS-232C output
 append  = "console=null"             # (no log output)


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


