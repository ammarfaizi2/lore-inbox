Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVCZA1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVCZA1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVCZA1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:27:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:35315 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261887AbVCZA1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:27:00 -0500
Subject: Re: [Ext2-devel] Re: OOM problems on 2.6.12-rc1 with many fsx tests
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Mingming Cao <cmm@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, mjbligh@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20050326001702.GA22347@redhat.com>
References: <20050315204413.GF20253@csail.mit.edu>
	 <20050316003134.GY7699@opteron.random>
	 <20050316040435.39533675.akpm@osdl.org>
	 <20050316183701.GB21597@opteron.random>
	 <1111607584.5786.55.camel@localhost.localdomain>
	 <20050326001702.GA22347@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1111796400.21169.69.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Mar 2005 16:20:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 16:17, Dave Jones wrote:
> On Wed, Mar 23, 2005 at 11:53:04AM -0800, Mingming Cao wrote:
> 
>  > The fsx command is:
>  > 
>  > ./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &
>  > 
>  > I also see fsx tests start to generating report about read bad data
>  > about the tests have run for about 9 hours(one hour before of the OOM
>  > happen). 
> 
> Is writing to the same testfile from multiple fsx's supposed to work?
> It sounds like a surefire way to break the consistency checking that it does.
> I'm surprised it lasts 9hrs before it breaks.
> 
> In the past I've done tests like..
> 
> for i in `seq 1 100`
> do
>   fsx foo$i &
> done
> 
> to make each process use a different test file.
> 

No. We are doing on different files - Mingming cut and pasted
only a single line from the script.

Thanks,
Badari

