Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264362AbUEDNNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbUEDNNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 09:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUEDNNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 09:13:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:7632 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264362AbUEDNNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 09:13:00 -0400
Date: Tue, 4 May 2004 08:12:23 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, dheger@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance changes.
Message-ID: <20040504131223.GA28009@austin.ibm.com>
References: <20040430191539.GC14271@rx8.ibm.com> <20040430131832.45be6956.akpm@osdl.org> <20040430205701.GG14271@rx8.ibm.com> <20040430213324.GK14271@rx8.ibm.com> <20040430150256.25735762.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430150256.25735762.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [2004-04-30 15:02:56 -0700]:
> Also, I'd be interested in understanding what the input to the hashing
> functions looked like in this testing.  It could be that the new hash just
> happens to work well with one particular test's dataset.  Please convince
> us otherwise ;)

Andrew - Is there any workload you want me to run to show that this hash
function is going to be equal or better that the one already provided
in Linux?

Remember that my claim is not the this hash function will be better for
every IO workload.  I claim it should not have worst performance than
the default hash function but on some workloads it should perform
better.  The workloads that this should show improvements are those that
use GB of memory to store inode and dentry cache data.  I have run some
test on my old BP6 machine and other than a small improvements while
running find, I did not see any improvements but no regressions either.
Again, if you have a particular workload in mind, Ill be happy to run it
on some of my systems.

Thanks,

-JRS
