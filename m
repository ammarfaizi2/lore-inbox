Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVJaQOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVJaQOS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVJaQOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:14:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:64668 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932431AbVJaQOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:14:17 -0500
Date: Mon, 31 Oct 2005 11:14:13 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Masanari Iida <standby24x7@gmail.com>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: oops with USB Storage on 2.6.14
In-Reply-To: <20051030170244.4a8c06b7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0510311055270.13355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2005, Andrew Morton wrote:

> Masanari Iida <standby24x7@gmail.com> wrote:

> > Hello Andrew,
> > 
> > I did disabled CONFIG_DEBUG_PAGEALLOC and re-tested on 2.6.14-rc1.
> > Now the oops didn't happen when I connect digital camera to the USB.
> 
> So the first oops was probably use-after-free.
> 
> > I could mount the camera as USB storage.
> > But oops still happen when I turned the camera power off.
> > (This oops didn't halt my system, BTW)
> > 
> > # Unable to handle kernel paging request at virtual address 6b6b6bb3
> >   printing eip:
> > c02b88ca
> > *pde = 00000000
> > Oops: 0002 [#1]
> > SMP
> > Modules linked in: autofs e100 ipt_LOG ipt_state ip_conntrack
> > ipt_recent iptable_filter ip_tables video rtc
> > CPU:    0
> > EIP:    0060:[<c02b88ca>]    Not tainted VLI
> > EFLAGS: 00010296   (2.6.14-rc1)
> > EIP is at scsi_remove_device+0x3a/0x50

> > If you need some more test, let me know.
> > In that case, please specify which version of kernel you want me to test.
> > 
> 
> OK, thanks.  This is a different bug.  Presumably in USB.

This was fixed in later releases of 2.6.14-rc.

I wasn't able to reproduce the original problem, even after setting 
CONFIG_DEBUG_PAGEALLOC.

Alan Stern

