Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161241AbWAHX06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbWAHX06 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 18:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbWAHX06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 18:26:58 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:60394 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1161241AbWAHX05 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 18:26:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jzS2Alw1RAJTDBdkpQbPYFAqSZpjoLL/imL0SSE+ujM9tt0KF5ll4SN84L1JlooAW3/WacAs8E9hlhgYO2hgK6+2h1TWP9X3VsDZ7PdH5a6Kt9Zw2mFFwWgtb7fn4TRiIAUXSRmhgZ9cABQPn3q45xVgEnhLAAuRUHMGnt5TU7k=
Message-ID: <69304d110601081524v37b15ff2tfed8341eaffbe07@mail.gmail.com>
Date: Mon, 9 Jan 2006 00:24:52 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: Meelis Roos <mroos@linux.ee>, Russell King <rmk+lkml@arm.linux.org.uk>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
In-Reply-To: <Pine.SOC.4.61.0512291011320.28176@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051214172445.GF7124@flint.arm.linux.org.uk>
	 <Pine.SOC.4.61.0512221231430.6200@math.ut.ee>
	 <20051222130744.GA31339@flint.arm.linux.org.uk>
	 <Pine.SOC.4.61.0512231117560.25532@math.ut.ee>
	 <20051223093343.GA22506@flint.arm.linux.org.uk>
	 <Pine.SOC.4.61.0512231204290.8311@math.ut.ee>
	 <20051223104146.GB22506@flint.arm.linux.org.uk>
	 <Pine.SOC.4.61.0512271553480.7835@math.ut.ee>
	 <20051228195509.GA12307@flint.arm.linux.org.uk>
	 <Pine.SOC.4.61.0512291011320.28176@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/05, Meelis Roos <mroos@linux.ee> wrote:
> > Can I assume that the bug has disappeared?  Does the patch make it
> > disappear?
>
> Yes, seems so.
>
> --
> Meelis Roos (mroos@linux.ee)

Please notice official linus 2.6.15 tree doesn't have this fix... I've
just installed a virtual machine (qemu-system-i386 with linus 2.6.15 +
plain debian 3r0, console output to xterm via emulated serial console)
and trying to use any curses program (top for example) produces
exactly this type of error.

QEMU_AUDIO_DRV=none \
  nice /home/qemu/bin/qemu \
    -nographic \
    -hda debian-30r0-i386-rootfs.ext2 \
    -kernel bzImage-2.6.15 \
    -append "console=ttyS0,9600n8 lpj=10000 noapic root=/dev/hda"

I'm now recompiling with this lower limit to test...

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
