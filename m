Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVASJ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVASJ0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVASJZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:25:45 -0500
Received: from zukmail03.zreo.compaq.com ([161.114.128.27]:33028 "EHLO
	zukmail03.zreo.compaq.com") by vger.kernel.org with ESMTP
	id S261669AbVASJXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:23:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Lmbench-users] Re: pipe performance regression on ia64
Date: Wed, 19 Jan 2005 11:23:22 +0200
Message-ID: <C34DDF504647EB44AF3AF509B2E5270236A380@raaexc01.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lmbench-users] Re: pipe performance regression on ia64
Thread-Index: AcT91CXe4jWQ4F2WT2i/sKf2doQANwAAc32wAAarX0AAAF6QAA==
From: "Staelin, Carl" <carl.staelin@hp.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Zou, Nanhai" <nanhai.zou@intel.com>,
       "Larry McVoy" <lm@bitmover.com>, "Linus Torvalds" <torvalds@osdl.org>
Cc: "Mosberger, David" <david.mosberger@hp.com>, <lmbench-users@bitmover.com>,
       <linux-ia64@vger.kernel.org>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Jan 2005 09:23:26.0525 (UTC) FILETIME=[87D456D0:01C4FE08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One problem is that on SMPs "average" doesn't really
make sense.  Statistically, "average" (mean()) only
really makes sense when you have a Gaussian distribution
of results.  The benchmark results for SMPs tend to
be stongly modal, i.e. very tight clusters around
a few values.  In this environment "average" is
generally meaningless.

That being said, the '-P' flag exists on most lmbench
version 3 benchmarks and allows one to have a given
number of jobs running in parallel.  It is intended
to measure performance under load.  However, even
in this case one may see modal results.  Please see
the recent lmbench paper [2] for an example.


Cheers,

Carl

References
[1] Larry McVoy and Carl Staelin.  lmbench: Portable
    tools for performance analysis.  Proceedings 1996
    USENIX Annual Technical Conference (San Diego, CA),
    pages 279--284.  January 1996.
 
http://www.usenix.org/publications/library/proceedings/sd96/mcvoy.html
[2] Carl Staelin.  lmbench --- an extensible micro-
    benchmark suite.  HPL-2004-213.  December 2004.
    Also to appear in Software Practice and Experience.
    http://www.hpl.hp.com/techreports/2004/HPL-2004-213.pdf



_________________________________________________
[(hp)]	Carl Staelin
	Senior Research Scientist
	Hewlett-Packard Laboratories
	Technion City
	Haifa, 32000
	ISRAEL
	+972(4)823-1237x305	+972(4)822-0407 fax
	carl.staelin@hp.com
______ http://www.hpl.hp.com/personal/Carl_Staelin ______

-----Original Message-----
From: Luck, Tony [mailto:tony.luck@intel.com] 
Sent: Wednesday, January 19, 2005 8:35 AM
To: Zou, Nanhai; Larry McVoy; Linus Torvalds
Cc: Mosberger, David; Staelin, Carl; lmbench-users@bitmover.com;
linux-ia64@vger.kernel.org; Kernel Mailing List
Subject: RE: [Lmbench-users] Re: pipe performance regression on ia64

>Maybe lmbench could add a feature that bw_pipe will fork CPU number of 
>children to measure the average throughput.
>
>This will give a much reasonable result when running bw_pipe on a SMP 
>Box, at least for Linux.

bw_pipe (along with most/all of the lmbench tools already has a "-P"
argument to specify the degree of parallelism).

-Tony

