Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbSLSWJh>; Thu, 19 Dec 2002 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLSWJ3>; Thu, 19 Dec 2002 17:09:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267227AbSLSWJE>; Thu, 19 Dec 2002 17:09:04 -0500
Message-ID: <3E024567.3080806@transmeta.com>
Date: Thu, 19 Dec 2002 14:17:11 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.10.10212170144030.31876-100000@master.linux-ide.org> <1040137976.20018.3.camel@irongate.swansea.linux.org.uk> <20021218235546.GD705@elf.ucw.cz>
In-Reply-To: <20021218235546.GD705@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>
>>Different thing - int 0x80 syscall not i/o port 80. I've done I/O port
>>80 (its very easy), but requires we set up some udelay constants with an
>>initial safety value right at boot (which we should do - we udelay
>>before it is initialised)
> 
> Actually that would be nice -- I have leds on 0x80 too ;-).
> 								Pavel

We have tried before, and failed.  Phoenix uses something like 0xe2, but
apparently some machines with non-Phoenix BIOSes actually use that port.

	-hpa

