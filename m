Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129566AbQKNLDS>; Tue, 14 Nov 2000 06:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129565AbQKNLDI>; Tue, 14 Nov 2000 06:03:08 -0500
Received: from PTP283.UNI-MUENSTER.DE ([128.176.197.201]:42624 "EHLO
	pt2037.uni-muenster.de") by vger.kernel.org with ESMTP
	id <S129461AbQKNLCv>; Tue, 14 Nov 2000 06:02:51 -0500
From: Bernd Nottelmann <nottelm@uni-muenster.de>
Organization: Universitaet Muenster
Date: Tue, 14 Nov 2000 11:32:50 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <00111022341900.16665@pt2037> <20001111051829.A484@suse.de>
In-Reply-To: <20001111051829.A484@suse.de>
Subject: Re: Oops with 2.4.0-test10 during ripping an audio cd with cdda2wav
Cc: linux-kernel@vger.kernel.org.nottelm@uni-muenster.d
MIME-Version: 1.0
Message-Id: <00111411325000.02019@pt2037>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 November 2000 05:18, you wrote:

Hi Jens,

(Sorry for the delay)
> This looks like cdrom.c:mmc_ioctl, CDROMREADAUDIO, kmalloc'ing too
> much memory, which triggers the BUG() in slab.c. I'm not quite sure
> how this is happening though, unless cdda2wav sets a negative ra.nframes
> (a quick browse on a version I have here shows it does not, maybe you
> have a different version).
>
> Is it reproducable? If so, could you try with this patch?
Yes, it is. But unfortunately I cannot apply your patch. A --dry-run
gave no errors, but when I really patched 2.4.0-test10, it came to
some weird error message (patch tells me, that some files are
already patched???). [Why not 2.4.0-test11p2? I use this machine
for some numerical calculations which take long time runs and
they are at the moment not restartable after a break. For this reasons
I do not prefer pre-kernels (but I use the 2.4.0-beta series because
it is more stable for my hardware than the 2.2-series).]

  Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
