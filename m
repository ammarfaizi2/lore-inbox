Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWHRHBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWHRHBV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWHRHBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:01:21 -0400
Received: from brick.kernel.dk ([62.242.22.158]:10299 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750760AbWHRHBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:01:20 -0400
Date: Fri, 18 Aug 2006 09:03:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Message-ID: <20060818070314.GE798@suse.de>
References: <17633.2524.95912.960672@cse.unsw.edu.au> <20060815010611.7dc08fb1.akpm@osdl.org> <20060815230050.GB51703024@melbourne.sgi.com> <17635.60378.733953.956807@cse.unsw.edu.au> <20060816231448.cc71fde7.akpm@osdl.org> <20060818001102.GW51703024@melbourne.sgi.com> <20060817232942.c35b1371.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817232942.c35b1371.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17 2006, Andrew Morton wrote:
> It seems that the many-writers-to-different-disks workloads don't happen
> very often.  We know this because
> 
> a) The 2.4 performance is utterly awful, and I never saw anybody
>    complain and

Talk to some of the people that used DVD-RAM devices (or other
excruciatingly slow writers) on their system, and they would disagree
violently :-)

It's been discussed here on lkml many times in the past, but that's
years behind us now. Thankfully your pdflush work got rid of that
embarassment. But it definitely does matter, to real ordinary users.

-- 
Jens Axboe

