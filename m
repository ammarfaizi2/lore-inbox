Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422836AbWBNWXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422836AbWBNWXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422837AbWBNWXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:23:04 -0500
Received: from smtp.enter.net ([216.193.128.24]:55048 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1422836AbWBNWXB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:23:01 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 17:32:12 -0500
User-Agent: KMail/1.8.1
Cc: greg@kroah.com, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       davidsen@tmr.com, axboe@suse.de
References: <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060213154921.GA22597@kroah.com> <43F22887.nailCA4XYHC4@burner>
In-Reply-To: <43F22887.nailCA4XYHC4@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602141732.13067.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 13:59, Joerg Schilling wrote:
> Greg KH <greg@kroah.com> wrote:
> > On Mon, Feb 13, 2006 at 02:26:54PM +0100, Joerg Schilling wrote:
> > > Greg KH <greg@kroah.com> wrote:
> > > > On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> > > > > The kernel could provide a list of devices by category. It doesn't
> > > > > have to name them, run scripts, give descriptions, or paint them
> > > > > blue. Just a list of all block devices, tapes, by major/minor and
> > > > > category (ie. block, optical, floppy) would give the application
> > > > > layer a chance to do it's own interpretation.
> > > >
> > > > It does so today in sysfs, that is what it is there for.
> > >
> > > Do you really whant libscg to open _every_ non-directory file under
> > > /sys?
> >
> > Of course not.  Here's one line of bash that gets you the major:minor
> > file of every block device in the system:
> > 	block_devices="$(echo /sys/block/*/dev /sys/block/*/*/dev)"
> >
> > The block devices are all in a specific location.
>
> Are you sure you understand the problem?
>
> It isd most unlikely that all SCSI devices are there.
>
> Jörg

Which is why there is also /sys/class/scsi_host and /sys/class/scsi_device
those two, together with the block device data available via /sys/block should 
be enough to enumerate every ATAPI and SCSI device on the system.

DRH
