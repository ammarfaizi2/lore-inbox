Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVBXF0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVBXF0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 00:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVBXF0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 00:26:32 -0500
Received: from calma.pair.com ([209.68.1.95]:11784 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S261799AbVBXF0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 00:26:30 -0500
Date: Thu, 24 Feb 2005 00:26:30 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224052630.GA99960@calma.pair.com>
References: <20050223230639.GA33795@calma.pair.com> <20050223183634.31869fa6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223183634.31869fa6.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the other side of the coin is that a SCHED_FIFO userspace task
> presumably has extreme latency requirements, so it doesn't *want* to be
> preempted by some routine kernel operation.  People would get irritated if
> we were to do that.

Just to follow up a bit.  People writing apps that run at SCHED_FIFO know
that they aren't getting hard real-time, and they are OK with that.  If they
wanted something more they'd run on RTLinux.  Why would it be wrong to preempt
the SCHED_FIFO process in the case, assuming that it is too hard to fix a broken
design that doesn't allow the necessary kernel threads to run on any CPU?

Chad
