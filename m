Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWAKVeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWAKVeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWAKVeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:34:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:20927 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750798AbWAKVeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:34:02 -0500
Subject: Re: [PATCH 0/5] multiple block allocation to current ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20060111114303.45540193.akpm@osdl.org>
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
	 <20060111114303.45540193.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 11 Jan 2006 13:31:44 -0800
Message-Id: <1137015104.4395.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 11:43 -0800, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > # time ./filetst  -b 1048576 -w -f /mnt/a
> >  	2.6.14		2.6.15
> >  real    0m21.710s	0m25.773s
> >  user    0m0.012s	0m0.004s
> >  sys     0m14.569s	0m15.065s
> 
> That's a big drop.
> 
> Was it doing I/O, or was it all from pagecache?
> 

It's doing IO on a freshly created filesystem. It was running with AS io
scheduler.  It seems DIO has no problem, and ext2 has no regression
either... Will keep you posted.


Mingming


