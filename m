Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWD0Fjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWD0Fjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 01:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWD0Fjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 01:39:32 -0400
Received: from mga03.intel.com ([143.182.124.21]:59146 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964938AbWD0Fjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 01:39:32 -0400
Message-Id: <4t153d$r2dpi@azsmga001.ch.intel.com>
X-IronPort-AV: i="4.04,160,1144047600"; 
   d="scan'208"; a="28391218:sNHT15950137"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>, "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>, "'Nick Piggin'" <npiggin@suse.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <linux-mm@kvack.org>
Subject: RE: Lockless page cache test results
Date: Wed, 26 Apr 2006 22:39:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZpaiWAl+qYKSuVRgOo7PZDvNcEbwAUXPRQ
In-Reply-To: <20060426194623.GD9211@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Wednesday, April 26, 2006 12:46 PM
> > It's interesting, single threaded performance is down a little. Is
> > this significant? In some other results you showed me with 3 splices
> > each running on their own file (ie. no tree_lock contention), lockless
> > looked slightly faster on the same machine.
> 
> I can do the same numbers on a 2-way em64t for comparison, that should
> get us a little better coverage.


I throw the lockless patch and Jens splice-bench into our benchmark harness,
here are the numbers I collected, on the following hardware:

(1) 2P Intel Xeon, 3.4 GHz/HT, 2M L2
(2) 4P Intel Xeon, 3.0 GHz/HT, 8M L3
(3) 4P Intel Xeon, 3.0 GHz/DC/HT, 2M L2 (per core)

Here are the graph:

(1) 2P Intel Xeon, 3.4 GHz/HT, 2M L2
http://kernel-perf.sourceforge.net/splice/2P-3.4Ghz.png

(2) 4P Intel Xeon, 3.0 GHz/HT, 8M L3
http://kernel-perf.sourceforge.net/splice/4P-3.0Ghz.png

(3) 4P Intel Xeon, 3.0 GHz/DC/HT, 2M L2 (per core)
http://kernel-perf.sourceforge.net/splice/4P-3.0Ghz-DCHT.png

(4) everything on one graph:
http://kernel-perf.sourceforge.net/splice/splice.png

- Ken
