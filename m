Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVFKHny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVFKHny (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVFKHny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:43:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:26050 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261482AbVFKHnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:43:51 -0400
Date: Sat, 11 Jun 2005 00:43:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Patch series to remove devfs [00/22]
Message-ID: <20050611074327.GA27785@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As everyone knows[1], devfs is going to be removed from the kernel soon.
To accomplish this, here is a series of patches (22 in all) that do just
that.  Surprisingly enough, devfs was almost everywhere in the kernel,
that's why it takes so many patches :)

Anyway, here's the whole series against 2.6.12-rc6-git4.  If some of
them don't make it through to lkml (due to size restrictions, or just
failing on a "taste" filter), you can find them all at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
along with a quilt series file to apply them with.

Andrew, please do not pick these up for your -mm tree.  Odds are it will
just cause too many conflicts to make it worth your while :)

Comments welcome.

Oh, and the best part?  Here's the summary of the diffstat:

  222 files changed, 112 insertions(+), 8545 deletions(-)

It's nice to remove code from the kernel for a change...

thanks,

greg k-h

[1] What?  You don't know this?  Didn't you get the memo[2]?  Did you
    miss the huge flame war almost a year ago[3]?  Are you living under
    a rock[4]?
[2] http://lxr.linux.no/source/Documentation/feature-removal-schedule.txt
[3] http://thread.gmane.org/gmane.linux.kernel/219278
[4] http://www.balloonplanet.com/shop/images/products/product_1788_small.jpg
