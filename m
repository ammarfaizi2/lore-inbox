Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWB0OG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWB0OG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWB0OG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:06:28 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:35542 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751149AbWB0OG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:06:27 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: o_sync in vfat driver
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1141048228.2992.106.camel@laptopd505.fenrus.org>
References: <op.s5cj47sxj68xd1@mail.piments.com>
	 <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com>
	 <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com>
	 <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com>
	 <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com>
	 <20060227132848.GA27601@csclub.uwaterloo.ca>
	 <1141048228.2992.106.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 27 Feb 2006 14:06:15 +0000
Message-Id: <1141049176.18855.4.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 14:50 +0100, Arjan van de Ven wrote:
> On Mon, 2006-02-27 at 08:28 -0500, Lennart Sorensen wrote:
> > On Sun, Feb 26, 2006 at 11:50:40PM +0100, col-pepper@piments.com wrote:
> > > Hi,
> > > 
> > > OMG what do I have to do to post here? 10th attempt.
> > > {part2}
> > > 
> > > Here is a non-exhaustive list of typical devices types requiring fat vfat
> > > support:
> > > 
> > > fd ide-hd scsi-hd usb-hd cdrom usb-hd usb-handheld (iPod, iRiver etc)
> > > usb-flash (usbsticks, cameras, some music devices.)
> > > 
> > > IIRC the sync mount option for vfat is ignored for file systems >2G, this
> > > effectively (and probably intentionally) excludes nearly all hd partitions
> > > and iPod type devices.
> > 
> > I think many people wish it was ignored on smaller devices too given
> > what it does to write performance.
> 
> well. If you don't want it *DO NOT USE IT AT THE MOUNT COMMAND LINE* !!!

That is easy to say when you are using the command line...  Modern
distros (as you know I am sure) mount all hot-plug devices like usb
keys, usb hard disks, etc automatically at plug-in time and at least
some distros use "-o sync" for everything so you don't get (too much)
data loss when the user unplugs a device and so a umount to unplug the
device does not take ages...

Being someone who maintains a distribution based on one of the big
distributions I can tell you that figuring out how to change that
default behaviour is not always pretty.  Usually involves hacking files
deep in the bowels of the hotplug framework on the system.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

