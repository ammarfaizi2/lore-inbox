Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSI0POI>; Fri, 27 Sep 2002 11:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262516AbSI0POI>; Fri, 27 Sep 2002 11:14:08 -0400
Received: from franka.aracnet.com ([216.99.193.44]:18915 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261724AbSI0POA>; Fri, 27 Sep 2002 11:14:00 -0400
Date: Fri, 27 Sep 2002 08:04:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: dipankar@in.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <502559422.1033113869@[10.10.2.3]>
In-Reply-To: <20020927152833.D25021@in.ibm.com>
References: <20020927152833.D25021@in.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > What application were you all running ?

Kernel compile on NUMA-Q looks like this:

125673 total
82183 default_idle
6134 do_anonymous_page
4431 page_remove_rmap
2345 page_add_rmap
2288 d_lookup
1921 vm_enough_memory
1883 __generic_copy_from_user
1566 file_read_actor
1381 .text.lock.file_table           <-------------
1168 find_get_page
1116 get_empty_filp

Presumably that's the same thing? Interestingly, if I look back at 
previous results, I see it's about twice the cost in -mm as it is 
in mainline, not sure why ... at least against 2.5.37 virgin it was.

> Please try running the files_struct_rcu patch where fget() is lockfree
> and let me know what you see.

Will do ... if you tell me where it is ;-)

M.

