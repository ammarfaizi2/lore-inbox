Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSEBUo2>; Thu, 2 May 2002 16:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSEBUo1>; Thu, 2 May 2002 16:44:27 -0400
Received: from alex.intersurf.net ([216.115.129.11]:46606 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S315412AbSEBUo1>; Thu, 2 May 2002 16:44:27 -0400
Date: Thu, 2 May 2002 15:44:25 -0500
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.12-dj1:  IDE trouble - RZ1000 still won't finish booting
Message-Id: <20020502154425.45437b42.markorr@intersurf.com>
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted a log about this about a week ago regarding
Linux 2.5.10 not completing boot on an older system with a
RZ1000 IDE interface.   (and that RZ1000 by itself, w/ CMD640
and generic PCI IDE disabled in make config, wouldnt even
compile  -- it still doesnt with 2.5.12-dj1)


It still crashes at the same place - when the root
filesystem is remounted with R/W.   The messages look different,
i.e. the "unexpected interrupt <x> <y>" is gone, but it looks
like it's still complaining about the same thing:

hda: task_mulout_intr: error=0x04  { DriveStatusError }

then several of these:

   { task_mulout_intr }
hda:  ide_set_handler: handler not null  old=<some hex> new=<some other hex>
bug: kernel timer added twice

finally:

end_request: I/O error, dev 03:00, sector 456628
end_buffer_io_sync: I/O error
hda: ata_irq_request: hwgroup was not busy!?
Unable to hand kernel NULL pointer dereference...

...and the usual dumpage.    (which isnt logged, naturally)

--
Mark Orr
markorr@intersurf.com
