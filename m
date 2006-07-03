Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWGCUsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWGCUsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWGCUsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:48:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62481 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932098AbWGCUsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:48:36 -0400
Date: Mon, 3 Jul 2006 21:48:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] Build mmc_block into mmc_core directly
Message-ID: <20060703204830.GA24978@flint.arm.linux.org.uk>
Mail-Followup-To: Randy Dunlap <randy.dunlap@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <44A98210.2060208@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A98210.2060208@oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 01:46:08PM -0700, Randy Dunlap wrote:
> Build mmc_block into mmc_core directly.
> 
> Bug Reference:
> https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/30335

NAK.  If it's missing the modalias then it needs to be added.  But more
the question is why isn't the driver being automatically loaded.
Probably because hotplug doesn't know enough about the MMC subsystem.
Unfortunately I'm at rather a loss what's required with hotplug because
it isn't something I actually use or come into contact with.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
