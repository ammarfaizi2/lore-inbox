Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266019AbUBCTZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUBCTYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:24:08 -0500
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:17043 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S266110AbUBCSpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:45:36 -0500
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: ITE IT8212 (was Re: WG:  EIO DM-8401H ATA133 IDE Controller Card ( Silicon Image Chip ?!?))
Date: Tue, 3 Feb 2004 18:45:25 +0000
User-Agent: KMail/1.5.4
References: <200310301312.52793.srhaque@iee.org> <3FA11F00.9020000@pobox.com>
In-Reply-To: <3FA11F00.9020000@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402031845.33257.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 Oct 2003 14:24, Jeff Garzik wrote:
> Shaheed wrote:
> > Interestingly, EXACTLY the same thing happened to me. I actually bought a
> > vanilla IDE controller for a spare disk, and in what showed up the
> > documentation claimed it was a DM-8401R, but lspci shows what you see:
> > and IT8212.
> >
> > The answer was to get the good stuff from here:
> >
> > http://www.iteusa.com/productInfo/Download.html#IT8212%20ATA133%20Control
> >ler
> >
> > The driver install was a doddle (well documented, and easy to apply
> > Mandrake 9.1 instructions to 9.2). For heavens sake: these guys even
> > provide the specs online. And the driver seems to work, though I am not
> > stressing it.
>
> Neat.  Even though it's a SCSI driver, it's very definitely a standard
> IDE controller, which should be easy for Bart or somebody to add to
> drivers/ide ...

Are you sure about this?  I know the driver uses the discs as a standard IDE 
controller, but then it can deliberately put the chip into a bypass mode.

According to the blurb it is "Different from using traditional software to 
handle the RAID function, IT8212F features one embedded CPU and firmware to 
handle it. The methodology is able to improve the system's stability and 
reduce the driver's loading".  The block diagram shows an embeded CPU.  It is 
also possible, depending on the firmware it is programmed with to make it a 
RAID or ATAPI controller.

http://www.ite.com.tw/pc/brief_it8212f.htm

It's the IT8211 that is the simple IDE controller.

http://www.ite.com.tw/pc/brief_it8211f.htm

Anyway, now I've said that, any more news on it's support?  I'd be very 
interested in trying out any code that may be being developed, especially if 
it will work with x86-64 in long mode.  The current driver from ITE 
definitely and unsurprisingly does not.

-- 
Ian.

