Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVKIWl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVKIWl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVKIWl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:41:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64018 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030410AbVKIWl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:41:56 -0500
Date: Wed, 9 Nov 2005 22:41:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status
Message-ID: <20051109224133.GB17997@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Ben Collins <bcollins@debian.org>,
	Jody McIntyre <scjody@modernduck.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Roland Dreier <rolandd@cisco.com>,
	Dave Jones <davej@codemonkey.org.uk>, Jens Axboe <axboe@suse.de>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Steven French <sfrench@us.ibm.com>
References: <20051109133558.513facef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109133558.513facef.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 01:35:58PM -0800, Andrew Morton wrote:
> We're at day 12 of the two-week window, time for a quick peek at
> outstanding patches in the subsystem trees.

And I've just committed that patch set to convert platform drivers
to struct platform_driver... which is about 250K.

Anything not converted continues to work as it always used to, so
the only breakage is if I mis-converted something.  However, I've
build-tested allyesconfig on i386, and several ARM configs, and I'm
not aware of any build problems.

This couldn't be submitted earlier because ARM SMP work took
priority, and getting to a stage where the platform_driver stuff
was suitable against the rapidly moving target is rather, err,
time consuming.  Plus, gregkh only recently gave his ack to it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
