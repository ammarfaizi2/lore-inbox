Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVDFBYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVDFBYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 21:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVDFBYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 21:24:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:58574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262069AbVDFBXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 21:23:54 -0400
Date: Tue, 5 Apr 2005 18:23:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: andrea@suse.de, mjbligh@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, janetinc@us.ibm.com
Subject: Re: [Ext2-devel] Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-Id: <20050405182325.5297ff87.akpm@osdl.org>
In-Reply-To: <1112720671.3522.6.camel@dyn9047017080.beaverton.ibm.com>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
	<20050316183701.GB21597@opteron.random>
	<1111607584.5786.55.camel@localhost.localdomain>
	<20050403183544.7c31f85c.akpm@osdl.org>
	<1112633417.3703.8.camel@dyn318043bld.beaverton.ibm.com>
	<20050404130441.53ab480b.akpm@osdl.org>
	<1112720671.3522.6.camel@dyn9047017080.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> I run the test(20 instances of fsx) with your patch on 2.6.12-rc1 with
>  512MB RAM (where I were able to constantly re-create the mem leak and
>  lead to OOM before). The result is the kernel did not get into OOM after
>  about 19 hours(before it took about 9 hours or so), system is still
>  responsive. However I did notice about ~60MB delta between Active
>  +Inactive and Buffers+cached+Swapcached+Mapped+Slab

yes.

Nobody has noticed the now-fixed leak since 2.6.6 and this one appears to
be 100x slower.  Which is fortunate because this one is going to take a
long time to fix.  I'll poke at it some more.
