Return-Path: <linux-kernel-owner+w=401wt.eu-S1753056AbWLXXYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbWLXXYd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 18:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbWLXXYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 18:24:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60343 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753056AbWLXXYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 18:24:32 -0500
Date: Mon, 25 Dec 2006 00:24:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in 2.6.20-rc1)
Message-ID: <20061224232421.GA1761@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <20061223171804.e2c22a67.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061223171804.e2c22a67.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > PM: Removing info for No Bus:usbdev3.15_ep81
> > PM: Removing info for No Bus:usbdev3.15_ep82
> > PM: Removing info for No Bus:usbdev3.15_ep02
> > slab error in verify_redzone_free(): cache `size-512': memory outside object was overwritten
> >  [<c016a1b8>] cache_free_debugcheck+0x128/0x1d0
> >  [<c04b58e3>] hci_usb_close+0xf3/0x160
> >  [<c016b530>] kfree+0x50/0xa0
> >  [<c04b58e3>] hci_usb_close+0xf3/0x160
> >  [<c04b59be>] hci_usb_disconnect+0x2e/0x90
> >  [<c0454f23>] usb_disable_interface+0x53/0x70
> >  [<c04576f8>] usb_unbind_interface+0x38/0x80
> >  [<c032f908>] __device_release_driver+0x68/0xb0
> >  [<c032fc3e>] device_release_driver+0x1e/0x40
> >  [<c032f1db>] bus_remove_device+0x8b/0xa0
> >  [<c032dbc9>] device_del+0x159/0x1c0
> >  [<c04559ad>] usb_disable_device+0x4d/0x100
> >  [<c044fe8a>] usb_disconnect+0x9a/0x110
> >  [<c0452405>] hub_thread+0x355/0xbd0
> >  [<c061426e>] schedule+0x2de/0x8f0
> >  [<c013c640>] autoremove_wake_function+0x0/0x50
> >  [<c04520b0>] hub_thread+0x0/0xbd0
> >  [<c013c58c>] kthread+0xec/0xf0
> >  [<c013c4a0>] kthread+0x0/0xf0
> >  [<c0103be7>] kernel_thread_helper+0x7/0x10
> >  =======================
> 
> yes, this one looks like memory scribblage in bluetooth.  The
> buffer.c assertion failure should now be fixed, please verify.

I can confirm buffer.c assertion to be fixed (yes, I was using gdb at
that time).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
