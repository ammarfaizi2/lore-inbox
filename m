Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTFOA1v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTFOA1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:27:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55758 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261564AbTFOA1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:27:50 -0400
Subject: Re: 2.5.70-mm9
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030614010139.2f0f1348.akpm@digeo.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	<3EEAD41B.2090709@us.ibm.com>  <20030614010139.2f0f1348.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Jun 2003 17:41:29 -0700
Message-Id: <1055637690.1396.15.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-14 at 01:01, Andrew Morton wrote:

> Was elevator=deadline observed to fail in earlier kernels?  If not then it
> may be an anticipatory scheduler bug.  It certainly had all the appearances
> of that.
Yes, with elevator=deadline the many fsx tests failed on 2.5.70-mm5.
 
> So once you're really sure that elevator=deadline isn't going to fail,
> could you please test elevator=as?
> 
Ok, the deadline test was run for 10 hours then I stopped it (for the
elevator=as test).  

But the test on elevator=as (2.5.70-mm9 kernel) still failed, same
problem.  Some fsx tests are sleeping on io_schedule().  

Next I think I will re-run test on elevator=deadline for 24 hours, to
make sure the problem is really gone there.  After that maybe try a
different Qlogic Driver, currently I am using the driver from Qlogic
company(QLA2XXX V8).

Thanks,

Mingming

