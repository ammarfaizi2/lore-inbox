Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUAFQ0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUAFQ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:26:15 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:62608 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261660AbUAFQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:26:14 -0500
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: johnstul@us.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040106081947.3d51a1d5.akpm@osdl.org>
References: <1073405053.2047.28.camel@mulgrave> 
	<20040106081947.3d51a1d5.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Jan 2004 10:26:08 -0600
Message-Id: <1073406369.2047.33.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-06 at 10:19, Andrew Morton wrote:
> Hm, OK.  I hit the same deadlock when running with the "don't require TSCs
> to be synchronised in sched_clock()" patch from -mm.  The fix for that is
> below.  I shall accelerate it.

Actually, I think we need to know why this is happening, since the use
of these sequence locks is growing.  On voyager I just put it down to HZ
== 1000 being a bit much for my old pentium 66MHz processors, but if
you've seen it on a much faster processor, that would tend to indicate
there's some other problem at work here.

James


