Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWBMFBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWBMFBd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWBMFBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:01:33 -0500
Received: from iabervon.org ([66.92.72.58]:28678 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751627AbWBMFBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:01:32 -0500
Date: Mon, 13 Feb 2006 00:01:48 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Greg KH <greg@kroah.com>
cc: Bill Davidsen <davidsen@tmr.com>, Nix <nix@esperi.org.uk>,
       Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060210235654.GA22512@kroah.com>
Message-ID: <Pine.LNX.4.64.0602122256130.6773@iabervon.org>
References: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de>
 <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix>
 <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2006, Greg KH wrote:

> On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> > 
> > The kernel could provide a list of devices by category. It doesn't have 
> > to name them, run scripts, give descriptions, or paint them blue. Just a 
> > list of all block devices, tapes, by major/minor and category (ie. 
> > block, optical, floppy) would give the application layer a chance to do 
> > it's own interpretation.
> 
> It does so today in sysfs, that is what it is there for.

sysfs doesn't do quite that level of categorization; if it did, cdrom_id 
would be unnecessary. It would be nice if you could do 
"grep 1 /sys/block/*/burns_cds" and get a list of all the block devices in 
your system that burn cds. (You can currently get a list of all of the 
removable block devices in your system, but not much else.)

The kernel must know a bunch of this sort of stuff, and it would be nice 
if the information available. (In fact, there's a lot that's in /proc/ide 
that isn't in /sys, which is a bit annoying, since it would be useful in 
/sys, especially if it would mean that you could ignore details of what 
kind of bus things were on.)

	-Daniel
