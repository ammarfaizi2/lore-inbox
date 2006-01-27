Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWA0Wux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWA0Wux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWA0Wux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:50:53 -0500
Received: from utter.chaos.org.uk ([193.201.201.153]:64193 "EHLO
	utter.chaos.org.uk") by vger.kernel.org with ESMTP id S1422637AbWA0Wun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:50:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17370.41898.363131.594754@utter.chaos.org.uk>
Date: Fri, 27 Jan 2006 22:50:18 +0000
To: Jens Axboe <axboe@suse.de>
Cc: askernel2615@dsgml.com, Chase Venters <chase.venters@clientec.com>,
       Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, akpm@osdl.org, a.titov@host.bg,
       jamie@audible.transient.net
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
In-Reply-To: <20060127200635.GE9068@suse.de>
References: <200601270410.06762.chase.venters@clientec.com>
	<17369.65530.747867.844964@cse.unsw.edu.au>
	<20060127112352.GF4311@suse.de>
	<20060127112837.GG4311@suse.de>
	<43DA6F33.3070101@cs.wisc.edu>
	<1138389616.3293.13.camel@mulgrave>
	<43DA787F.4080406@cs.wisc.edu>
	<20060127194927.GB9068@suse.de>
	<Pine.LNX.4.64.0601271351070.9232@turbotaz.ourhouse>
	<Pine.LNX.4.62.0601271501300.8977@pureeloreel.qftzy.pbz>
	<20060127200635.GE9068@suse.de>
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Tim Morley <tim@chaos.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes ("Re: More information on scsi_cmd_cache leak... (bisect)"):
> On Fri, Jan 27 2006, askernel2615@dsgml.com wrote:
> > Mine is also 2.6.15. Stock with debian patches.
> > 
> > In fact I believe ALL the reports are from 2.6.15.
> 
> Hmm so does it happen in 2.6.16-rc1 or not? And try the suggestion I
> made in the other, edit the sata driver for your device and set
> ordered_flush to 0 instead of 1.

FYI I've had the problem with 2.6.15 and 2.6.15.1. I'm using raid1 and
raid5 on 4 sata drives with an ICH7 controller on an ASUS P5LD2-VM.

I've just got a 2.6.16-rc1 built and it seems that it fixes it! My
scsi_cmd_cache is setting happily at 10 allocations and not moving.

Tim Morley
