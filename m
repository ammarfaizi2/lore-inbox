Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266350AbUGAXWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266350AbUGAXWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 19:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUGAXWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 19:22:21 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:28637 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266350AbUGAXWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 19:22:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: io priorities? 
In-reply-to: <20040701155637.74af8c0d.akpm@osdl.org> 
References: <E1Bg64T-0003MC-00@highlab.com> <Pine.LNX.4.53.0407011456110.1241@chaos> <20040701155637.74af8c0d.akpm@osdl.org>
Comments: In-reply-to Andrew Morton <akpm@osdl.org>
   message dated "Thu, 01 Jul 2004 15:56:37 -0700."
Date: Thu, 01 Jul 2004 17:15:38 -0600
From: Sebastian Kuzminsky <seb@highlab.com>
Message-Id: <E1BgAmJ-0006dx-00@highlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
] "Richard B. Johnson" <root@chaos.analogic.com> wrote:
] > Periodically fsync() the logs so there isn't soooo much stuff to
] > write. In fact, a simple sync() call about once every few seconds
] > should make everything work,
] 
] Yup.  Alternatively, set /proc/sys/vm/dirty_ratio and /proc/sys/vm/dirty_background_ratio
] to really small values.  Say, 2 and 1.


Thanks guys, that sort of fixes it, but not really.  Occasionally i get
a big load of IO (copying tens of megs of log files around), and even if
i synced a second before, now there's tens of seconds of IO in the queue,
and my next fsync() still drags on.


Really i just want this one process to go to the front of the queue, any
time it has IO to do, independent of what the rest of the system is doing.




--
Sebastian

