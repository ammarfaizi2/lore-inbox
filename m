Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWBMRwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWBMRwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBMRwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:52:06 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:22181
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932136AbWBMRwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:52:04 -0500
Date: Mon, 13 Feb 2006 09:51:42 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Nix <nix@esperi.org.uk>,
       Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213175142.GB20952@kroah.com>
References: <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <Pine.LNX.4.64.0602122256130.6773@iabervon.org> <20060213062158.GA2335@kroah.com> <Pine.LNX.4.64.0602130244500.6773@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602130244500.6773@iabervon.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 03:05:49AM -0500, Daniel Barkalow wrote:
> On Sun, 12 Feb 2006, Greg KH wrote:
> 
> > On Mon, Feb 13, 2006 at 12:01:48AM -0500, Daniel Barkalow wrote:
> > > sysfs doesn't do quite that level of categorization; if it did, cdrom_id 
> > > would be unnecessary.
> > 
> > What?  cdrom_id queries the device directly to get some specific
> > information about the device, much like any other type of device query
> > (lspci, lsusb, etc.)
> > 
> > And yes, it would be nice if some of that information was also exported
> > through sysfs, and as always, patches are gladly accpeted.
> 
> Are there guidelines on having a generic cdrom export information from its 
> block interface, rather than through its bus? I'm not finding any 
> documentation of sys/block/, aside from that it exists.

That information should go into the device directory, not the sys/block
directory (as it referrs to the device attributes, not the block gendev
attributes.)

thanks,

greg k-h
