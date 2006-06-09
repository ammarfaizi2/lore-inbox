Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWFIXyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWFIXyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWFIXyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:54:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030389AbWFIXyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:54:05 -0400
Date: Fri, 9 Jun 2006 16:56:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: nagar@watson.ibm.com, balbir@in.ibm.com, jlan@sgi.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060609165655.7a4501d2.akpm@osdl.org>
In-Reply-To: <448A089C.6020408@engr.sgi.com>
References: <44892610.6040001@watson.ibm.com>
	<20060609010057.e454a14f.akpm@osdl.org>
	<448952C2.1060708@in.ibm.com>
	<20060609042129.ae97018c.akpm@osdl.org>
	<4489EE7C.3080007@watson.ibm.com>
	<4489F93E.6070509@engr.sgi.com>
	<20060609162232.2f2479c5.akpm@osdl.org>
	<448A089C.6020408@engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@engr.sgi.com> wrote:
>
> Is a system-wide switch that bad?

Yes, it's awful.  OK, we might band-aid something like that onto an
existing feature which had compatibility requirements, but for brand-new
code, no.  Let's get it right.

> A site  that needs tgid stats can live
> with the performance consequence while those do not need tgid can
> enjoy a pure per-task stats data. (I would argue that a thread group
> is some sort of task aggregate.)

But the performance impact was negligible.  A few percent on a workload
which just sat in a fork/exit busyloop.

> How about sending tgid stats when the last process in the group exist?
> But do not send it if not the last in the thread?

That'd be one for Balbir to think about.
