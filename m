Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314132AbSEFIrB>; Mon, 6 May 2002 04:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314283AbSEFIrA>; Mon, 6 May 2002 04:47:00 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:46960 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314132AbSEFIq7>; Mon, 6 May 2002 04:46:59 -0400
Message-Id: <5.1.0.14.2.20020506093027.00aca720@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 May 2002 09:47:06 +0100
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: vanilla 2.5.13 severe file system corruption experienced
  follozing e2fsck ...
Cc: william stinson <wstinsonfr@yahoo.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <20020506055554.GM811@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:55 06/05/02, Jens Axboe wrote:
>On Sun, May 05 2002, Anton Altaparmakov wrote:
> > Note even with that fix IDE (at least TCQ) is really easy to crash when 
> you
> > put the system under heavier I/O (at least on my via box)...
>
>If you have stumpled upon a tcq bug, I'd like to know more about it.

Back trace (sorry didn't have ckermit running so didn't catch the whole 
output and was too lazy to write it all down): blk_queue_invalidate_tags, 
tcq_invalidate_queue, ide_dmaq_complete, ide_dmaq_intr, ata_irq_request, 
ide_dmaq_intr, handle_IRQ_event, do_IRQ, ideprobe_init.

At the moment I try to not use 2.5.x as much as possible and only boot into 
it to test ntfs or other changes I make, so when I do that next I will make 
sure I am capturing on the serial console and send you details if I 
experince the panic again...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

