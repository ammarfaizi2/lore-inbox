Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUD3WA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUD3WA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUD3WA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:00:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:30921 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261568AbUD3WAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:00:55 -0400
Date: Fri, 30 Apr 2004 15:02:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: jrsantos@austin.ibm.com, linux-kernel@vger.kernel.org, anton@samba.org,
       dheger@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance
 changes.
Message-Id: <20040430150256.25735762.akpm@osdl.org>
In-Reply-To: <20040430213324.GK14271@rx8.ibm.com>
References: <20040430191539.GC14271@rx8.ibm.com>
	<20040430131832.45be6956.akpm@osdl.org>
	<20040430205701.GG14271@rx8.ibm.com>
	<20040430213324.GK14271@rx8.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jose R. Santos" <jrsantos@austin.ibm.com> wrote:
>
> On 04/30/04 15:57:01, Jose R. Santos wrote:
> > err... Wrote the patch to fast.  It should read
> > 
> > 	tmp = (hashval * sb) ^ (GOLDEN_RATIO_PRIME + hashval) / L1_CACHE_BYTES
> > 
> > I screw up... I'll send a fixed patch in a while.
> 
> Just notice I've made another error in the inode hash code.
> 
> Fixed patch (I hope) with beautification.

Does this mean you need to redo the instrumentation and benchmarking?  If
so, please do that and send the numbers along?  There's no particular
urgency on that, but we should do it.

Also, I'd be interested in understanding what the input to the hashing
functions looked like in this testing.  It could be that the new hash just
happens to work well with one particular test's dataset.  Please convince
us otherwise ;)

