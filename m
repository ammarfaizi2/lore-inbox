Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUH1KZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUH1KZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUH1KWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:22:15 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:40556 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267401AbUH1KTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:19:17 -0400
Message-ID: <41305BFF.6040209@yahoo.com.au>
Date: Sat, 28 Aug 2004 20:18:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, linuxram@us.ibm.com, hugh@veritas.com,
       dice@mfa.kfki.hu, vda@port.imtp.ilyichevsk.odessa.ua,
       linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
References: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain>	<1093669312.11648.80.camel@dyn319181.beaverton.ibm.com>	<41301E27.2020504@yahoo.com.au>	<200408281144.50704.rjw@sisk.pl> <20040828024504.70407b43.akpm@osdl.org>
In-Reply-To: <20040828024504.70407b43.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
>>Well, guys, to make it 100% clear: if I apply the Nick's patch to the 
>> 2.6.9-rc1-mm1 tree, it will fix the data loss issue.  Is that right?
> 
> 
> Should do.

It passes test cases that would previously fail here, so consider it
lightly tested. Note that the patch is on top of 2.6.9-rc1 though,
it becomes slightly deranged when applying straight onto mm. So don't
do that.

...

>  Or revert
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one-cleanup.patch
> 
> and then
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one.patch
> 
> 
> 

Once you have these backed out mine should apply fine, but it only closes
some performance (not correctness) corner cases that the above patches
attempted to.
