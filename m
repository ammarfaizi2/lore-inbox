Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUJFFxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUJFFxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267278AbUJFFxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:53:30 -0400
Received: from fmr03.intel.com ([143.183.121.5]:43950 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S268072AbUJFFwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:52:46 -0400
Message-Id: <200410060552.i965qF601006@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Default cache_hot_time value back to 10ms
Date: Tue, 5 Oct 2004 22:52:26 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSrYGGe/eUC0tBtSvSByCX71PqbLAABsLcw
In-Reply-To: <20041005215116.3b0bd028.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Tuesday, October 05, 2004 9:51 PM
> >  > It sounds like this needs to be runtime tunable?
> >  >
> >
> >  I'd say it is probably too low level to be a useful tunable (although
> >  for testing I guess so... but then you could have *lots* of parameters
> >  tunable).
>
> This tunable caused an 11% performance difference in (I assume) TPCx.
> That's a big deal, and people will want to diddle it.
>
> If one number works optimally for all machines and workloads then fine.
>
> But yes, avoiding a tunable would be nice, but we need a tunable to work
> out whether we can avoid making it tunable ;)

Just to throw in some more benchmark numbers, we measured that specjbb
throughput went up by about 0.3% with cache_hot_time set to 10ms compare
to default 2.5ms.  No measurable speedup/regression on volanmark (we
just tried 10 and 2.5ms).

- Ken


