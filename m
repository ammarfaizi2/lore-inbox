Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271334AbRHOSAe>; Wed, 15 Aug 2001 14:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271338AbRHOSAY>; Wed, 15 Aug 2001 14:00:24 -0400
Received: from dsl081-084-152.lax1.dsl.speakeasy.net ([64.81.84.152]:39940
	"EHLO mail.eparadigm.la") by vger.kernel.org with ESMTP
	id <S271334AbRHOSAL>; Wed, 15 Aug 2001 14:00:11 -0400
Date: Wed, 15 Aug 2001 10:09:13 -0700 (PDT)
From: dlang <dlang@enabledparadigm.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: lockup problem with 2.4.5,8 athlon
In-Reply-To: <Pine.LNX.4.10.10108151515110.15763-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0108151006140.7388-100000@web.lang.hm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the only reason I am doubting broken hardware is that I have been able to
duplicate the problem on so many different machines. (unless there is a
design flaw in the cooling setup) I will be double checking the temps in a
few min.

David Lang

On Wed, 15 Aug 2001, Mark Hahn wrote:

> Date: Wed, 15 Aug 2001 15:28:54 +0000 (GMT)
> From: Mark Hahn <hahn@physics.mcmaster.ca>
> To: dlang <dlang@enabledparadigm.com>
> Subject: Re: lockup problem with 2.4.5,8 athlon
>
> > when they lock up I cannot ping the box, the screen is blank (does not
> > reapond to alt-sysrq), keyboard numlock does not respond, the reset button
> > does not work and the power switch needs to be held down for 4 sec to shut
>
> if the reset button doesn't work, you have broken hardware;
> the kernel isn't involved with it.
>
> > method 1: over the network.
>
> cause lots of sync logging.
>
> > method2: no network.
>
> cause lots of writes and closes.
>
> > On both machines I have gone into the BIOS and set 'failsafe defaults'.
> > this helped lengthen the time between crashes (before I could sometimes
> > get the machines to crash just by letting them sit idle for several
> > hours).
>
> all signs so far indicate bogus hardware.  what is the reported temp
> of your CPU?  have you scrutinized the hardware settings, checked for
> bios upgrades, etc?
>
> > please tell me what I can do to assist in debugging this problem.
>
> if you're running 2.4.8, you've already got everything the kernel
> can do to work around known via chipset bugs.  there's no known kernel
> bug that would somehow cause this.
>
> not responding to alt-sysrq usually means the motherboard is hung,
> which is not a kernel issue.  out of curiosity, though, do you have
>
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
>
> in your .config?  there's some mutterings that the io/local apic
> stuff might not work on athlons.
>
>

