Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129810AbQK3CwW>; Wed, 29 Nov 2000 21:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130805AbQK3CwD>; Wed, 29 Nov 2000 21:52:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25107 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S132003AbQK3Cvx>;
        Wed, 29 Nov 2000 21:51:53 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDA5@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Alexander Viro'" <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: usbdevfs mount 2x, umount 1x
Date: Wed, 29 Nov 2000 17:07:35 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
        charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alexander Viro [mailto:viro@math.psu.edu]
> 
> On Wed, 29 Nov 2000, Randy Dunlap wrote:
> 
> > [I reported this a couple of months back.  Got no
> > feedback on it.  If it's just a DDT (don't do that)
> > or a user error, please say so.]
> > 
> > Summary:  After I mount usbdevfs 2 times, and umount it
> > 1 time, the usbcore module use count prevents it from
> > being rmmod-ed.
> 
> So umount it twice.
I don't see a way to umount it twice or I would have done that.
Is there a way?

> And yes, it's "don't do it, then".
OK.

> Every mount() increments the use count.
Got that.

> Every umount() decrements it. You want it
> to become 0. Draw your conclusions...
Looks to me like umount unmounted it 2 times and decremented
the use count by 1.

I don't see a way for me to rmmod usbcore.  As it is,
I have to reboot the system (or just DDT).

Thanks,
~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
