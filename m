Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUFDJ7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUFDJ7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbUFDJ7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:59:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4237 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264401AbUFDJ7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:59:03 -0400
Date: Fri, 4 Jun 2004 11:59:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Rick Jansen <rick@rockingstone.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
Message-ID: <20040604095900.GO1946@suse.de>
References: <20040604075448.GK18885@web1.rockingstone.nl> <200406040943.i549h2aG000175@81-2-122-30.bradfords.org.uk> <20040604095409.GL18885@web1.rockingstone.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604095409.GL18885@web1.rockingstone.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2004, Rick Jansen wrote:
> On Fri, Jun 04, 2004 at 10:43:02AM +0100, John Bradford wrote:
> > Please post more information.  First, what size is the disk?
> > 
> > The LBAsect number suggests an access around 108 Gb.  If the disk is smaller
> > than this, then it would appear that a request was made for a non-existant
> > sector.
> > 
> > Is the LBAsect number the same in each error?  What is the machine doing
> > when the errors occur?
> > 
> > John.
> 
> Here's some more information about the disk from the boot log.
> I also found some StatusErrors in there.
> 
> May 10 11:14:07 web3 kernel: hda: Maxtor 6Y120P0, ATA DISK drive
> May 10 11:14:07 web3 kernel: hda: max request size: 128KiB
> May 10 11:14:07 web3 kernel: hda: 240121728 sectors (122942 MB)
> w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
> May 10 11:14:07 web3 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> May 10 11:14:07 web3 kernel: hda: task_no_data_intr: status=0x51 {
> DriveReady SeekComplete Error }
> May 10 11:14:07 web3 kernel: hda: task_no_data_intr: error=0x04 {
> DriveStatusError }
> May 10 11:14:07 web3 kernel: hda: Write Cache FAILED Flushing!
> 
> Thats a different error then what it gives me occasionaly. Googling this
> error lead me to believe this is a bug in the ide driver, that my disk
> doesnt support some flush command.

It is, what kernel are you using?

-- 
Jens Axboe

