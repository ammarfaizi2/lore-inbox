Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbTDVPmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTDVPmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:42:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62951 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263209AbTDVPl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:41:59 -0400
Date: Tue, 22 Apr 2003 08:53:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@redhat.com>,
       Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <180520000.1051026829@[10.10.2.4]>
In-Reply-To: <20030422151054.GH8978@holomorphy.com>
References: <20030405143138.27003289.akpm@digeo.com>
 <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
 <20030422123719.GH23320@dualathlon.random>
 <20030422132013.GF8931@holomorphy.com> <171790000.1051022316@[10.10.2.4]>
 <20030422151054.GH8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> where the list of address_ranges is sorted by start address. This is
>> intended to make use of the real-world case that many things (like shared
>> libs) map the same exact address ranges over and over again (ie something
>> like 3 ranges, but hundreds or thousands of mappings).
> 
> I'd have to see an empirical demonstration or some previously published
> analysis (or previously published empirical demonstration) to believe
> this does as it should.
> 
> Not to slight the originator, but it is a technique without an a priori
> time (or possibly space either) guarantee, so the trials are warranted.
> 
> I'm overstating the argument because it's hard to make it sound slight;
> it's very plausible something like this could resolve the time issue.

I got sidetracked by the slowdown seeing for massive contention on the
i_shared_sem for even sorting the list. We need to fix that before this is
feasible to do ... (though maybe the list will be sufficiently shorter now
it's less of a problem .... hmmm). Maybe I'll just finish off the code.

M.

