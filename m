Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbTENIHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTENIHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:07:39 -0400
Received: from holomorphy.com ([66.224.33.161]:40129 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261233AbTENIHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:07:35 -0400
Date: Wed, 14 May 2003 01:20:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       axel@pearbough.net
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514082015.GI2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
	linux-kernel@vger.kernel.org, axel@pearbough.net
References: <20030514004009.GA20914@neon.pearbough.net> <20030514031826.GB29926@holomorphy.com> <493702704.1052892304@aslan.scsiguy.com> <20030514073700.GA3151@beaverton.ibm.com> <20030514075407.GA10685@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514075407.GA10685@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, Mike Anderson wrote:
[...]
>> bounce_pfn: 0xfffff
[...]

That might explain the performance problem reported to me not long
after I posted the thing.

On Wed, May 14, 2003 at 09:54:07AM +0200, Jens Axboe wrote:
> So to recap, aic7xxx will never see a request that exceeds one of the
> above values. Total request size will always be equal to or below 4MiB,
> less than or equal to 128 segments, and will never cross a 4GB memory
> boundary. Memory above pfn 0xfffff (4GB) will be bounced, but this could
> be because that's just the amount of memory the box has you dumped this
> info from.

Hey, I got a bug report of a compile error and dove into bogus-looking
code around it meant to cater to antediluvian kernel versions and the
maintainer's preference for an identical driver across bunches of
kernel versions. I've heard the bit about the midlayer preventing these
conditions entirely a dozen times in the past 2 hours. =(

-- wli
