Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSKTQGe>; Wed, 20 Nov 2002 11:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSKTQGe>; Wed, 20 Nov 2002 11:06:34 -0500
Received: from 208-135-136-018.customer.apci.net ([208.135.136.18]:15117 "EHLO
	blessed.joshisanerd.com") by vger.kernel.org with ESMTP
	id <S261375AbSKTQGd>; Wed, 20 Nov 2002 11:06:33 -0500
Date: Wed, 20 Nov 2002 10:13:20 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
To: Jacob Kroon <d00jkr@efd.lth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: OSS VIA82cxxx sound driver problem.
In-Reply-To: <Pine.GSO.4.44.0211201535470.12611-200000@login-4.efd.lth.se>
Message-ID: <Pine.LNX.4.44.0211201005050.30881-100000@blessed.joshisanerd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give 2.5.x a shot. In some versions there's a buglet, which was hopefully
fixed (I kludged a patch, then the maintainer sent a proper one, and I
haven't had time to try it out).

I saw similar problems under 2.4 (it almost seems like the chipset is
expecting aligned input; lots of errors after closing the device at the
end of a song), but they went away when switching to 2.5.44.

Basically, the OSS driver for this chipset is hopelessly bad (no offense
Jeff!), but ALSA one is pretty well-done and handles the quirks of the
device.
--
/jbm, but you can call me Josh. Really, you can!
 "What's a metaphor?" "For sheep to graze in"
7958 1C1C 306A CDF8 4468  3EDE 1F93 F49D 5FA1 49C4


On Wed, 20 Nov 2002, Jacob Kroon wrote:

>
> System:
> AMD Athlon 800Mhz
> Kernel 2.4.19, built with GCC 3.2
> VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP] (rev 0).
>
> I've compiled the VIA82cxxx driver into the kernel, not as a module. The
> driver works correctly for some time, but after a while it seems that it
> can't set certain output frequencies (but it still plays sound), as I
> noticed that XMMS plays songs at a slower frequency.
>
> Small output of "dmesg", whole log in attachment:
>
> ...
> ...
> attempt to access beyond end of device
> 16:40: rw=0, want=479602, limit=479600
> via82cxxx: timeout while reading AC97 codec (0xAC0000)
> via82cxxx: Codec rate locked at 48Khz
> via_audio: ignoring drain playback error -11
> via_audio: ignoring drain playback error -11
>
> Quake 3 sounds ok, probably becuse it's playing audio at a rate that the
> driver still can set (11Khz i think).
>
> /Jacob
>

