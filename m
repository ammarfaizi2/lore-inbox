Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269519AbUHZU7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269519AbUHZU7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269656AbUHZU4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:56:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:10495 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269643AbUHZUva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:51:30 -0400
Date: Thu, 26 Aug 2004 13:51:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
Message-ID: <50490000.1093553473@flay>
In-Reply-To: <412DC47B.4000704@kolivas.org>
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, August 26, 2004 21:07:39 +1000 Con Kolivas <kernel@kolivas.org> wrote:

> Andrew Morton wrote:
>> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
>> 
>> 
>> - nicksched is still here.  There has been very little feedback, except that
>>   it seems to slow some workloads on NUMA.
> 
> That's because most people aren't interested in a new cpu scheduler for
> 2.6. The current one works well enough in most situations and people
> aren't trying -mm to fix their interactive problems since they are few
> and far between. The only reports about adverse behaviour with 2.6 we track down to "It behaves differently to what I expect" or applications with no (b)locking between threads suck under load. Personally I think the latter is a good thing as it encourages better coding, and the former is something we'll have with any alternate design.

Well ... it'd be nice to know what nicksched was trying to fix. Then maybe
we could try to measure it. There's lots of stuff in the changelog about
what technical stuff was fiddled with ... but nothing I can see about what
it was meant to acheive.

> The only feedback we got on staircase was that it helped NUMA somewhat and Nick and Ingo made some criticisms (not counting any benchmarks I had to offer). The only feedback on nickshed was that it hurt NUMA somewhat, SMT interactivity was broken (an easy enough oversight), and I did not comment to avoid giving biased criticism.

The main thing I liked about staircase was it seemed to simplify things.
Having mere mortals comprehend the code seems like a Good Plan (tm).

The fact that it seemed to bounce tasks around a crapload less was a nice
bonus ;-) Cache is king.

M.

