Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129150AbQKVP5n>; Wed, 22 Nov 2000 10:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129208AbQKVP5d>; Wed, 22 Nov 2000 10:57:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18693 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S129150AbQKVP53>;
        Wed, 22 Nov 2000 10:57:29 -0500
Date: Wed, 22 Nov 2000 16:27:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Bernd Nottelmann <nottelm@uni-muenster.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Success with 2.4.0-test11(-final) [was: Re: Oops with 2.4.0-test10 during ripping an audio cd with cdda2wav]
Message-ID: <20001122162710.Y3258@suse.de>
In-Reply-To: <00111022341900.16665@pt2037> <20001111051829.A484@suse.de> <00112215103100.01219@pt2037>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00112215103100.01219@pt2037>; from nottelm@uni-muenster.de on Wed, Nov 22, 2000 at 03:10:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22 2000, Bernd Nottelmann wrote:
> On Saturday 11 November 2000 05:18, you wrote:
>  [...]
> >
> > This looks like cdrom.c:mmc_ioctl, CDROMREADAUDIO, kmalloc'ing too
> > much memory, which triggers the BUG() in slab.c. I'm not quite sure
> > how this is happening though, unless cdda2wav sets a negative ra.nframes
> > (a quick browse on a version I have here shows it does not, maybe you
> > have a different version).
> >
> > Is it reproducable? If so, could you try with this patch?
> 
> As I already told you, the bug was reproducible, as well in 2.4.0-test10 as in
> 2.4.0-test11. Today I tried it with 2.4.0-test11, the oops did happen again.
> After applying your patch I ripped the song again (I figured out that it
> was only one song, not the whole cd) and oops occured. Additionally
> I checked the song out and it was ok.

Ok, can you send me the cdda2wav binary you are ripping audio with
so I can test here? I'm at a loss as to why kmalloc() would be too big
and not being caught.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
