Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290054AbSAQRCe>; Thu, 17 Jan 2002 12:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290051AbSAQRCY>; Thu, 17 Jan 2002 12:02:24 -0500
Received: from ligsg2.epfl.ch ([128.178.78.4]:41771 "HELO ligsg2.epfl.ch")
	by vger.kernel.org with SMTP id <S290048AbSAQRCN>;
	Thu, 17 Jan 2002 12:02:13 -0500
Message-Id: <m16RFvW-02103HC@ligsg2.epfl.ch>
Content-Type: text/plain; charset=US-ASCII
From: Jan Ciger <jan.ciger@epfl.ch>
Reply-To: jan.ciger@epfl.ch
Organization: EPFL
To: frode <frode@freenix.no>
Subject: Re: 2.4.17 oops, again ("kernel BUG at page_alloc.c:76!")
Date: Thu, 17 Jan 2002 18:02:08 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3C46FC88.2050906@freenix.no>
In-Reply-To: <3C46FC88.2050906@freenix.no>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

  I have these strange spurious interrupts with 2.4.17 + low latency patch 
too on PII 450 with 256 MB RAM. No oopses yet, but when I try to burn CD's, 
my PS/2 mouse starts to act funny (jumps all over the screen under XFree) and 
the burner usually burns garbage (=unreadable CD's). Seems like some IRQ 
conflict to me, but according to /proc/interrupts, there is none. BTW, 
enabling or disabling the low latency patch via /proc makes no difference. 

I can send more info if needed. 

Jan



On Thursday 17 January 2002 17:32, frode wrote:
> I got this oops yesterday, on a 2.4.17 kernel on a k7 750 with 384mb ram
> and 160mb swap. It took down XFree but I could still run programs on the
> VT, so I attach the output of 'dmesg | ksymoops', 'free', 'lspci' and
> 'lsmod'. If anyone's interested, I can mail the .config file as well.
>
> I've had a lot of oopses on 2.4.17 lately; see for example
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.1/1628.html.
>
> The kernel is tainted because of the nvidia NVdriver module v2313.
> (but even without it loaded I recall getting oopses).
>
> I tried running MemTest86 for about 35 minutes with no errors reported.
>
> By the way, during bootup, i get a "spurious 8259A interrupt: IRQ7."
> kernel message. Sometimes after all services have been started, other times
> just before the initscripts are finished starting everything. It doesn't
> seem to have any effect.. my printer seems to work fine (if lpt1 is related
> to IRQ7..?)
>
> - Frode
