Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbTBGTAt>; Fri, 7 Feb 2003 14:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbTBGTAt>; Fri, 7 Feb 2003 14:00:49 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:896 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S266323AbTBGTAs>; Fri, 7 Feb 2003 14:00:48 -0500
Date: Fri, 7 Feb 2003 20:10:17 +0100
To: SA <bullet.train@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt latency k2.4 / i386?
Message-ID: <20030207191017.GB20284@pusa.informat.uv.es>
References: <200302071847.36646.bullet.train@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200302071847.36646.bullet.train@ntlworld.com>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Feb 07, 2003 at 06:47:36PM +0000, SA wrote:
> 
> Dear list,
> 
> What latency should I expect for hardware interrupts under k2.4 / i386 ? 
>
>
> 
> ie how long should it take between the hardware signalling the interrupt and 
> the interrupt handler being called?

I don't know the hardware part but it depends on how long interrupts are
being disabled (and that depend on the code you use in the kernel) and 
that can be measured with akpm's timepeg+intlat patches

http://www.zip.com.au/~akpm/linux/#timepegs

I hope this helps

	Ulisses

> 
> 
> I am wrting a driver which pace IO with interrupts, generating one interrupt 
> for after every transfer is done.  Looking at the hardware schematics the 
> interrupts should occur virtually instantly after each transfer but the 
> driver is waiting ~1ms/ interrupt.  
> 
> I can use polling instead with busy waits but this seems a bit wasteful.
> 
> 
> My interrupt is shared with my graphics card using the non-GPL nvidia driver - 
> could this be responsible for the delay (any experience with this)?
> 
> cat /proc/interrupts
> .....
>  10:       3028          XT-PIC  eth0, VIA 82C686A
>  11:    1117037          XT-PIC  nvidia, PI stage <-- my driver
>  12:      14776          XT-PIC  usb-uhci, usb-uhci
> .....
> 
> Thanks SA
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
