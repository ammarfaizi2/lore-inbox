Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268724AbTBZMFn>; Wed, 26 Feb 2003 07:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268727AbTBZMFn>; Wed, 26 Feb 2003 07:05:43 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:39436 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S268724AbTBZMFm>; Wed, 26 Feb 2003 07:05:42 -0500
Message-ID: <3E5CB051.2040205@aitel.hist.no>
Date: Wed, 26 Feb 2003 13:17:21 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.62-mm2 slow file system writes across multiple disks
References: <20030224120304.A29472@beaverton.ibm.com>	<20030224135323.28bb2018.akpm@digeo.com>	<20030224174731.A31454@beaverton.ibm.com>	<20030224204321.5016ded6.akpm@digeo.com>	<20030225112458.A5618@beaverton.ibm.com> <20030226004454.2bfd8deb.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Patrick Mansfield <patmans@us.ibm.com> wrote:
[...]
> 
>>The larger queue depths can be nice for disk arrays with lots of cache and
>>(more) random IO patterns.
> 
> 
> So says the scsi lore ;)  Have you observed this yourself?  Have you
> any numbers handy?

I believe deep queues might work well if the drives did their own
anticipatory scheduling.  After all, they know both true geometry and
excact rotational position and latency.
But current drives aren't that good so all the deep queue achieves is
extra seeks which sometimes kills performance.  The fix is simple -
shorten the queues.  Long ones aren't really a goal by itself -
performance is.

Helge Hafting

