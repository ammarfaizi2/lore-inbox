Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129892AbQKVOk5>; Wed, 22 Nov 2000 09:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129412AbQKVOkr>; Wed, 22 Nov 2000 09:40:47 -0500
Received: from PTP283.UNI-MUENSTER.DE ([128.176.197.201]:17024 "EHLO
        pt2037.uni-muenster.de") by vger.kernel.org with ESMTP
        id <S129283AbQKVOki>; Wed, 22 Nov 2000 09:40:38 -0500
From: Bernd Nottelmann <nottelm@uni-muenster.de>
Organization: Universitaet Muenster
Date: Wed, 22 Nov 2000 15:10:31 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <00111022341900.16665@pt2037> <20001111051829.A484@suse.de>
In-Reply-To: <20001111051829.A484@suse.de>
Subject: Success with 2.4.0-test11(-final) [was: Re: Oops with 2.4.0-test10 during ripping an audio cd with cdda2wav]
Cc: linux-kernel@vger.kernel.org.nottelm@uni-muenster.de
MIME-Version: 1.0
Message-Id: <00112215103100.01219@pt2037>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 November 2000 05:18, you wrote:
 [...]
>
> This looks like cdrom.c:mmc_ioctl, CDROMREADAUDIO, kmalloc'ing too
> much memory, which triggers the BUG() in slab.c. I'm not quite sure
> how this is happening though, unless cdda2wav sets a negative ra.nframes
> (a quick browse on a version I have here shows it does not, maybe you
> have a different version).
>
> Is it reproducable? If so, could you try with this patch?

As I already told you, the bug was reproducible, as well in 2.4.0-test10 as in
2.4.0-test11. Today I tried it with 2.4.0-test11, the oops did happen again.
After applying your patch I ripped the song again (I figured out that it
was only one song, not the whole cd) and oops occured. Additionally
I checked the song out and it was ok.

  Bernd

PS: for unknown reasons your attached patch was included twice
in the file I saved on disk from it, so it came to this weird error messages
I mentioned in my last mail.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
