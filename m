Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVDDUfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVDDUfC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVDDUdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:33:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2503 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261383AbVDDUY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:24:26 -0400
Date: Mon, 04 Apr 2005 13:24:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com
cc: andrea@suse.de, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, janetinc@us.ibm.com
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-ID: <37420000.1112646263@flay>
In-Reply-To: <20050404130441.53ab480b.akpm@osdl.org>
References: <20050315204413.GF20253@csail.mit.edu><20050316003134.GY7699@opteron.random><20050316040435.39533675.akpm@osdl.org><20050316183701.GB21597@opteron.random><1111607584.5786.55.camel@localhost.localdomain><20050403183544.7c31f85c.akpm@osdl.org><1112633417.3703.8.camel@dyn318043bld.beaverton.ibm.com> <20050404130441.53ab480b.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
>> > >  2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
>> > >  hours the system hit OOM, and OOM keep killing processes one by one. I
>> > >  could reproduce this problem very constantly on a 2 way PIII 700MHZ with
>> > >  512MB RAM. Also the problem could be reproduced on running the same test
>> > >  on reiser fs.
>> > > 
>> > >  The fsx command is:
>> > > 
>> > >  ./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &
>> > 
>> > 
>> > This ext3 bug goes all the way back to 2.6.6.
>> 
>> > I don't know yet why you saw problems with reiser3 and I'm pretty sure I
>> > saw problems with ext2.  More testing is needed there.
>> > 
>> 
>> We (Janet and I) are chasing this bug as well. Janet is able to
>> reproduce this bug on 2.6.9 but I can't. Glad to know you have nail down
>> this issue on ext3. I am pretty sure I saw this on Reiser3 once, I will
>> double check it.  Will try your patch today.
> 
> There's a second leak, with similar-looking symptoms.  At ~50
> commits/second it has leaked ~10MB in 24 hours, so it's very slow - less
> than a hundredth the rate of the first one.

What are you using to see these with, just kgdb, and a large cranial
capacity? Or is there some more magic?

m.

