Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131220AbQKWXlJ>; Thu, 23 Nov 2000 18:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131241AbQKWXlA>; Thu, 23 Nov 2000 18:41:00 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51717 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S131220AbQKWXkm>;
        Thu, 23 Nov 2000 18:40:42 -0500
Message-ID: <3A1DA3E2.13E17DAF@mandrakesoft.com>
Date: Thu, 23 Nov 2000 18:10:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Zach Brown <zab@zabbo.net>, "Adam J. Richter" <adam@yggdrasil.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.4.0-test11/drivers/sound/maestro.c port to new PCI 
 interface
In-Reply-To: <200011220223.SAA00416@baldur.yggdrasil.com> <20001122141341.E14640@tetsuo.zabbo.net> <20001123010543.B96@toy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > >     I also agree that the ioctl patch is kind of a bandaid over
> > > the problems that you described, and, while Zach Brown can speak
> >
> > The biggest problem is that the current code is gross gross gross.
> > I've been avoiding dealing with it too much in the hopes that moving to
> > oss_audio will make things much more friendly across the board.
> 
> What is oss_audio?

A module I wrote to encapsulate all the OSS logic into a single file. 
There are so many sound drivers that get their ioctls wrong in certain
cases, don't do mmap, etc. that I moved all the logic into one place.

You can obtain include/linux/oss_audio.h and drivers/sound/oss_audio.c
from gkernel CVS.  Check out module 'linux_2_4', tag
'hack_2_4_0_test11'.  (http://sourceforge.net/projects/gkernel/)


> I thought alsa is going in in 2.5...

Yep.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
