Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131230AbRBJJ7Z>; Sat, 10 Feb 2001 04:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbRBJJ7Q>; Sat, 10 Feb 2001 04:59:16 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:58897 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S131230AbRBJJ7H>; Sat, 10 Feb 2001 04:59:07 -0500
Date: Sat, 10 Feb 2001 09:52:33 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1ac9
Message-ID: <20010210095233.B1491@colonel-panic.com>
Mail-Followup-To: pdh, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A847252.54AD7579@Hell.WH8.TU-Dresden.De> <E14RMXU-0008DV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14RMXU-0008DV-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 09, 2001 at 11:01:13PM +0000
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001 at 11:01:13PM +0000, Alan Cox wrote:
> > I've noticed that -ac9 comes with the "Disable PCI-Master-Read-Caching
> > on VIA" patch that Peter Horton posted a while back. I don't know
> > whether it was applied in Linus' or your tree first, but is it
> > actually verified to fix anything?
> 
> Not yet. As the story becomes clear it can either be dropped or pushed
> on
> 

It should be dropped I think ...

Different folks found that changing different settings fixed it for
them, so it looks like some kind of internal race in the North bridge
where changing the timings in any way makes it harder to reproduce.

The updated BIOS from Asus definitely fixes it for me, and "PCI Master
Read Caching" is *enabled*. There are quite a few differences in the
setup of the North bridge from the previous BIOS to this one, and I
assume the changes were suggested by VIA.

If there are other people out there who still have this problem we can
probably come up with a patch for the kernel, but isolating which of the
settings are important would be a long job.

Shame VIA won't help :-(

P.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
