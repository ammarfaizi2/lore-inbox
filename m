Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTKSJSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTKSJSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:18:00 -0500
Received: from gprs144-235.eurotel.cz ([160.218.144.235]:35456 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263921AbTKSJR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:17:59 -0500
Date: Wed, 19 Nov 2003 10:18:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Message-ID: <20031119091833.GE197@elf.ucw.cz>
References: <Pine.LNX.4.44.0311170844230.12994-100000@cherise> <200311181612.52176.rob@landley.net> <20031118232125.GA30268@atrey.karlin.mff.cuni.cz> <200311182326.17838.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311182326.17838.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > :-), Okay, we could make grub read /etc/fstab... But again user can do
> >
> > swapoff and swapon manually etc.
> 
> During resume?

No, imagine /dev/hda3 being set as swap in /etc/fstab, but user doing
swapoff /dev/hda3, swapon /dev/usb_zip_drive, then suspend.

/etc/mtab would be better choice, but swap does not appear there.

> > Having sto stop userspace processes and bring hardware back to some
> > sane state would complicate swsusp (and its testing!) a lot. Maybe in
> > 2.8 when it works perfectly in other cases....
> 
> If there's only one "init" style task running from initramfs, which simply 
> looks at the partitions and gets the info it needs from disk labels or 
> something without actually mounting a filesystem (or mounts it read only, no 
> journal playback, and then unmounts it again afterwards...)  And then the 
> system call/whatever it does is sematically "exit and resume from
> swap"...

Well, I'd hate to write docs for that system call.

"It is exit and resume from specified swap, you must not write any
disk before you call it, must not access (list) devices, must not
access any network."

> > ....but swsusp with modular kernels... I'm not sure if it can even
> > work. .. yes it can but you really should get it working monolithic, first.
> 
> Okay.  Tell me how to get hotplug devices (cardbus, usb) working 
> monolithically, and I'm all for it.

Well, just compile all the drivers you need in, and it just
works.... I'm using both cardbus and usb and no, I'm not using
modules.

							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
