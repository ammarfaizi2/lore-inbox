Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264131AbRFMQzb>; Wed, 13 Jun 2001 12:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264139AbRFMQzV>; Wed, 13 Jun 2001 12:55:21 -0400
Received: from www.transvirtual.com ([206.14.214.140]:17936 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S264131AbRFMQzI> convert rfc822-to-8bit; Wed, 13 Jun 2001 12:55:08 -0400
Date: Wed, 13 Jun 2001 09:54:21 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene.rebe@gmx.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Ademar de Souza Reis Jr." <ademar@conectiva.com.br>,
        Rolf Schillinger <rolf@sir-wum.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: sis630 - help needed debugging in the kernel
In-Reply-To: <20010613172320.306d5208.rene.rebe@gmx.net>
Message-ID: <Pine.LNX.4.10.10106130952590.16375-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I currently try to debug why the sisfb driver crashes my machine. (SIS 630
> based laptop - linux-2.4.5-ac13).

You can do one of two things. Post both System.map and the complete oops
or you can run ksymoops on the oops. I can find the problem then. Thanks.

> On my serial-console I get:
> [...]
> sisfb: framebuffer at 0xe0000000, mapped to 0xcb800000, size 16384k
> sisfb: MMIO at 0xefce0000, mapped to 0xcc801000, size 128k
> sisfb: encountered LCD # debug output by me
> sisfb: fall back to 1024x768 # debug ouput by me
> sisfb: LCD mode # debug output by me
> sisfb: mode is 800x600x8, linelength=800
> [...]
> Unable to handle kernel paging request at virtual address cc800180
> [oops]
> 
> This happens in the method: register_framebuffer called from sisfb_init.
> 
> I compared the sisfb_init with other framebuffer drivers and can't find what is wrong.
> (I normally don't do kernel hacking...). What does the kernel try to do with the
> _io-memory_, mapped around line 2230 in sis_main.c? - Must the memory reqeuested or
> mapped in an other way?
> 
> Another strange thing is, that the code seems to work for some people ...
> 
> I would be nice if anyone could give me a hint - because the sis-drivers (kernel and X)
> doesn't work for many people ...
> 
> k33p h4ck1n6 René
> 
> -- 
> René Rebe (Registered Linux user: #127875)
> http://www.rene.rebe.myokay.net/
> -Germany-
> 
> Anyone sending unwanted advertising e-mail to this address will be charged
> $25 for network traffic and computing time. By extracting my address from
> this message or its header, you agree to these terms.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

