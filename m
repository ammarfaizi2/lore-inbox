Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276118AbRJaXwn>; Wed, 31 Oct 2001 18:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276132AbRJaXwe>; Wed, 31 Oct 2001 18:52:34 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:14598
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S276135AbRJaXwZ>; Wed, 31 Oct 2001 18:52:25 -0500
Message-Id: <5.1.0.14.2.20011031184117.00b0da30@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 31 Oct 2001 18:49:58 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Stevie O <stevie@qrpff.net>
Subject: Re: Local APIC option (CONFIG_X86_UP_APIC) locks up Inspiron
  8100
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15ysre-0003FD-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.2.20011030235723.022818d8@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:44 AM 10/31/2001 +0000, Alan Cox wrote:
> > One other thing: how would the kernel react to the "SpeedStep" feature of
> > changing the CPU speed while things are still running?
>
>Depends on the laptop. Speedstop is not documented by intel so either it
>works because the APM bios did the right thing, or it doesn't work because
>it didn't. The only kernel issue is delay loops. We calibrate them at boot
>and assume the base clock is constant. In practice this isnt showing up as
>a real problem, although we do need to switch to the ACPI timers on later
>laptops

Yeah, that's what I'm concerned with -- the delay loops. I don't know what 
they're used for, so I don't know what the CPU speed change would affect. 
Mine would switch between 1.0GHz (996MHz according to /proc/cpuinfo) and 
733MHz (730MHz). That's a difference of 36% - a timer calibrated to wait 1s 
at 733MHz would only wait for 0.733s at 1GHz, and .3s can be quite 
important in the computing world.

And, of course, since the BIOS can't handle APCI, using an APCI timer 
wouldn't help much, would it?


--
Stevie-O

Real programmers use dd if=/dev/mouse of=a.out and move their mice around.

