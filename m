Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUJTRCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUJTRCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268713AbUJTRCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:02:31 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:22702 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268693AbUJTRBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:01:49 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Pavel Machek <pavel@ucw.cz>
Date: Wed, 20 Oct 2004 10:01:27 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <41763777.26324.1B3B684C@localhost>
In-reply-to: <20041019214818.GF1142@elf.ucw.cz>
References: <41740384.5783.12A07B14@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> > Open Firmware may be a 'nicer' solution, but I guarantee that if the 
> > vendors started supporting that it would be just a bug ridden as any 16-
> > bit real mode BIOS code. For the Video BIOS the code always works for 
> > what it is tested for. Some vendors spend more time testing the VBE BIOS 
> > side of things fully (if they are smart they have licensed our VBETest 
> > tools for this purpose). Unfortunatley some vendors do not test this 
> > stuff thoroughly and it has problems. But the same testing issues would 
> > exist whether the firmware was written as a 16-bit x86 blob or as an Open 
> > Firmware blob.
> 
> Actually that 16-bit x86 blob can access any PC hardware, and that's
> where the stuff gets hard.

Yes, but there is only a very small set of PC hardware features you need 
to implement, and most BIOS'es only look at those things for timing 
purposes. Unfortunately there is no standard for how BIOS'es do internal 
timing and delay loops, so we emulate them all (8253 timers, speaker 
ports and CMOS time/date support ;-).

When we come across a new card that doesn't work we figure out why and 
make new additions to the video boot code. However at this point we think 
we have covered just about every card out there, as I don't think there 
are any cards in our labs that don't work at present. If there are, 
fixing them is just a matter of spending the time to debug it.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


