Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVC3AWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVC3AWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 19:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVC3AWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 19:22:34 -0500
Received: from fmr22.intel.com ([143.183.121.14]:27111 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261373AbVC3AW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 19:22:28 -0500
Message-Id: <200503300022.j2U0MKg03222@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Tue, 29 Mar 2005 16:22:20 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0uyq9M+SRbZwMT8KjJkO2VfZEaAAABqQA
In-Reply-To: <Pine.LNX.4.58.0503291546180.6036@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Chen, Kenneth W wrote:
> With that said, here goes our first data point along with some historical data
> we have collected so far.
>
> 2.6.11	-13%
> 2.6.9		- 6%
> 2.6.8		-23%
> 2.6.2		- 1%
> baseline	(rhel3)

Linus Torvalds wrote on Tuesday, March 29, 2005 4:00 PM
> How repeatable are the numbers across reboots with the same kernel? Some
> benchmarks will depend heavily on just where things land in memory,
> especially with things like PAE or even just cache behaviour (ie if some
> frequenly-used page needs to be kmap'ped or not depending on where it
> landed).

Very repeatable.  This workload is very steady and resolution in throughput
is repeatable down to 0.1%.  We toss everything below that level as noise.


> You don't have the PAE issue on ia64, but there could be other issues.
> Some of them just disk-layout issues or similar, ie performance might
> change depending on where on the disk the data is written in relationship
> to where most of the reads come from etc etc. The fact that it seems to
> fluctuate pretty wildly makes me wonder how stable the numbers are.

This workload has been around for 10+ years and people at Intel studied the
characteristics of this workload inside out for 10+ years.  Every stones will
be turned at least more than once while we tune the entire setup making sure
everything is well balanced.  And we tune the system whenever there is a
hardware change.  Data layout on the disk spindle are very well balanced.


> Also, it would be absolutely wonderful to see a finer granularity (which
> would likely also answer the stability question of the numbers). If you
> can do this with the daily snapshots, that would be great. If it's not
> easily automatable, or if a run takes a long time, maybe every other or
> every third day would be possible?

I sure will make my management know that Linus wants to see the performance
number on a daily bases (I will ask for a couple of million dollar to my
manager for this project :-))


