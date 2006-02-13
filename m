Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWBMIFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWBMIFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWBMIFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:05:37 -0500
Received: from iabervon.org ([66.92.72.58]:18447 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751217AbWBMIFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:05:35 -0500
Date: Mon, 13 Feb 2006 03:05:49 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Greg KH <greg@kroah.com>
cc: Bill Davidsen <davidsen@tmr.com>, Nix <nix@esperi.org.uk>,
       Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060213062158.GA2335@kroah.com>
Message-ID: <Pine.LNX.4.64.0602130244500.6773@iabervon.org>
References: <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de>
 <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix>
 <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com>
 <Pine.LNX.4.64.0602122256130.6773@iabervon.org> <20060213062158.GA2335@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2006, Greg KH wrote:

> On Mon, Feb 13, 2006 at 12:01:48AM -0500, Daniel Barkalow wrote:
> > sysfs doesn't do quite that level of categorization; if it did, cdrom_id 
> > would be unnecessary.
> 
> What?  cdrom_id queries the device directly to get some specific
> information about the device, much like any other type of device query
> (lspci, lsusb, etc.)
> 
> And yes, it would be nice if some of that information was also exported
> through sysfs, and as always, patches are gladly accpeted.

Are there guidelines on having a generic cdrom export information from its 
block interface, rather than through its bus? I'm not finding any 
documentation of sys/block/, aside from that it exists.

> > It would be nice if you could do 
> > "grep 1 /sys/block/*/burns_cds" and get a list of all the block devices in 
> > your system that burn cds. (You can currently get a list of all of the 
> > removable block devices in your system, but not much else.)
> 
> Well, I can see if they are disks or cdroms through sysfs quite easily,
> removable or not, so you do get more information than you expect.

Ah, okay, this is in the current -rcs. I was only looking at 2.6.15 (and 
before), which is too old.

	-Daniel
*This .sig left intentionally blank*
