Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946542AbWKJMmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946542AbWKJMmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946544AbWKJMmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:42:52 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:60663 "HELO pxy2nd.nifty.com")
	by vger.kernel.org with SMTP id S1946542AbWKJMmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:42:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=nifty.com;
  b=Rq5AMyYchTQZi8NXc62oV2u3tJr3osVkGaJpjWrM1A9/UXsJI7Fmqv1RKpsFEaPQi8y2w+iUvhBHOSGAsBKuDQ==  ;
Message-ID: <11940937.327381163162570124.komurojun-mbn@nifty.com>
Date: Fri, 10 Nov 2006 21:42:50 +0900 (JST)
From: Komuro <komurojun-mbn@nifty.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Re: 2.6.19-rc5: known regressions :SMP kernel can not generate ISA irq
Cc: tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com
In-Reply-To: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: @nifty Webmail 2.0
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
 <1162985578.8335.12.camel@localhost.localdomain>
 <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>  <20061108085235.GT4729@stusta.de>
 <7813413.118221162987983254.komurojun-mbn@nifty.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Intel ISA PCIC probe: 
>>   Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
>>     host opts [0]: none
>>     host opts [1]: none
>>     ISA irqs (scanned) = 3,4,5,7,9,11,15 status change on irq 15
>
>This definitely means that the IRQ subsystem works, at least here. That 
>"scanned" means that the PCMCIA driver actually tested those interrupts, 
>and they worked.
>
>At that point, at least.
>
>Of course, the "they worked" test is fairly simple, so it's by no means 
>foolproof, but in general, it does sound like it all really should be ok.
>
>
>But testing 2.6.19-rc5 is still worth it. The APIC fixes might fix it, or 
>some other changes might.
>
>		Linus

I tried the 2.6.19-rc5,  the problem still happens.

But,
I remove the disable_irq_nosync() , enable_irq()
from the linux/drivers/net/pcmcia/axnet_cs.c
the interrupt is generated properly.

So I think enable_irq does not enable the irq.

Thanks!

Best Regards
Komuro



