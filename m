Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030595AbWBNTBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbWBNTBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWBNTBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:01:43 -0500
Received: from mail.tmr.com ([64.65.253.246]:8973 "EHLO firewall2.tmr.com")
	by vger.kernel.org with ESMTP id S1030596AbWBNTBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:01:43 -0500
Date: Tue, 14 Feb 2006 14:01:15 -0500 (EST)
From: Bill Davidsen <tmrbill@tmr.com>
Reply-To: davidsen@tmr.com
To: Greg KH <greg@kroah.com>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, <davidsen@tmr.com>,
       <nix@esperi.org.uk>, <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060213154921.GA22597@kroah.com>
Message-ID: <Pine.LNX.4.44.0602141356550.7951-100000@firewall2.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Greg KH wrote:

> On Mon, Feb 13, 2006 at 02:26:54PM +0100, Joerg Schilling wrote:
> > Greg KH <greg@kroah.com> wrote:
> > 
> > > On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> > > > 
> > > > The kernel could provide a list of devices by category. It doesn't have 
> > > > to name them, run scripts, give descriptions, or paint them blue. Just a 
> > > > list of all block devices, tapes, by major/minor and category (ie. 
> > > > block, optical, floppy) would give the application layer a chance to do 
> > > > it's own interpretation.
> > >
> > > It does so today in sysfs, that is what it is there for.
> > 
> > Do you really whant libscg to open _every_ non-directory file under /sys?
> 
> Of course not.  Here's one line of bash that gets you the major:minor
> file of every block device in the system:
> 	block_devices="$(echo /sys/block/*/dev /sys/block/*/*/dev)"
> 
> The block devices are all in a specific location.
> 
> And here's a way to get the cdroms of the system:
	[snip]
> 
> If you want to do this in C, there is a libsysfs, which should help you
> out a bit on intregrating sysfs support into your program (although udev
> has recently ripped it out and replaced it with 200 lines of code that
> is way smaller and much faster...)
> 
> Hope this helps,

Just determined that at least in FC4 the udev stuff doesn't seem to create 
the sg devices, cdrecord doesn't work with devices which use the scsi 
interface AFAIK, fails with USB, Firewire, and real SCSI devices.

I'm still looking at this, trying w/o udev.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
Doing interesting things with little computers since 1979

