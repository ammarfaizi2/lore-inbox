Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWAKTnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWAKTnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWAKTnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:43:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932467AbWAKTni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:43:38 -0500
Date: Wed, 11 Jan 2006 11:43:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: hch@lst.de, pbadari@us.ibm.com, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/5] multiple block allocation to current ext3
Message-Id: <20060111114303.45540193.akpm@osdl.org>
In-Reply-To: <1137007032.4395.24.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
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
	<20060110212551.411a766d.akpm@osdl.org>
	<1137007032.4395.24.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> # time ./filetst  -b 1048576 -w -f /mnt/a
>  	2.6.14		2.6.15
>  real    0m21.710s	0m25.773s
>  user    0m0.012s	0m0.004s
>  sys     0m14.569s	0m15.065s

That's a big drop.

Was it doing I/O, or was it all from pagecache?

>  I also found tiobench(sequential write test) and dbench has similar
>  regression between 2.6.14 and 2.6.15. Actually I found 2.6.15 rc2
>  already has the regression.  Is this a known issue?

No, it is not known.

> Anyway I will continue looking at the issue...

Thanks.
