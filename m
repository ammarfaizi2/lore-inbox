Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVBVVKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVBVVKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVBVVKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:10:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15295 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261247AbVBVVKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:10:36 -0500
Subject: Re: cfq: depth 4 reached, tagging now on
From: Lee Revell <rlrevell@joe-job.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050221082044.GW4056@suse.de>
References: <1108846748.10705.31.camel@krustophenia.net>
	 <20050221082044.GW4056@suse.de>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 16:10:32 -0500
Message-Id: <1109106633.31071.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-21 at 09:20 +0100, Jens Axboe wrote:
> On Sat, Feb 19 2005, Lee Revell wrote:
> > Starting around 2.6.11-rc4 I get this printk during the boot process
> > after kjournald starts, and again if I stress the filesystem.
> > 
> > cfq: depth 4 reached, tagging now on
> > 
> > Is this printk intentional?  I am sure users will wonder about it,
> > especially because (presumably) cfq turns tagging off at some point in
> > between, and doesn't say anything about it.
> 
> It is intentional, but could be supressed. But I'm wondering if the
> accounting change introduced a bug - what hardware are you using cfq on
> (ie does it actually do tagged command queueing, is it SCSI?)?
> 

Yes, this is an all SCSI system using the aic7xxx driver.

> It's a one-time message. CFQ starts out assuming the drive doesn't do
> TCQ, if the driver depth goes beyond a defined limit (4), it will assume
> that the hardware can do tagged queueing and change its internal
> accounting accordingly. The setting stays that way, it's not a
> transitional state.
> 


OK.  Then the multiple messages were CFQ enabling TCQ for the different
drives.

Lee

