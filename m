Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbUKVWxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbUKVWxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKVWvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:51:47 -0500
Received: from holomorphy.com ([207.189.100.168]:60829 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261177AbUKVWtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:49:11 -0500
Date: Mon, 22 Nov 2004 14:43:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041122224333.GI2714@holomorphy.com>
References: <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au> <20041119225701.0279f846.akpm@osdl.org> <419EEE7F.3070509@yahoo.com.au> <1834180000.1100969975@[10.10.2.4]> <Pine.LNX.4.58.0411200911540.20993@ppc970.osdl.org> <20041120190818.GX2714@holomorphy.com> <Pine.LNX.4.58.0411201112200.20993@ppc970.osdl.org> <20041120193325.GZ2714@holomorphy.com> <Pine.LNX.4.58.0411220932270.22144@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411220932270.22144@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2004, William Lee Irwin III wrote:
>> I'm not particularly "stuck on" the per-cpu business, it was merely the
>> most obvious method of splitting the RSS counter without catastrophes
>> elsewhere. Robin Holt's 2.4 performance studies actually show that
>> splitting the counter is not even essential.

On Mon, Nov 22, 2004 at 09:44:02AM -0800, Christoph Lameter wrote:
> There is no problem moving back to the atomic approach that is if it is
> okay to also make anon_rss atomic. But its a pretty significant
> performance hit (comparison with some old data from V4 of patch which
> makes this data a bit suspect since the test environment is likely
> slightly different. I should really test this again. Note that the old
> performance test was only run 3 times instead of 10):
> atomic vs. sloppy rss performance 64G allocation:

The specific patches you compared matter a great deal as there are
implementation blunders (e.g. poor placement of counters relative to
->mmap_sem) that can ruin the results. URL's to the specific patches
would rule out that source of error.


-- wli
