Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUIKAvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUIKAvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268069AbUIKAvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:51:15 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:45037 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268060AbUIKAuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:50:44 -0400
Date: Sat, 11 Sep 2004 01:50:03 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094853588.18235.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0409110137590.26651@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet> <1094853588.18235.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> We've addressed this before. Zillions of drivers provide multiple
> functions to multiple higher level subsystems. They don't all have to
> be compiled together to make it work.
>
> 2D and 3D _are_ to most intents and purposes different functions. They
> are as different as IDE CD and IDE disk if not more so.

So the IDE-CD driver and IDE-disk drivers both program registers on the
IDE controller directly.. oh no the ide driver seems to do that.. this is
FUD, a graphics card is a device, singular one device, it requires one
device driver, the device driver should provide control over the device
and be the only one to program its registers.. it can provide services to
who ever wants services, be it a 2D console driver or a 3D client or a 4D
super-time-travelling application,

I can't write a user space IDE driver and still expect the kernel one to
be happy, I can't write a second IDE driver for a chipset for formatting
disks and expect the normal kernel driver to stay working with it, why do
people think graphics driver are meant to be different..

Alan, I agree with how you want to proceed with this, and keep things
stable, but anything short of a single card-specific driver looking after
the registers and DMA queueing and locking is going to have deficiencies
and the DRM has a better basis than the fb drivers,

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

