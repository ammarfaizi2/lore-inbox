Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVAKWPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVAKWPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVAKWOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:14:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:18356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262479AbVAKWNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:13:20 -0500
Date: Tue, 11 Jan 2005 14:13:19 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111141319.P10567@build.pdx.osdl.net>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050111212719.GA23477@elte.hu>; from mingo@elte.hu on Tue, Jan 11, 2005 at 10:27:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> you are right, i forgot about kernel threads. If they are nice -10 on
> Jack's system too then they are within striking range indeed, especially
> since they are typically idle and if then they are active for short
> bursts of time and get the maximum boost. Jack, could you renice these
> to -5, to make sure they dont interfere?

Yup, their bursty nature makes them seem a likely culprit.

> btw., why are these at nice -10? workqueue.c sets nice value to -5
> normally.

Heh, I was just wondering the same thing.

BTW, grepping set_user_nice shows a few more possible culprits.
One more reason that there may be value in promoting the audio app to
rt scheduling.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
