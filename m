Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129928AbQKOTyS>; Wed, 15 Nov 2000 14:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130594AbQKOTyJ>; Wed, 15 Nov 2000 14:54:09 -0500
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:49424 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129928AbQKOTx6>; Wed, 15 Nov 2000 14:53:58 -0500
Date: Wed, 15 Nov 2000 20:23:44 +0100
From: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
To: emoenke@gwdg.de, eric@andante.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Cc: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
Subject: BUG: isofs broken (2.2 and 2.4)
Message-ID: <20001115202344.A29136@turtle.tat.physik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-fingerprint: 3B CD 5A A9 73 44 DD 04  A0 4E A0 34 20 7B 1E 38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

both 2.2.x and 2.4.x kernels can't read `real sky' CDs from the
Space Telescope Science Institute containing lotsof directories (~100) 
which each contain lots of small files (~700 files/dir).  only ~10 directories
with ~10 files each are displayed, all the other files/diretories can't be 
accessed. the kernel gives the following message:

	next_offset (212) > bufsize (200)

and with 2.2.x kernels I additionally get

	Invalid session number or type of track

at mount time (that's the 2nd instance of this message, i == -22 (RTFS)).



you can find an isofs image for testing (only directory part, no real data,
compressed ~620kb) on

	http://www.tat.physik.uni-tuebingen.de/~koenig/buggy_fs.iso.gz



any idea/patch/fix ?

thanks,


Harald

PS:  I'm not subscribed to linux-kernel right now, so please 
reply directly using Cc:.   thanks!
--
All SCSI disks will from now on                     ___       _____
be required to send an email notice                0--,|    /OOOOOOO\
24 hours prior to complete hardware failure!      <_/  /  /OOOOOOOOOOO\
                                                    \  \/OOOOOOOOOOOOOOO\
                                                      \ OOOOOOOOOOOOOOOOO|//
Harald Koenig,                                         \/\/\/\/\/\/\/\/\/
Inst.f.Theoret.Astrophysik                              //  /     \\  \
koenig@tat.physik.uni-tuebingen.de                     ^^^^^       ^^^^^
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
