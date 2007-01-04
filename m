Return-Path: <linux-kernel-owner+w=401wt.eu-S932274AbXADRJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbXADRJa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbXADRJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:09:30 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:59497 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbXADRJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:09:29 -0500
X-AuditID: d80ac287-a10c4bb000002548-f3-459d35a05c4a 
Date: Thu, 4 Jan 2007 17:09:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
In-Reply-To: <459D290B.1040703@tmr.com>
Message-ID: <Pine.LNX.4.64.0701041653250.12920@blonde.wat.veritas.com>
References: <459CEA93.4000704@tls.msk.ru> <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com>
 <459D290B.1040703@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Jan 2007 17:09:28.0542 (UTC) FILETIME=[17D8C7E0:01C73023]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Bill Davidsen wrote:
> 
> In many cases the use of O_DIRECT is purely to avoid impact on cache used by
> other applications. An application which writes a large quantity of data will
> have less impact on other applications by using O_DIRECT, assuming that the
> data will not be read from cache due to application pattern or the data being
> much larger than physical memory.

I see that as a good argument _not_ to allow O_DIRECT on tmpfs,
which inevitably impacts cache, even if O_DIRECT were requested.

But I'd also expect any app requesting O_DIRECT in that way, as a caring
citizen, to fall back to going without O_DIRECT when it's not supported.

Hugh
