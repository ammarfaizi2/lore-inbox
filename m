Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422937AbWJOXu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422937AbWJOXu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 19:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422948AbWJOXu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 19:50:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:29420 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422937AbWJOXu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 19:50:26 -0400
From: Neil Brown <neilb@suse.de>
To: vherva@vianova.fi
Date: Mon, 16 Oct 2006 09:50:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17714.51511.845336.721450@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
In-Reply-To: message from Ville Herva on Sunday October 15
References: <17710.54489.486265.487078@cse.unsw.edu.au>
	<20061015082921.GC22674@vianova.fi>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 15, vherva@vianova.fi wrote:
> On Fri, Oct 13, 2006 at 09:50:49AM +1000, you [Neil Brown] wrote:
> > 
> > Hi,
> >  I was looking into an issue that someone was having with raid5.
> > They made an md/raid5 out of 5 whole devices and by luck the data
> > that was written to the first block of the 5th device looked
> > slightly like a partition table.  fdisk output below for the curious.
> > However some partitions were beyond the end of the device.
> 
> That reminds me of an old long-standing mystery I had with a machine that
> had a RAID-5 of three whole devices. 
> 
> I wonder if there's ever a change the kernel partition detection code could
> _write_ on the disk, even when there's really no partition table?

No, kernel partition detection never writes.

I can't imagine what could have been causing your very-interesting
corruption.  However as it was only demonstrated on old code and
cannot be explored further, I suspect we just have to forget it and
move one :-(

NeilBrown
