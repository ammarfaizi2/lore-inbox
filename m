Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVCWWuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVCWWuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVCWWuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:50:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:37330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262429AbVCWWuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:50:19 -0500
Date: Wed, 23 Mar 2005 14:49:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: andrea@suse.de, mjbligh@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-Id: <20050323144953.288a5baf.akpm@osdl.org>
In-Reply-To: <1111607584.5786.55.camel@localhost.localdomain>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
	<20050316183701.GB21597@opteron.random>
	<1111607584.5786.55.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
>  2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
>  hours the system hit OOM, and OOM keep killing processes one by one.

I don't have a very good record reading these oom dumps lately, but this
one look really weird.  Basically no mapped memory, tons of pagecache on
the LRU.

It would be interesting if you could run the same test on 2.6.11.  
