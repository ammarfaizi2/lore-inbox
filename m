Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267211AbSKXM10>; Sun, 24 Nov 2002 07:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267212AbSKXM10>; Sun, 24 Nov 2002 07:27:26 -0500
Received: from pop.gmx.de ([213.165.65.60]:34580 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267211AbSKXM1Z>;
	Sun, 24 Nov 2002 07:27:25 -0500
Message-ID: <3DE0D678.7030504@gmx.net>
Date: Sun, 24 Nov 2002 14:39:04 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: =?ISO-8859-1?Q?Pavel_Jan=EDk?= <Pavel@Janik.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt> <m3fztrcinh.fsf@Janik.cz> <20021124114307.A25408@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sun, Nov 24, 2002 at 12:27:14PM +0100, Pavel Janík wrote:
>  
>
>>I have tried to cat /dev/ttyS5 after
>>
>>setserial /dev/ttyS5 port 0xd800 irq 11
>>    
>>
>
>I think you actually want:
>
>setserial /dev/ttyS5 port 0xd800 irq 11 autoconfig
>
>and then cat /proc/tty/driver/serial and see if the 5: line has changed
>from uart:unknown.
>

Given the fact HT6552IR is a (very old?) ISA Super IO chip with:
    * Support two serial ports.
      Support one printer port with EPP/ECP/SPP function.
    *Parallel Port and Serial Port IO Base Address Select: 
      378, 278, 3BC, 358, 258, 398, 298, 3F8, 2F8, 3E8,
      2E8, 35C, 25C, 2BC, 39C, 29C
    * Seven IRQ selectable (IRQ 3,4,5,7,10,11,12)
    * All port is designed for disable and enable.
it surely is 8250 compatible.

As you have two 8port regions for two serial ports these should be the 
correct locations.



