Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbQKHK7C>; Wed, 8 Nov 2000 05:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130890AbQKHK6w>; Wed, 8 Nov 2000 05:58:52 -0500
Received: from hqvsbh1.ms.com ([205.228.12.103]:60058 "EHLO hqvsbh1.ms.com")
	by vger.kernel.org with ESMTP id <S129901AbQKHK6k>;
	Wed, 8 Nov 2000 05:58:40 -0500
Message-ID: <3A0931CB.AE39A93E@msdw.com>
Date: Wed, 08 Nov 2000 10:58:19 +0000
From: Richard Polton <Richard.Polton@msdw.com>
Reply-To: Richard.Polton@msdw.com
Organization: Morgan Stanley Dean Witter & Co.
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD   (WinNT; U)
X-Accept-Language: en,ja
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.4.0-test10 problems
In-Reply-To: <3A090F20.D4B42BDE@msdw.com> <3A09B75C.4CB08D72@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I currently do not use either APM or ACPI. Initially I used ACPI
and removing it in test8 appeared to fix the problem (but I suspect
that was just 'appear' rather than 'fix' 8-). I moved to APM instead
of ACPI in test9 - no change, and indeed in test10 I use neither.

There is a flag in the BIOS for Plug n Play OS. I shall toggle it and
observe the results.

Brad Hards wrote:

> Richard Polton wrote:
> > I have been testing my test10 installation and have come up with
> > a few old problems, all of which have been reported before.
> Don't known about the second two, but maybe can shed some light on the
> first one.
>
> > 1. Warm reboot fails to restart, i.e. hangs after displaying 'Restarting
> >
> >     system'. In this particular scenario, the power switch is disabled
> >     too and the only way in which the machine responds is by switching
> >     off at the wall and pulling the battery. Note that this scenario has
> > been
> >     observed only if I boot, get the login prompt (optionally log in)
> > and then
> >     ctrl-alt-del. A similar scenario occurs after an amount of time
> > using the
> >     machine and then rebooting. In this case, the machine restarts
> > successfully
> >     but hangs when it tries to initialise (right word?) the UHCI
> > controller.
> I think that the problem is pci / power management related. I have seen
> similar problems with my laptop (VAio F430), especially when warm
> booting from Win98 into Linux.
>
> Things to try:
> 1. Look at PnP or similar options (could be named anything) in the BIOS,
> and try toggling them.
>
> 2. Try APM instead of ACPI, or turn off power management.
>
> 3. If it hangs, 'soft cycle' the power. This is effective about 90% of
> the time for me.
>
> If any of this helps, you might like to post the results. I intend to do
> some more testing with -test10 over the next week or so, and will also
> post results.
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> http://lists.sourceforge.net/mailman/listinfo/linux-usb-devel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
