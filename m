Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSKJUQX>; Sun, 10 Nov 2002 15:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbSKJUQX>; Sun, 10 Nov 2002 15:16:23 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:44747 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262859AbSKJUQW>;
	Sun, 10 Nov 2002 15:16:22 -0500
Date: Sun, 10 Nov 2002 21:23:04 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Thor Kristoffersen <Thor.Kristoffersen@nr.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with VT8235 + DMA patch + PlexWriter W2410
Message-ID: <20021110212304.A15619@ucw.cz>
References: <200211101934.gAAJYZt09539@triumph.nr.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200211101934.gAAJYZt09539@triumph.nr.no>; from Thor.Kristoffersen@nr.no on Sun, Nov 10, 2002 at 08:34:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 08:34:35PM +0100, Thor Kristoffersen wrote:

> I have tried, without success, to get a PlexWriter PX-W2410A (IDE/ATAPI CD
> burner) to work with an MSI KT3 Ultra2 (KT333/VT8235) and Vojtech Pavlik's
> DMA patch.  Any attempt to access the CD burner produces lots of messages
> like these:
> 
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdc: drive not ready for command
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdc: drive not ready for command
> hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hdc: status error: error=0x54
> hdc: drive not ready for command
> 
> The problem seems to be largely independent of the kernel version.  I have
> tried 2.4.19, 2.4.20-preXX, and 2.5.46, with the same results.
> 
> Simply turning off DMA for the CD burner does not make it work: the
> problem persists as long as the patch is present.  On the other hand, a
> different CD burner (Sony CRX-140E) works just fine with the same
> mainboard, with the patch present.

Does the drive work without the patch? If yes, please send me 'hdparm -i
/edv/hdc', 'lspci -vvxxx' for both the cases with and without the patch,
and 'cat /proc/ide/via' for the case with the patch. I'll check if all
the timings programmed really are correct.

Maybe we have a candidate for drive PIO timing black list. 

(check: no overclocking takes place on your machine, right?)

-- 
Vojtech Pavlik
SuSE Labs
