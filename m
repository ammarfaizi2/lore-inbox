Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUDPB5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 21:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDPB5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 21:57:13 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:14711 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261380AbUDPB5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 21:57:07 -0400
Message-ID: <407F3D70.4090704@yahoo.com.au>
Date: Fri, 16 Apr 2004 11:57:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: markw@osdl.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.5-mm5
References: <200404151530.i3FFUI226872@mail.osdl.org>
In-Reply-To: <200404151530.i3FFUI226872@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:
> I have more results with DBT-2 on my 4-way Xeon system:
> 	http://developer.osdl.org/markw/fs/dbt2_project_results.html
> 
> It doesn't look like the latest cpu scheduler work is helping this
> workload.  I've also made sure that the database was set to use fsync
> instead of fdatasync so you can see if those fsync speedup patches are
> offering anything with this workload too.
> 
>            ext2  ext3
> 2.6.5-mm5  2165  1933
> 2.6.5-mm4  2180
> 2.6.5-mm3  2165  1930
> 2.6.5      2385
> 
> Mark
> 

Hmm, well the sched-less-idle patch is in mm5, which brought
2.6.5-rc3-mm4 to 2320 on ext2.

The only other significant scheduler changes since that kernel
are in -mm5.
+sched_less_idle
+sched_balance_context

So either sched_balance_context is causing a regression that
counters sched_less_idle, or maybe it isn't a scheduler problem?
