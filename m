Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUFXV3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUFXV3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUFXV3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:29:50 -0400
Received: from havoc.gtf.org ([216.162.42.101]:13232 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265654AbUFXVZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:25:43 -0400
Date: Thu, 24 Jun 2004 17:25:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: Jeremy Katz <jeremy.katz@gmail.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       katzj@redhat.com
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Message-ID: <20040624212537.GB1265@havoc.gtf.org>
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com> <20040618151753.GA21596@infradead.org> <cb5afee1040620125272ab9f06@mail.gmail.com> <20040621060435.GA28384@kroah.com> <cb5afee10406210914451dc6@mail.gmail.com> <cb5afee10406231415293e90c0@mail.gmail.com> <20040623220303.GD6548@kroah.com> <40DA2272.8050106@pobox.com> <20040624205936.GA2009@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624205936.GA2009@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 01:59:37PM -0700, Greg KH wrote:
> Could we determine this in 2.4?

Yes -- by each driver exporting its own procfs node, with its own
private format different from all the others :)


> Anyway, how about this assuming sx8 is a pci driver:
> 	- look in /sys/bus/pci/drivers/sx8/
> 	- for every device listed in that directory do:
> 		- `tree | grep block` or however you want to search the
> 		  tree for the block symlink, find is probably nicer
> 		  here.
> 		- that gives you the base block device, then go into the
> 		  /sys/block/FOUND_BLOCK_DEVICE to find the individual
> 		  partitions if needed.
> 
> Or work backwards if you want to:
> 	- tally up every /sys/block/*/device symlink, and see if they
> 	  point to a device owned by the sx8 driver.
> 
> Does that work for you?

Jeremy?

	Jeff



