Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290628AbSARH7Y>; Fri, 18 Jan 2002 02:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290629AbSARH7E>; Fri, 18 Jan 2002 02:59:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44037 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290628AbSARH7B>;
	Fri, 18 Jan 2002 02:59:01 -0500
Date: Fri, 18 Jan 2002 08:58:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Robert Love <rml@tech9.net>, Andre Hedrick <andre@linuxdiskcert.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.3-pre1 ata-253p1-2
Message-ID: <20020118085850.L27835@suse.de>
In-Reply-To: <Pine.LNX.4.10.10201171455360.344-100000@master.linux-ide.org> <Pine.LNX.4.10.10201171455360.344-100000@master.linux-ide.org> <5.1.0.14.2.20020118004455.00b07800@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020118004455.00b07800@pop.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18 2002, Anton Altaparmakov wrote:
> >> You have to give Jens the credit for gluing it togather, because there 
> >was
> >> no way I would have figured out the suttle issues of BIO.  There are
> >> serveral additions need to fix all the archs so hope to have something
> >> today.
> >
> >Well, good work to both of you.  It is an excellent driver.  Please
> >submit it for pre2.
> 
> I second that. 2.5.3-pre1 + 2nd patch from Jens + daft compile fixes is 
> running fine on my Athlon/VIA chipset both UDMA100 and PIO4 on my 60GXP 
> drive! Brilliant work guys!

Thanks!

> There is only one odd thing and that is that PIO transfers are slower in 
> 2.5.3-pre1 + 2nd patch from Jens + daft compile fixes compared to in 
> 2.5.2-pre11-vanilla.
> 
> PIO mode, hdparm -t /dev/hda:
> 
>         on 2.5.3-pre1 + 2nd Jens patch: 4.62MB/s
>         on 2.5.2-pre11 vanilla:         7.36MB/s
> 
> DMA transfers are the same with both kernels, peaking at 38-39MB/s which is 
> I believe the theoretical upper limit for the 60GXP so there was not much 
> room for visible improvement (2.5.3-pre1 is slightly faster in that it gave 
> in three tests 38.79MB/s while 2.5.2-pre11 gave in three tests 38.32MB/s, 
> so if you believe those ACB is .4 MB/s faster).
> 
> I don't care that PIO has become slower, all modern devices are happy with 
> UDMA, and so am I. (-: But I thought I should mention it.

Interesting, I dunno where this performance decrease comes from right
now. But I'm sure we can make it go at least as fast as 2.5.2-pre11, the
primary concern right now was solid PIO + mult mode again, and I think
we've achieved that.

> Note that 2.5.3-pre1 now survives find . -type f -exec md5sum "{}" \; both 
> in PIO and UDMA mode so it can really be considered stable on UP system.

Great, thanks for testing.

-- 
Jens Axboe

