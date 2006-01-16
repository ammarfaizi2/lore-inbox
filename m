Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWAPCnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWAPCnq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 21:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWAPCnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 21:43:46 -0500
Received: from outbound01.telus.net ([199.185.220.220]:27779 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S932192AbWAPCnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 21:43:45 -0500
Message-ID: <43CB0A15.7060009@telusplanet.net>
Date: Sun, 15 Jan 2006 19:51:01 -0700
From: Bob Gill <gillb4@telusplanet.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linux kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BTTV broken on recent kernels
References: <43CAFF82.4030500@telusplanet.net> <1137377234.25801.145.camel@mindpipe>
In-Reply-To: <1137377234.25801.145.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Sun, 2006-01-15 at 19:05 -0700, Bob Gill wrote:
>  
>
>>Hi.  The last several kernel versions have led to broken bttv (up to 4 
>>or 5 kernel versions ago, I could watch tv on either mplayer or xawtv), 
>>but lately bttv is broken.  My card is an 'bt878 compatible built by ATI 
>>(ATI TV Wonder VE).  I'm pretty certain it worked as late as 
>>2.6.14-git7.
>>    
>>
>
>You need to do a git bisect (check the list archives) to isolate the
>change that broke it.
>
>Lee
>
>
>  
>
OK.  I will, but I will add a tiny bit of additional info first.
dmesg shows bttv loading up like this:
Linux video capture interface: v1.00
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ
5
bttv0: Bt878 (rev 2) at 0000:00:0b.0, irq: 5, latency: 32, mmio: 0xeb003000
bttv0: detected: ATI TV Wonder/VE [card=64], PCI subsystem ID is 1002:0003
bttv0: using: ATI TV-Wonder VE [card=64,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: using tuner=19
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 0-0060: All bytes are equal. It is not a TEA5767
tuner 0-0060: chip found @ 0xc0 (bt878 #0 [sw])
tuner 0-0060: type set to 19 (Temic PAL* auto (4006 FN5))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
.....and when trying to tune audio comes in, but dmsg shows video giving:
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: SCERR @ 348ec014,bits: HSYNC OFLOW FBUS SCERR*
bttv0: SCERR @ 348ec000,bits: OFLOW FBUS SCERR*
.... I will do the git bisect and reply in a bit.
Thanks for your reply,
Bob
