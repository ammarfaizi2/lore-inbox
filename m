Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVLaKwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVLaKwR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 05:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVLaKwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 05:52:17 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:31673 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932133AbVLaKwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 05:52:16 -0500
Date: Sat, 31 Dec 2005 11:52:13 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20051231115213.4a2e01ba@localhost>
In-Reply-To: <20051231113446.3ad19dbc@localhost>
References: <20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<20051230145221.301faa40@localhost>
	<43B5E78C.9000509@bigpond.net.au>
	<20051231113446.3ad19dbc@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 11:34:46 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> > It is a patch against the 2.6.15-rc7 kernel and includes some other 
> > scheduling patches from the -mm kernels.
> 
> Yes, this fixes both my test-case (transcode & little program), they
> get priority 25 instead of ~16.
> 
> But the priority of DD is now ~23 and so it still suffers a bit:

I forgot to mention that even the others "interactive" processes
don't get a good priority too.

Xorg for example, while only moving the cursor around, gets priority
23/24. And when cpu-eaters are running (at priority 25) it isn't happy
at all, the cursor begins to move in jerks and so on...

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-lial on x86_64
