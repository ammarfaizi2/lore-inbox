Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWCBIcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWCBIcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWCBIcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:32:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26289 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751224AbWCBIcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:32:17 -0500
Date: Thu, 2 Mar 2006 09:32:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: col-pepper@piments.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: o_sync in vfat driver
Message-ID: <20060302083200.GO1879@elf.ucw.cz>
References: <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com> <op.s5nm6rm5j68xd1@mail.piments.com> <20060228223855.GC5831@elf.ucw.cz> <op.s5r1koxmj68xd1@mail.piments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <op.s5r1koxmj68xd1@mail.piments.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-03-06 09:23:02, col-pepper@piments.com wrote:
> On Tue, 28 Feb 2006 23:38:55 +0100, Pavel Machek <pavel@suse.cz> wrote:
> 
> >On Út 28-02-06 00:21:53, col-pepper@piments.com wrote:
> >>On Mon, 27 Feb 2006 22:32:07 +0100, linux-os (Dick Johnson)
> >><linux-os@analogic.com> wrote:
> >>
> >>> Flash does not get zeroed to be written! It gets erased, which sets  
> >>all
> >>> the bits to '1', i.e., all bytes to 0xff.
> >>
> >>Thanks for the correction, but that does not change the discussion.
> >>
> >>> Further, the designers of
> >>> flash disks are not stupid as you assume. The direct access occurs
> >>> to static RAM (read/write stuff).
> >>
> >>I'm not assuming anything . Some hardware has been killed by this issue.
> >>http://lkml.org/lkml/2005/5/13/144
> >
> >I have seen flash disk dead in 5 minutes, even without o-sync. Those
> >devices are often crap. (I copied tar file to flash by cat foo.tar >
> >/dev/sda. That was apparently enough to kill that flash. Label "Yahoo"
> >should have warned me).
> 
> If I'm not mistaken, writing to the device with cat will output that file  
> byte by byte. This would probably be even harder on the device than using  
> a formatted device with o_sync, since it would dirty a 64k block 64k
> times!

No.

> It seems some of the less elaborate devices dont support this type of use.
> 
> I suspect if you had tried using dd with a suitable bs you may still own a  
> crap Yahoo usb device.
> 
> Just because the linux kernel lets us use the abstract /dev devices freely  
> does not mean everything you can do with a /dev is a good idea for all h/w  
> that gets a device name.
> 
> I think that is the heart of the problem. Manufacturers are designing  
> these devices for the windows market. They are specifically designed and  
> supplied, preformatted with a fat fs, to be used in that way.

There's USB mass storage specification, that says nothing about FAT,
or expected use of the device... if your device is broken FAT thing
that will break if used any other way, do not advertise it as USB mass
storage.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
