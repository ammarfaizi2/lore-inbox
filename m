Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLDKHf>; Mon, 4 Dec 2000 05:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbQLDKHZ>; Mon, 4 Dec 2000 05:07:25 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4612 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129406AbQLDKHN>;
	Mon, 4 Dec 2000 05:07:13 -0500
Message-ID: <20001203222300.B165@bug.ucw.cz>
Date: Sun, 3 Dec 2000 22:23:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tjeerd Mulder <tjeerd.mulder@fujitsu-siemens.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio 2.4.0-test11
In-Reply-To: <3A278916.6FF0C5DE@fujitsu-siemens.com> <E141ppq-0000DP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E141ppq-0000DP-00@the-village.bc.nu>; from Alan Cox on Fri, Dec 01, 2000 at 01:02:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It implements mono output and fixes a bug in the dma logic (reset necessary 
> > because some descriptors are already prefetched and are not updated
> 
> This is wrong. Linus please do not apply this patch, or if you have done back
> it out. Not only does it do format conversions in kernel (which is a strict
> not to be done in the sound driver policy) it also makes it impossible to make
> mmap work correctly with the OSS API definitions.
> 
> Tjeerd. I deliberately applied only small bits of your patch before because
> the mono mode stuff clutters the driver horribly and is not in the right place.
> It belongs in the application/libraries

Then you should kill parts of drivers/usb/audio - it contains format conversions.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
