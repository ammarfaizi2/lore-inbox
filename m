Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268658AbTBZFv5>; Wed, 26 Feb 2003 00:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268659AbTBZFv5>; Wed, 26 Feb 2003 00:51:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:47042 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268658AbTBZFv4>; Wed, 26 Feb 2003 00:51:56 -0500
Date: Tue, 25 Feb 2003 22:01:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Rik van Riel <riel@imladris.surriel.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <10220000.1046239279@[10.10.2.4]>
In-Reply-To: <20030226053805.GK10411@holomorphy.com>
References: <20030225174359.GA10411@holomorphy.com>
 <20030225175928.GP29467@dualathlon.random>
 <20030225185008.GF10396@holomorphy.com>
 <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay>
 <20030225203001.GV29467@dualathlon.random> <417110000.1046206424@flay>
 <20030225211718.GY29467@dualathlon.random>
 <20030225212635.GE10411@holomorphy.com>
 <Pine.LNX.4.50L.0302260221380.17379-100000@imladris.surriel.com>
 <20030226053805.GK10411@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> My impression thus far is that the anonymous case has not been pressing
>>> with respect to space consumption or cpu time once the file-backed code
>>> is in place, though if it resurfaces as a serious concern the anonymous
>>> rework can be pursued (along with other things).
> 
> On Wed, Feb 26, 2003 at 02:24:18AM -0300, Rik van Riel wrote:
>> ... but making the anonymous pages use an object based
>> scheme probably will make things too expensive.
>> IIRC the object based reverse map patches by bcrl and
>> davem both failed on the complexities needed to deal
>> with anonymous pages.
>> My instinct is that a hybrid system will work well in
>> most cases and the worst case with mapped files won't
>> be too bad.
> 
> The boxen I'm supposed to babysit need a high degree of resource
> consciousness wrt. lowmem allocations, so there is a clear voice

It seemed, at least on the simple kernel compile tests that I did, that all
the long chains are not anonymous. It killed 95% of the space issue, which
given the simplicity of the patch was pretty damned stunning. Yes, there's
a pointer per page I guess we could kill in the struct page itself, but I
think you already have a better method for killing mem_map bloat ;-)

M.
