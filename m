Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289170AbSA1ItJ>; Mon, 28 Jan 2002 03:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289171AbSA1Is7>; Mon, 28 Jan 2002 03:48:59 -0500
Received: from [195.66.192.167] ([195.66.192.167]:43787 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289170AbSA1Iso>; Mon, 28 Jan 2002 03:48:44 -0500
Message-Id: <200201280846.g0S8k1E22015@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alex Davis <alex14641@yahoo.com>
Subject: Re: I've stopped the 'Spurious interrupts on IRQ7'
Date: Mon, 28 Jan 2002 10:46:02 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020128083726.83324.qmail@web9205.mail.yahoo.com>
In-Reply-To: <20020128083726.83324.qmail@web9205.mail.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 January 2002 06:37, Alex Davis wrote:
> I added the following line to /etc/lilo.conf
>
> append = "parport=0x378,7"
>
> and re-ran lilo. I also noticed that the 'ERR' field in
> /proc/interrupts stays at 0, whereas before the mod it
> was increasing.

Do you have a printer? Try to boot while it is powered off.
WHAT is generating irq 7 now?

It is documented that interrupt controller will report irq 7 if it sees irq 
but cannot determine what device sends it. That's exactly what's happening 
when you see "spurious int" message.

You made kernel believe it's from printer. That does not cure the real 
problem. BTW, there's not much of a problem, kernel just ignores spurious 
interrupts. It _is_ a problem if you see 'ERR' number rapidly increasing.
--
vda
