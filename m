Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268445AbTBYVSy>; Tue, 25 Feb 2003 16:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268455AbTBYVSy>; Tue, 25 Feb 2003 16:18:54 -0500
Received: from holomorphy.com ([66.224.33.161]:48823 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268445AbTBYVRt>;
	Tue, 25 Feb 2003 16:17:49 -0500
Date: Tue, 25 Feb 2003 13:26:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225212635.GE10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
	lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
References: <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random> <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay> <20030225203001.GV29467@dualathlon.random> <417110000.1046206424@flay> <20030225211718.GY29467@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225211718.GY29467@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 12:53:44PM -0800, Martin J. Bligh wrote:
>> Because you don't set up and tear down the rmap pte-chains for every 
>> fault in / delete of any page ... it just works off the vmas.

On Tue, Feb 25, 2003 at 10:17:18PM +0100, Andrea Arcangeli wrote:
> so basically it uses the rmap that we always had since at least 2.2 for
> everything but anon mappings, right?  this is what DaveM did a few years
> back too. This makes lots of sense to me, so at least we avoid the
> duplication of rmap information, even if it won't fix the anonymous page
> overhead, but clearly it's much lower cost for everything but anonymous
> pages.

This is what the "anonymous rework" is about. There is already a fix
extant for the file-backed case, which I presumed you knew of already,
and so were were speaking of issues with the anonymous case.

My impression thus far is that the anonymous case has not been pressing
with respect to space consumption or cpu time once the file-backed code
is in place, though if it resurfaces as a serious concern the anonymous
rework can be pursued (along with other things).


-- wli
