Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261873AbSI3BAS>; Sun, 29 Sep 2002 21:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261878AbSI3BAR>; Sun, 29 Sep 2002 21:00:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52363 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261873AbSI3A7z>;
	Sun, 29 Sep 2002 20:59:55 -0400
Date: Sun, 29 Sep 2002 18:07:16 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: cwhmlist@bellsouth.net
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 oops
In-Reply-To: <20020930005203.GUNU26495.imf20bis.bellsouth.net@localhost>
Message-ID: <Pine.LNX.4.44.0209291803090.18550-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Sep 2002 cwhmlist@bellsouth.net wrote:

> I am having a 2.5.39 oops on boot up.  Here is what I have been able to gleen from the bootstrap screen:
> 
> printing eip:
> c0218f17
> *pde = 00000000
> Oops: 0002
> 
> CPU: 1
> EIP: 0060:[<c0218f17>] Not tainted
> EFLAGS: 00010282
> EIP is at attach+0x63/0xb8
> eax: c13a409c ebx: c03e4650 ecx: 00000000 edx: c03f0b68
> esi: c13a4084 edi: c03e4650 ebp: 00000000 esp: c13dff84
> ds: 0068 es: 0068 ss 0068
> Process swapper (pid: 1, threadinfo=c13de000 task=c13e0080)
> Stack: 00000000 c13a408c c0219027 c13a4084 c13a4084 c02193ab c13a4084 c13a4084
>        c128aa4c c03f09c0 c128aa0c 00000001 c0416cb0 c13a4084 c04234e0 00000000
>        00000000 00000000 c128aa4c 00000000 c0402866 c13de000 c040288c c0105101
> Call Trace:
>  [<c0219027>device_attach+0x33/0x3c
>  [<c02193ab>device_register+0x173/0x260
>  [<c0105101>init+0x75/0x214
>  [<c010508c>init+0x0/0x214
>  [<c01055a1>kernel_thread_helper+ox5/0xc


There is a bug involving isapnp devices. A band-aid patch is available 
here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103331915631837&w=2

Please try that until I can look into a better solution..

Thanks,

	-pat

