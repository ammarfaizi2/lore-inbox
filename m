Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVKBC40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVKBC40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVKBC4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:56:25 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:57756 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932242AbVKBC4Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:56:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jRScFGdxdiDlu/yqXXlfeIe4f/IBtcHZB9Oa+i2l1iek3d1wYmgYTou4t0wGUESRWGMgdJZH/ewVRoMcUmO2QrP+c51IBdf76uyLYmBzr5SHwlMMKihNfQtIkaGL6P059L8DIOU2stYwxzH//uKNl/7SlZc93lMHeh/W7INqvk8=
Message-ID: <38bdcd1f0511011856i3780bf55q3013956dc7e06e3e@mail.gmail.com>
Date: Wed, 2 Nov 2005 11:56:24 +0900
From: Masanari Iida <standby24x7@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: oops with USB Storage on 2.6.14
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0510311055270.13355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051030170244.4a8c06b7.akpm@osdl.org>
	 <Pine.LNX.4.44L0.0510311055270.13355-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 30 Oct 2005, Andrew Morton wrote:
>
> > Masanari Iida <standby24x7@gmail.com> wrote:
>
> > > Hello Andrew,
> > >
> > > I did disabled CONFIG_DEBUG_PAGEALLOC and re-tested on 2.6.14-rc1.
> > > Now the oops didn't happen when I connect digital camera to the USB.
> >
> > So the first oops was probably use-after-free.
> >
> > > I could mount the camera as USB storage.
> > > But oops still happen when I turned the camera power off.
> > > (This oops didn't halt my system, BTW)
> > >
> > > # Unable to handle kernel paging request at virtual address 6b6b6bb3
> > >   printing eip:
> > > c02b88ca
> > > *pde = 00000000
> > > Oops: 0002 [#1]
> > > SMP
> > > Modules linked in: autofs e100 ipt_LOG ipt_state ip_conntrack
> > > ipt_recent iptable_filter ip_tables video rtc
> > > CPU:    0
> > > EIP:    0060:[<c02b88ca>]    Not tainted VLI
> > > EFLAGS: 00010296   (2.6.14-rc1)
> > > EIP is at scsi_remove_device+0x3a/0x50
>
> > > If you need some more test, let me know.
> > > In that case, please specify which version of kernel you want me to test.
> > >
> >
> > OK, thanks.  This is a different bug.  Presumably in USB.
>
> This was fixed in later releases of 2.6.14-rc.
>
> I wasn't able to reproduce the original problem, even after setting
> CONFIG_DEBUG_PAGEALLOC.
>
> Alan Stern
>
Alan,

Confirm the " scsi_remove_device " oops didn't happen on 2.4.14.
Talking about the original PANIC, as I have a workaround
(CONFIG_DEBUG_PAGEALLOC disabled),  I agree to close my report, now.

Thank you.

Masanari Iida
