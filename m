Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWAKF0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWAKF0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAKF0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:26:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751371AbWAKF03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:26:29 -0500
Date: Tue, 10 Jan 2006 21:25:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: hch@lst.de, pbadari@us.ibm.com, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/5] multiple block allocation to current ext3
Message-Id: <20060110212551.411a766d.akpm@osdl.org>
In-Reply-To: <1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com>
References: <1112673094.14322.10.camel@mindpipe>
	<1112765751.3874.14.camel@localhost.localdomain>
	<20050407081434.GA28008@elte.hu>
	<1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	<1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	<1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	<1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	<1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113244710.4413.38.camel@localhost.localdomain>
	<1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113288087.4319.49.camel@localhost.localdomain>
	<1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	<1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	<1114207837.7339.50.camel@localhost.localdomain>
	<1114659912.16933.5.camel@mindpipe>
	<1114715665.18996.29.camel@localhost.localdomain>
	<1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> Tests done so far includes fsx,tiobench and dbench. The following
>  numbers collected from Direct IO tests (1G file creation/read)  shows
>  the system time have been greatly reduced (more than 50% on my 8 cpu
>  system) with the patches.
> 
>  1G file DIO write:
>  	2.6.15		2.6.15+patches
>  real    0m31.275s	0m31.161s
>  user    0m0.000s	0m0.000s
>  sys     0m3.384s	0m0.564s 
> 
> 
>  1G file DIO read:
>  	2.6.15		2.6.15+patches
>  real    0m30.733s	0m30.624s
>  user    0m0.000s	0m0.004s
>  sys     0m0.748s	0m0.380s
> 
>  Some previous test we did on buffered IO with using multiple blocks
>  allocation and delayed allocation shows noticeable improvement on
>  throughput and system time.

I'd be interested in seeing benchmark results for the common
allocate-one-block case - just normal old buffered IO without any
additional multiblock patches.   Would they show any regression?
