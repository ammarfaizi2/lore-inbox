Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129967AbRABRiV>; Tue, 2 Jan 2001 12:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130163AbRABRiK>; Tue, 2 Jan 2001 12:38:10 -0500
Received: from renata.irb.hr ([161.53.129.148]:30212 "EHLO renata.irb.hr")
	by vger.kernel.org with ESMTP id <S129967AbRABRh5>;
	Tue, 2 Jan 2001 12:37:57 -0500
From: Vedran Rodic <vedran@renata.irb.hr>
Date: Tue, 2 Jan 2001 18:07:21 +0100
To: Daniel Phillips <phillips@innominate.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prerelease problems (it corrupted my ext2 filesystem)
Message-ID: <20010102180721.A18202@renata.irb.hr>
In-Reply-To: <20010102131507.A7573@renata.irb.hr> <3A51D9BF.23C42DFE@innominate.de> <20010102152409.A10863@renata.irb.hr> <3A51F1B0.3AD38F9F@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A51F1B0.3AD38F9F@innominate.de>; from phillips@innominate.de on Tue, Jan 02, 2001 at 04:20:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 04:20:16PM +0100, Daniel Phillips wrote:
> Vedran Rodic wrote:
> > On Tue, Jan 02, 2001 at 02:38:07PM +0100, Daniel Phillips wrote:
> > > Could you provide details of your configuration?
> > 
> > I put the complete kernel log of that session at http://quark.fsb.hr/~vrodic/kern.log
> > 
> > I scanned my swap device several times today with badblocks -w, and
> > it didn't show any errors. I also did some RAM tests with memtest86,
> > again with no errors.
> > 
> > If you need more details, just ask.
> 
> Are you still running 2.4.0-pre?  Can you reproduce the problem?  Does
> the problem occur only with v4l?  Did you back up your files?

No. I am afraid :\, I think that I can't reproduce this problem easily. You
see at the log files that it happened after some hours of uptime, and I did
some bttv grabbing for an hour or so. I used 2.4.0-pre, pre12, pre11, pre9.
pre12 was nice, I had no problems with pre11 either (well except for the
instability of nvidia binary drivers, but I'm not using that for a longer
period now). I did bttv video grabbing only on 2.4.0pre.
 
I didn't backup recently, but I was lucky:) The most damaged areas were
/usr, /etc managed to get untouched, and my home dir is fine. e2fsck did
clear a lot of inodes, but I managed to boot the system and reinstall most
of the stuff. I'm backing up stuff now, and when I finish (10G will be a bit
slow with a 4x burner), I'll start playing with fire again.
 
I just remembered that I booted 2.4.0-pre after the disaster, and it
mentioned something about not being able to access sectors beyond the end of
the device. I booted 2.2.17 after, and ran e2fsck.
 
Could it be that I experienced IDE DMA timeout problem?
 
Vedran
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
