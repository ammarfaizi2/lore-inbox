Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUCIRRi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbUCIRRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:17:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:15548 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261983AbUCIRRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:17:14 -0500
Date: Tue, 9 Mar 2004 09:17:12 -0800
From: cliff white <cliffw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent Reaim results
Message-Id: <20040309091712.747522cb.cliffw@osdl.org>
In-Reply-To: <20040308144050.1fe5976a.akpm@osdl.org>
References: <20040308083433.67485899.cliffw@osdl.org>
	<20040308144050.1fe5976a.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2004 14:40:50 -0800
Andrew Morton <akpm@osdl.org> wrote:

> cliff white <cliffw@osdl.org> wrote:
> >
> > 
> > Test results from the OSDL reaim test. 
> > The -mm kernels now appear to be scaling a bit nice.
> > I dunno why, but the 8-ways like -mm2 :)
> 
> I think your'e playing with my mind.

It's not _me, it's those STP robots. :)
> 
> > The is the 'database' load, a mixture of IO and CPU activity.
> 
> What about file server load?

Also looking pretty okay on ext3, and sucking somewhat less
on the other filesystems.
 I run filesystem compares on two-ways, so the
delta is not as big.

2-CPU- 
linux-2.6.3		6055.26		0.0	ext3

2.6.4-rc1-mm2		6149.28		1.64    ext3
2.6.4-rc1		6004.18        -0.84    ext3

2.6.4-rc1-mm2		6061.28		0.1	jfs
2.6.4-rc2	        5977.53	       -1.36    jfs

2.6.4-rc1-mm2		6007.67	       -0.83    reiserfs
2.6.4-rc1		5836.39        -3.83    reiserfs

2.6.4-rc1-mm2		5801.30	       -4.44    xfs
2.6.4-rc1		5785.93	       -4.71    xfs
----
> 
> > 4-CPU  ( all AS )
> > linux-2.6.3		5313.36		0.0
> > 2.6.4-rc1		5218.87		-1.78
> > 2.6.4-rc1-mm2		5391.00 	1.46
> 
> I spent a boring evening with the file server load on 4-way x86 with six
> disks.  If I squinted at it hard enough I was able to discern a 1% slowdown
> due to O_DIRECT-vs-buffered-fix.patch, but it was pretty thin.

Gee, i told the STP robots to run the tests, and went out and had fun :)
We should talk, the robots would be your slaves, if you would but ask them. 
> 
> I didn't test the database load.

The db load mixes the IO with some compute stuff, it will always run faster
than the fserver load. 

cliffw

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
