Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274648AbRITVFt>; Thu, 20 Sep 2001 17:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274649AbRITVFi>; Thu, 20 Sep 2001 17:05:38 -0400
Received: from [209.202.108.240] ([209.202.108.240]:24326 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S274648AbRITVFc>; Thu, 20 Sep 2001 17:05:32 -0400
Date: Thu, 20 Sep 2001 17:05:41 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shutdown "anomoly" with kernel 2.4.9
In-Reply-To: <20010920204319.4E0741F76@havoc.gtf.org>
Message-ID: <Pine.LNX.4.33.0109201658580.15504-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Michael G. Mobley wrote:

> When running kernel 2.4.9, my system cannot reliably reboot/
> halt/shutdown.  It hangs when killall5 sends out the TERM signal, as if
> init itself is terminating.  This is VERY repeatable (happens pretty
> much every time, whether the shutdown is through 'shutdown -r now',
> 'reboot', 'halt', whatever...)
>
> I wouldn't have thought this is a kernel problem, but, an identical build
> of 2.4.8 does not seem to exhibit this behavior.  And I've played around,
> making one change at a time, and that really is the ONLY difference.
>
> BTW, I'm building both kernels to exactly the same config.  (diff of the
> .configs show only three commented out sound card options that have been
> added to 2.4.9 as differences.)
>
> Brief system setup is:
>
> 1xPIII/800, Asus P3V4X MB, 640MB RAM
> AHA29160 SCSI controller w/ 3 HDDs, 2 CDROMs
> No IDE
> USB, AGP, etc...
> etc. etc...  (Can provide more details if needed)
> GCC version is:  2.96
> Binutils version is: 2.10.91.0.2
> (Basically it's a stock RH7.1 install right now)

Aha! I'm not alone and I'm not nuts. And it doesn't seem to be an Athlon/VIA
thing either.

This is exactly the same thing I'm seeing. And if I put calls to 'ps aux' in
/etc/init.d/halt around the killall5 and sleep calls then it shuts down
properly.

Here's my setup for reference:

1xAthlon 1050/100, Asus A7V, 512 MB PC133 RAM
2xATA/66, hda:CD-ROM, hdc:CDRW
2xATA/100 (Promise 20265 on-board), hde:HD (ext3/vfat), hdg:HD (vfat)
Stock RH7.1+Updates+2.4.9-ac12-preempt1

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

