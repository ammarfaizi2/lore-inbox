Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWAQJzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWAQJzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 04:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWAQJzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 04:55:22 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:59530 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932352AbWAQJzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 04:55:21 -0500
Date: Tue, 17 Jan 2006 10:55:31 +0100
From: Sander <sander@humilis.net>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 005 of 5] md: Final stages of raid5 expand code.
Message-ID: <20060117095531.GB27262@localhost.localdomain>
Reply-To: sander@humilis.net
References: <20060117174531.27739.patches@notabene> <1060117065635.27881@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060117065635.27881@suse.de>
X-Uptime: 10:26:31 up 61 days, 25 min, 10 users,  load average: 2.57, 2.20, 1.86
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote (ao):
> +config MD_RAID5_RESHAPE

Would this also be possible for raid6?

> +	bool "Support adding drives to a raid-5 array (highly experimental)"
> +	depends on MD_RAID5 && EXPERIMENTAL
> +	---help---
> +	  A RAID-5 set can be expanded by adding extra drives. This
> +	  requires "restriping" the array which means (almost) every
> +	  block must be written to a different place.
> +
> +          This option allows this restiping to be done while the array
                                     ^^^^^^^^^
                                     restriping

> +	  is online.  However it is VERY EARLY EXPERIMENTAL code.
> +	  In particular, if anything goes wrong while the restriping
> +	  is happening, such as a power failure or a crash, all the
> +	  data on the array will be LOST beyond any reasonable hope
> +	  of recovery.
> +
> +	  This option is provided for experimentation and testing.
> +	  Please to NOT use it on valuable data with good, tested, backups.
                 ^^                             ^^^^
                 do                             without

Thanks a lot for this feature. I'll try to find a spare computer to test
this on. Thanks!

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
