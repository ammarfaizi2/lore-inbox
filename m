Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130780AbRBAQYS>; Thu, 1 Feb 2001 11:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130802AbRBAQX7>; Thu, 1 Feb 2001 11:23:59 -0500
Received: from ellpspace.math.ualberta.ca ([129.128.207.67]:14922 "EHLO
	ellpspace.math.ualberta.ca") by vger.kernel.org with ESMTP
	id <S130780AbRBAQXs>; Thu, 1 Feb 2001 11:23:48 -0500
Date: Thu, 1 Feb 2001 09:23:42 -0700
From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
To: John Jasen <jjasen@datafoundation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 not fully sane on Alpha - file systems
Message-ID: <20010201092342.B15101@ellpspace.math.ualberta.ca>
In-Reply-To: <20010131234925.A14300@ellpspace.math.ualberta.ca> <Pine.LNX.4.30.0102011039180.31149-100000@flash.datafoundation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.30.0102011039180.31149-100000@flash.datafoundation.com>; from John Jasen on Thu, Feb 01, 2001 at 10:46:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 10:46:12AM -0500, John Jasen wrote:
> On Wed, 31 Jan 2001, Michal Jaegermann wrote:
> 
> > I just tried to boot 2.4.1 kernel on Alpha UP1100.  This machine
> > happens to have two SCSI disks on sym53c875 controller and two IDE
> > drives hooked to a builtin "Acer Laboratories Inc. [ALi] M5229 IDE".
> 
> ALI M1535D pci-ide bridge, isn't it? That's what the specs on
> API's webpage seem to indicate.

'lspci' claims that this is:

"07.0  Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]"

> 
> Try this for fun: dd if=/dev/hda of=/dev/null bs=4096, and see if it
> cronks out.

Probably.

> In my case, any serious I/O on the IDE drives quickly results in pretty
> technicolor on the VGA screen, and then a hard lockup.

No, no technicolor or other sounds effects.  The whole thing just
locks up with a power switch as the only option.

> Furthermore, after power-reset, 2.4.x, x=0 or 1, cannot successfully fsck
> the drives.  It hangs after about the 2nd-3rd partition, again in a hard
> lockup.

My box is much healtier than that.  Regardless if I booted into a file
system on a SCSI drive or on an IDE drive (I happen to have those
options although I prefer IDE - I have there something which I can loose
without any real pain :-) I can still fsck drives healthy after the
crash but I did NOT risk fsck under 2.4.1.  Things looks way too screwy
for this.

> 
> My WAG is that there are problems in the ALI driver.

Possibly, but I crashed the whole thing without mounting anything from
IDE drives at all.  There are still there but unused.  I simply managed
to get something in logs for the case described.  Note that errors
I quoted are from a device 08:05, i.e. SCSI driver (/dev/sda5 to be
more precise).  When my compiler went bonkers and started to read
clearly some random stuff instead of sources then the whole action was
happening on a SCSI drive.

 Michal
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
