Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbUCCAnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbUCCAnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:43:19 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:39881 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262302AbUCCAnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:43:17 -0500
Message-ID: <40452AB3.2060400@myrealbox.com>
Date: Tue, 02 Mar 2004 16:45:39 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040302
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.x]  USB Zip drive kills ps2 mouse.
References: <20040301122450.69a1f36e.rddunlap@osdl.org> <20040301215851.737c433d.rddunlap@osdl.org>
In-Reply-To: <20040301215851.737c433d.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> | From: walt
> | To: Linux Kernel <linux-kernel@vger.kernel.org>
> | Subject: [2.6.x]  USB Zip drive kills ps2 mouse.
> | 
> | 
> | Could I ask anyone with a USB Zip drive and a ps2 mouse to try
> | to confirm this bizarre bug for me?
> | 
> | To reproduce it should be simple:
> | 
> | 1)  Compile USB support as modular, *not* compiled in.
> | 
> | 2)  The USB Zip drive *must* be plugged in during boot.
> |      This bug won't show if you plug in the drive later.
> | 
> | 3)  Reboot and see if your ps2 mouse works.
> 
> Hi,
> 
> I'm not seeing a problem with this.  I'm using 2.6.4-rc1.
> 
> However, you didn't mention what modules were being loaded
> automatically, so we could have a difference in that area.
> If you care to specify a module list, I can test it again.
> 
> And is your USB Zip drive on a UHCI or OHCI controller?
> I have both, so I can test it either way.

I've narrowed it down to the uhci_hcd module -- all the rest can
be compiled in or as modules, doesn't matter.

Just in case I was vague:  the Zip drive works great regardless --
it's only the ps2 mouse which is affected by this weird problem.
No cursor movement at all if the Zip is plugged in during boot.

ASUS A7V8X mobo, in case it matters:
00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)

Things that make no difference to this problem:  ACPI, PnP, udev versus devfs.
I'm also using 2.6.4-rc1.  I have not tested for this bug on any 2.6.x prior
to a week ago, but I have tried recent 2.4.x kernels and I do not see this bug
with them.

Thanks for any suggestions!
