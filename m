Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268639AbTBZF3J>; Wed, 26 Feb 2003 00:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268645AbTBZF3J>; Wed, 26 Feb 2003 00:29:09 -0500
Received: from holomorphy.com ([66.224.33.161]:39353 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268639AbTBZF3J>;
	Wed, 26 Feb 2003 00:29:09 -0500
Date: Tue, 25 Feb 2003 21:38:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030226053805.GK10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@imladris.surriel.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
	lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
References: <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random> <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay> <20030225203001.GV29467@dualathlon.random> <417110000.1046206424@flay> <20030225211718.GY29467@dualathlon.random> <20030225212635.GE10411@holomorphy.com> <Pine.LNX.4.50L.0302260221380.17379-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302260221380.17379-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, William Lee Irwin III wrote:
>> My impression thus far is that the anonymous case has not been pressing
>> with respect to space consumption or cpu time once the file-backed code
>> is in place, though if it resurfaces as a serious concern the anonymous
>> rework can be pursued (along with other things).

On Wed, Feb 26, 2003 at 02:24:18AM -0300, Rik van Riel wrote:
> ... but making the anonymous pages use an object based
> scheme probably will make things too expensive.
> IIRC the object based reverse map patches by bcrl and
> davem both failed on the complexities needed to deal
> with anonymous pages.
> My instinct is that a hybrid system will work well in
> most cases and the worst case with mapped files won't
> be too bad.

The boxen I'm supposed to babysit need a high degree of resource
consciousness wrt. lowmem allocations, so there is a clear voice
on this issue. IMHO it's still an open question as to whether this
is efficient for replacement concerns, which may yet favor objects.


-- wli
