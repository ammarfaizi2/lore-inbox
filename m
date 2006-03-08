Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752013AbWCHCMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbWCHCMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCHCMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:12:25 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:63666 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752013AbWCHCMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:12:24 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Wed, 8 Mar 2006 13:12:50 +1100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ck@vds.kolivas.org
References: <200603081013.44678.kernel@kolivas.org> <200603081228.05820.kernel@kolivas.org> <1141783711.767.121.camel@mindpipe>
In-Reply-To: <1141783711.767.121.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081312.51058.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006 01:08 pm, Lee Revell wrote:
> On Wed, 2006-03-08 at 12:28 +1100, Con Kolivas wrote:
> > I can't distinguish between when cpu activity is important (game) and
> > when it is not (compile), and assuming worst case scenario and not doing
> > any swap prefetching is my intent. I could add cpu accounting to
> > prefetch_suitable() instead, but that gets rather messy and yielding
> > achieves the same endpoint.
>
> Shouldn't the game be running with RT priority or at least at a low nice
> value?

No way. Games run nice 0 SCHED_NORMAL.

Con
