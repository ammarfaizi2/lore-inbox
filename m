Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRCGD0c>; Tue, 6 Mar 2001 22:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbRCGD0W>; Tue, 6 Mar 2001 22:26:22 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:57604 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129953AbRCGD0I>;
	Tue, 6 Mar 2001 22:26:08 -0500
Message-ID: <3AA5B0F3.143E0528@candelatech.com>
Date: Tue, 06 Mar 2001 20:54:27 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ? (No
In-Reply-To: <E14aGFU-0000YQ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > running a bad hdparm command while running a full GNOME desktop:
> > (This was not a good idea...and I know, and knew that...but....)
> >
> > hdparm -X34 -d1 -u1 /dev/hda
> > (As found here: http://www.oreillynet.com/pub/a/linux/2000/06/29/hdparm.html?page=2
> >
> > Sorry for the lame bug report, but I'm scared to try it again, and
> > I didn't realize the complexity of the problem when I simply powered
> > down my machine with the HD light on solid...
> 
> Its not a bug. As the system administrator you reconfigured a hard disk on
> the fly and shit happened. The hdparm man page warnings do exist for a reason.

I'm not arguing it was a smart thing to do, but I would think that the
fs/kernel/driver writers could keep really nasty and un-expected things
from happenning.  For instance, the driver could dis-allow any new (non-hdparm)
writes while hdparm is doing it's test.  Or maybe the driver could realize it
was being told to do something that would break and just not do it?

Considering this disk is my root disk, is there *any* safe way to test
out hdparm on this disk?

Enjoy,
Ben
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
