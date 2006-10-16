Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWJPH3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWJPH3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 03:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWJPH3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 03:29:02 -0400
Received: from smtp8.orange.fr ([193.252.22.23]:63467 "EHLO
	smtp-msa-out08.orange.fr") by vger.kernel.org with ESMTP
	id S1030316AbWJPH3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 03:29:01 -0400
X-ME-UUID: 20061016072859698.AA66218000AD@mwinf0801.orange.fr
Subject: Re: Why aren't partitions limited to fit within the device?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Neil Brown <neilb@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       aeb@cwi.nl, Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <17714.52626.667835.228747@cse.unsw.edu.au>
References: <17710.54489.486265.487078@cse.unsw.edu.au>
	 <1160752047.25218.50.camel@localhost.localdomain>
	 <17714.52626.667835.228747@cse.unsw.edu.au>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 09:28:55 +0200
Message-Id: <1160983735.32674.4.camel@frg-rhel40-em64t-03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 10:08 +1000, Neil Brown wrote:
> On Friday October 13, alan@lxorguk.ukuu.org.uk wrote:
> > Ar Gwe, 2006-10-13 am 09:50 +1000, ysgrifennodd Neil Brown:
> > > So:  Is there any good reason to not clip the partitions to fit
> > > within the device - and discard those that are completely beyond
> > > the end of the device??
> > 
> > Its close but not quite the right approach
> > 
> > > The patch at the end of the mail does that.  Is it OK to submit this
> > > to mainline?
> > 
> > No I think not. Any partition which is partly outside the disk should be
> > ignored entirely, that ensures it doesn't accidentally get mounted and
> > trashed by an HPA or similar mixup.
> 
> Hmmm.. So Alan things a partially-outside-this-disk partition
> shouldn't show up at all, and Andries thinks it should.
> And both give reasonably believable justifications.

Maybe the whole part table should be marked as "weird" to let userspace
run a diagnostics/repair tool on the disk.

	Xav

