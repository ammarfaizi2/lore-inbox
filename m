Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVJ2AEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVJ2AEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVJ2AEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:04:12 -0400
Received: from fmr21.intel.com ([143.183.121.13]:60040 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750870AbVJ2AEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:04:10 -0400
Message-Id: <200510290004.j9T044g27679@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, "Jens Axboe" <axboe@suse.de>
Subject: RE: kernel performance update - 2.6.14
Date: Fri, 28 Oct 2005 17:04:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXcGvRqYnPtWd7KRQq1dlYbyp/IwAAAD6iw
In-Reply-To: <4362BA30.2020504@pobox.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote on Friday, October 28, 2005 4:54 PM
> Chen, Kenneth W wrote:
> > Kernel performance data for 2.6.14 (released yesterday) is updated at:
> > http://kernel-perf.sourceforge.net
> > 
> > As expected, results are within run variation compares to 2.6.14-rc5.
> > No significant deviation found compare to 2.6.14-rc5
> 
> Do I read this correctly:  according to your benchmarks, fileio-noop and 
> fileio-cfq are down some 20% or more, across all machine configurations, 
> since 2.6.9? In the 4P configuration, dbench-{noop,as} both seem to have 
> regressed as well.

Yes, you did read that correctly.  For some benchmarks, these numbers
can't be directly interpreted as a regression since we may not have
the correct configuration (either wrong setup or default parameters
aren't suitable for the machine that size).  For example, dbench is
one of them.  We are working on characterize these workloads to make
sure our setup is meaningful.

We are also looking through fileio data.  I think we understand the drop
in fileio-noop.  But I want to have more definitive understanding before
claim a real regression.  Same thing with cfq.

- Ken

