Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbUBJMyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 07:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbUBJMyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 07:54:14 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:916 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S265851AbUBJMyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 07:54:11 -0500
Message-ID: <4028D450.4030504@cyberone.com.au>
Date: Tue, 10 Feb 2004 23:53:36 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [TEST] 2.4 vs 2.6.2 vs 2.6.2-mm1 vs 2.6.2-rc3-mm1
References: <873c9kz4et.wl@canopus.ns.zel.ru>
In-Reply-To: <873c9kz4et.wl@canopus.ns.zel.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Samium Gromoff wrote:

>Here are the tests i`ve promised, and sorry for the delays.
>
>The test machine was a pIII-600/192M RAM/10krpm SCSI drive.
>
>There was three different loads.
>
>the test app whose run time was measured was:
>
>time find / -xdev | \
>	bzip2 --compress | bzip2 --decompress | \
>	bzip2 --compress | bzip2 --decompress | \
>	bzip2 --compress | bzip2 --decompress | \
>	cat > /dev/null
>
>the loads were:
>
>Load 1:
>	boot options: mem=32M init=/bin/bash
>	swapon -a
>	run the test
>
>Load 2:
>	boot options: mem=48M init=/bin/bash
>	swapon -a
>	run the test
>
>Load 3:
>	boot options: mem=48M
>	usual X session, with lots of terminals, emacs and stuff
>	the test was run from one of the x terminal emulators
>
>the kernels were:
>	2.4.20-pre9, 2.6.2 -- no comments
>	2.6.2-rc3-mm1 -- that one didn`t include the Namesys VM patches
>	2.6.2--mm1 -- that one _did_ include the Namesys VM patches
>
>results:
>
>
>		2.4.20-pre9	2.6.2		2.6.2-mm1	2.6.2-rc3-mm1
>
>Load 1
>  run1		6.27		9.14		9.42		10.52
>
>Load 2
>  run1		3.29		4.42		3.40		3.45
>  run2		3.28		4.37		3.39		3.45
>
>Load 3
>  run1		4.42		8.39		18.26
>
>
>short summary:
>
>	2.4 is faster.
>
>

What are the units? minutes.seconds?

The test is interesting, I'll have to try it. Does it
resemble a workload you're interested in?

It looks like the -mm kernels might have something other
than Nikita's and my VM patches that is affecting times.

Your Load 3 looks quite bad. Does it give decent results?
Is it possibly because the other stuff is getting better
treatment, do you think?

Thanks
Nick
