Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272187AbRH3M1b>; Thu, 30 Aug 2001 08:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272184AbRH3M1V>; Thu, 30 Aug 2001 08:27:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23682 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272186AbRH3M1F>; Thu, 30 Aug 2001 08:27:05 -0400
Date: Thu, 30 Aug 2001 08:27:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Do-Han Kim <shinywind@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bit field endian vs endian
In-Reply-To: <F206lZz02H67yRLVbND00001b0c@hotmail.com>
Message-ID: <Pine.LNX.3.95.1010830081352.30715A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Do-Han Kim wrote:

> Hello,
> In the linux kernel source tcp.h
> bit field endian is appeared.
> if the machine is the big endian machine, highest bit is alligned in the 
> lowest location in byte?
> 
> Thank you.

Big endian:

Given:  unsigned long = 0xdeadface;
           Low memory <---        ---> High memory

It looks in memory, just like you typed it with your editor.
BUT... The high vs. low bits of the individual bytes are not
changed. In other words, 0xde, the high byte, still has 'd'
as the high nibble and 'e' as the low nibble. Therefore the
MSB of a longword, in big endian format, is truly at the lowest
memory location occupied by that longword.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


