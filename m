Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312464AbSDJOjG>; Wed, 10 Apr 2002 10:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313175AbSDJOjF>; Wed, 10 Apr 2002 10:39:05 -0400
Received: from coltrane.siteprotect.com ([64.26.16.13]:46009 "EHLO
	coltrane.siteprotect.com") by vger.kernel.org with ESMTP
	id <S312464AbSDJOjF>; Wed, 10 Apr 2002 10:39:05 -0400
From: "Rob Hall" <rob@compuplusonline.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.7,8-pre2 and USB
Date: Wed, 10 Apr 2002 10:47:50 -0400
Message-ID: <BBENIHKKLAMLHIECFJEPIEADCBAA.rob@compuplusonline.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <BBENIHKKLAMLHIECFJEPGEPOCAAA.rob@compuplusonline.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Sorry guys,
	I was late getting home last night. I got my system backup and running to a
degree, and I'll send off my .config when I get home tonight after class.

Thanks
--
Rob Hall

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Rob Hall
Sent: Tuesday, April 09, 2002 5:59 PM
To: Greg KH
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.5.7,8-pre2 and USB


Yes, it also happened if I just compiled USB core support in. I would try it
again, but I broke my system upgrading glibc over the weekend(don't ask, I'm
just going to build LFS). I think I have my .config saved, I'll send it when
I get home this evening. When I had core and HC support built into the
kernel, I also had full HID, usb-serial for handspring visors, usb mass
storage, and joystick support. The same configuration has worked flawlessly
on 2.4.x.

Thanks!
--
Rob Hall

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Tuesday, April 09, 2002 5:40 PM
To: Rob Hall
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7,8-pre2 and USB


On Tue, Apr 09, 2002 at 05:44:17PM -0400, Rob Hall wrote:
> I've tried both the OHCI and the OHCI-HCD drivers... But it's not getting
> that far... the core is what's locking the system up. I probably should
have
> been more specific on that. If I load the USB core as a module after init
> fires off, then USB works fine... if I compile it into the kernel, the USB
> core locks the machine down right after detecting my PnP BIOS. It doesn't
> get far enough to put anything into the system log.

Ah, ok.  Haven't heard of this problem before.  The USB core doesn't
touch any hardware, but only initializes a few things, and adds a filesystem
to the kernel if you've selected it as a option.

Does it also happen if you only build the USB core into the kernel, yet
leave the host controllers and other drivers as modules?

Have you selected any USB drivers to be compiled into the kernel?

Can you send me your .config?

thanks,

greg k-h


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


