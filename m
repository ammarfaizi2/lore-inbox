Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSDIVt6>; Tue, 9 Apr 2002 17:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSDIVt5>; Tue, 9 Apr 2002 17:49:57 -0400
Received: from coltrane.siteprotect.com ([64.26.16.13]:59266 "EHLO
	coltrane.siteprotect.com") by vger.kernel.org with ESMTP
	id <S311749AbSDIVt4>; Tue, 9 Apr 2002 17:49:56 -0400
From: "Rob Hall" <rob@compuplusonline.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.7,8-pre2 and USB
Date: Tue, 9 Apr 2002 17:58:41 -0400
Message-ID: <BBENIHKKLAMLHIECFJEPGEPOCAAA.rob@compuplusonline.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020409144014.B25192@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


