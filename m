Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263220AbVCDXnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbVCDXnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVCDXf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:35:57 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:11166 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263240AbVCDVU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:20:27 -0500
Subject: Re: swsusp: allow resume from initramfs
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, mjg59@scrf.ucam.org, hare@suse.de,
       "Barry K. Nathan" <barryn@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net>
References: <20050304101631.GA1824@elf.ucw.cz>
	 <20050304030410.3bc5d4dc.akpm@osdl.org>
	 <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net>
Content-Type: text/plain
Message-Id: <1109971327.3772.280.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 08:22:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel et al.

On Sat, 2005-03-05 at 04:50, Barry K. Nathan wrote:
> On Fri, Mar 04, 2005 at 03:04:10AM -0800, Andrew Morton wrote:
> > I don't understand how this can be affected by the modularness of the
> > kernel.  Can you explain a little more?
> > 
> > Would it not be simpler to just add "resume=03:02" to the boot command line?
> 
> In addition to what others have mentioned, there's also the situation
> where swap is on a logical volume. In that case, the initramfs needs to
> get LVM up and running before you can even think about resuming.
> 
> Swap on a logical volume is the default Fedora Core 3 partition layout,
> and I imagine it's the default for Red Hat Enterprise Linux 4 as well.

You guys are reinventing the wheel a lot at the moment and I'm in the
middle of doing it for x86_64 lowlevel code :> Can we see if we can work
a little more closely - perhaps we can get some shared code going that
will allow us to handle these issues without stepping on each others'
feet? In particular, shared code for

- initramfs and initrd support
- lowlevel suspend & resume

would be good, wouldn't it?

I'm tempted to add setting and checking signatures, but I'm also in the
middle of implementing support for writing the image to a file, so that
could get messy.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


