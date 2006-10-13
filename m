Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWJMOlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWJMOlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWJMOlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:41:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30340 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750936AbWJMOls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:41:48 -0400
Subject: Re: Why aren't partitions limited to fit within the device?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <17710.54489.486265.487078@cse.unsw.edu.au>
References: <17710.54489.486265.487078@cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 16:07:27 +0100
Message-Id: <1160752047.25218.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 09:50 +1000, ysgrifennodd Neil Brown:
> So:  Is there any good reason to not clip the partitions to fit
> within the device - and discard those that are completely beyond
> the end of the device??

Its close but not quite the right approach

> The patch at the end of the mail does that.  Is it OK to submit this
> to mainline?

No I think not. Any partition which is partly outside the disk should be
ignored entirely, that ensures it doesn't accidentally get mounted and
trashed by an HPA or similar mixup.

I agree it should be fixed, I just don't think your fix is actually a
real fix in this case.

