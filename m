Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286314AbRL0PoB>; Thu, 27 Dec 2001 10:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286312AbRL0Pnw>; Thu, 27 Dec 2001 10:43:52 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:27752 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S286311AbRL0Pnl>; Thu, 27 Dec 2001 10:43:41 -0500
Message-ID: <3C2B413E.FF297DE8@randomlogic.com>
Date: Thu, 27 Dec 2001 07:41:50 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Sound issues with kernel 2.4.14 - 2.4.17
In-Reply-To: <3C2AA64C.2CD1AD6E@randomlogic.com> <3C2B3E1D.1050309@p4all.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Dunsky wrote:
> 
> Paul G. Allen wrote:
> 
>  > Sound worked fine through kernel 2.4.9. Since I upgraded to 2.4.14, and
>  > now to 2.4.17 (I skipped 2.4.10 - 2.4.13) I have several games that are
>  > FUBAR, all sound related: Quake III Arena and Quake II both core dump
>  > initializing sound; Soldier of Fortune, Railroad Tycoon II, Sid Myers
>  > Alpha Centaury all make strange noises with no intelligable game sound.
>  > Tribes 2, Unreal Tournament, and Descent 3 all work fine. GNOME and
>  > Enlightenment sound work fine as well, as does xmms.
>  >
>  > I have a SB Live! OEM and have tried compiling with and without the MIDI
>  > module. The main thing is I am trying to do some game development and
>  > it's impossible when sound is FUBAR. Any ideas?
>  >
>  > I hate to go back to an earlier kernel as IDE did not work (for me) in
>  > the previous kernels.
>  >
>  > PGA
>  >
> 
> Hello!
> 
> I ran into a similar problem:
> Upgraded from 2.4.5 to 2.4.14 and added some RAM (total 1GB now). When not using
>   HIHGMEM_4GB, ~180MB of the RAM was missing. With HIGHMEM_4GB enabled, sound
> was totally trashed (I also had the segfaulting Quake3Arena).
> 
> The SBLive uses the "emu10k1"-driver - and the driver that came with 2.4.14 was
> broken if used with "HIGHMEM" enabled. W/o this, the sound had no problems. Rui
> Sousa made it working with HIGMEM enabled. (But sometimes, especially with very
> little free RAM left the sound is still broken )

That may be the problem, I have "HIGHMEM" enabled. I too have a MoBo
that can handle lots of memory (up to 4GB) and I plan to use it.

> 
> Have you tried the latest snapshot from opensource.creative.com ?
> I've taken a look into the kernel-patches (I'm still at 2.4.14 - will upgrade to
> 2.4.17 when SGI's XFS is ready for thet kernel), and there were no
> version-changes in the driver.
> 
> How to do it (very short):
> Unzip and untar, cd into "emu10k1_<date>" and do "make && make install"
> (maybe save the old from "/lib/modules/<kernel-version>/kernel/drivers/sound"
> and "sound/emu10k1" before...) Remove your loaded "emu10k1" and "ac97_codec"
> modules (don't forget this), load the new and test it.
> 
> There are some more nice features within Creatives "official" drivers (such as
> bass/treble control)...
> 

I haven't tried the Creative stuff, but I did D/L OSS and it works fine.
In fact, the sound in all my games is better than it was. Only one
problem - if I continue to use the OS driver/module, I have to pay $35
for it (no big deal really, but it is money :)

Maybe I'll give the Creative stuff a try.

PGA
-- 
Paul G. Allen
Owner, Sr. Engineer, Security Specialist
Random Logic/Dream Park
www.randomlogic.com
