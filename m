Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946146AbWKJJWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946146AbWKJJWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946148AbWKJJWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:22:36 -0500
Received: from brick.kernel.dk ([62.242.22.158]:7797 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1946146AbWKJJWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:22:35 -0500
Date: Fri, 10 Nov 2006 10:24:57 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Brent Baccala <cosine@freesoft.org>, linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
Message-ID: <20061110092456.GO4527@kernel.dk>
References: <20061105121522.GC13555@kernel.dk> <000001c701e9$a1435260$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c701e9$a1435260$ff0da8c0@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06 2006, Chen, Kenneth W wrote:
> I haven't done the measurement whether the time to submit I/O grows
> linearly with respect to I/O size.  Most likely it will.  If it is
> not, then we might have a scaling problem (though I don't believe we
> have this problem).

I would not expect it to, but ran a simple test to check submission
times from 32KiB to 2MiB:

Size		Time (usecs)
----------------------------
2MiB		223
1MiB		112
512KiB		 56
256KiB		 29
128KiB		 14
32KiB		  4

(note that I skipped 64KiB, things got boring). That clearly shows a
linear increase in time, so no scaling problem there.

-- 
Jens Axboe

