Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262226AbSIZHSH>; Thu, 26 Sep 2002 03:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262227AbSIZHSH>; Thu, 26 Sep 2002 03:18:07 -0400
Received: from holomorphy.com ([66.224.33.161]:2980 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262226AbSIZHSG>;
	Thu, 26 Sep 2002 03:18:06 -0400
Date: Thu, 26 Sep 2002 00:23:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: axboe@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org,
       patman@us.ibm.com, andmike@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926072318.GK3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, axboe@suse.de, akpm@digeo.com,
	linux-kernel@vger.kernel.org, patman@us.ibm.com, andmike@us.ibm.com
References: <20020926064455.GC12862@suse.de> <20020926065951.GD12862@suse.de> <20020926070615.GX22942@holomorphy.com> <20020926.000620.27781675.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020926.000620.27781675.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 26 Sep 2002 00:06:15 -0700
>    Hmm, qlogicisp.c isn't really usable because the disks are too
>    slow, it needs bounce buffering, and nobody will touch the driver

On Thu, Sep 26, 2002 at 12:06:20AM -0700, David S. Miller wrote:
> I think it's high time to blow away qlogic{fc,isp}.c and put
> Matt Jacob's qlogic stuff into 2.5.x

Is this different from the v61b5 stuff? I can test it on my qla2310
and ISP1020 if need be.

The main issue with qlogicisp.c is that it's just not modern enough to
keep up with the rest of the system so testing with it is basically a
stress test for how things hold up with lots of highmem, lots of bounce
buffering and with a severely limited ability to perform disk I/O.

qlogicisp.c is also not very reflective of the hardware used in NUMA-Q
systems in the field, it just happened to be available from the scrap heap.


Thanks,
Bill
