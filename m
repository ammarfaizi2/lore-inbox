Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUGICJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUGICJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUGICJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:09:15 -0400
Received: from holomorphy.com ([207.189.100.168]:5609 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262744AbUGICJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:09:10 -0400
Date: Thu, 8 Jul 2004 19:09:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-ID: <20040709020905.GT21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <20040708023001.GN21066@holomorphy.com> <m2briq7izk.fsf@telia.com> <20040708193956.GO21066@holomorphy.com> <40EDED5D.80605@yahoo.com.au> <20040709015317.GR21066@holomorphy.com> <40EDFDBE.5040805@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EDFDBE.5040805@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> They added a flag indicating wiredness or no to the gfp_mask, which was
>> then propagated down the call chain and eventually passed as an argument
>> to out_of_memory(). In turn, out_of_memory() used the flag to determine
>> whether the nr_swap_pages > 0 check was relevant. i.e. they refined the
>> OOM conditions based on the wiredness of the failing allocation. What
>> probably got the stuff permavetoed was the stats reporting I did along
>> with it that would have been trivial to drop while retaining the needed
>> functional change. The patch was motivated by the nr_swap_pages > 0
>> check deadlocking. The __GFP_WIRED business was done to discriminate
>> the obvious deadlocking scenario from the false OOM mentioned here.

On Fri, Jul 09, 2004 at 12:06:54PM +1000, Nick Piggin wrote:
> No, I did see those patches. I'm not saying they're not worth
> persuing; on the contrary, they look quite interesting. However,
> it might worthwhile looking at more basic things first, for this
> problem anyway.

Enumerate those more basic things.


-- wli
