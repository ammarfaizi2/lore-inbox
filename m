Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133056AbRDRInc>; Wed, 18 Apr 2001 04:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133057AbRDRInW>; Wed, 18 Apr 2001 04:43:22 -0400
Received: from 100m.mp200-2.esr.lvcm.net ([24.234.0.81]:32033 "EHLO
	100m.mp200-2.esr.lvcm.net") by vger.kernel.org with ESMTP
	id <S133056AbRDRInH>; Wed, 18 Apr 2001 04:43:07 -0400
Message-ID: <3ADD5391.57CC6978@lvcm.com>
Date: Wed, 18 Apr 2001 01:42:57 -0700
From: "Anthony D. Saxton" <lna@lvcm.com>
Reply-To: lna@bigfoot.com
Organization: LnA Concepts
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@denise.shiny.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: I can eject a mounted CD
In-Reply-To: <3AD779CB.ED7C1656@denise.shiny.it> <3AD78C81.51D8ED35@lvcm.com> <3ADB4511.E3F6F6F1@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

> > > My fstab:
> > >
> > > /dev/cdrom              /mnt/cdrom              iso9660
> > > noauto,user,ro           0 0
> > > /dev/cdrom              /mnt/cdmac              hfs
> > > noauto,user,ro           0 0
> >
> > Change your fstab to read instead:
> >
> > /dev/cdrom        /mnt/cdrom        auto        noauto,user,ro    0 0
> >
> > And remove the other cdrom listing. This will allow mounting any
> > supported format and eliminate the duel support for one device.
>
> That's not the point. The kernel should not allow someone to
> eject a mounted media.
>
> Bye.

The kernel actually should allow a misconfigured system to behave as
configured. Basically, your /etc/fstab is telling the kernel that you have
two different devices occupying the same device address. In my case, I
have two cdrom drives. With the original configuration, either one would
mount to /mnt/cdrom. I changed /etc/fstab to identify the first drive as
being at /dev/scd0, mounted to /mnt/cdrom and the second at /dev/scd1,
mounted to /mnt/cd-r. Now I can have to independent drives. I could have
just as easily setup the fstab as above, but  I would not be able to use
both drives.

One cannot expect any program to behave properly when configured
improperly. Your kernel was behaving exactly as it had been programmed it
to.

Anthony D. Saxton
LnA Concepts

