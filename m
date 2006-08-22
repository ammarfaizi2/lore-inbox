Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWHVFL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWHVFL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWHVFL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:11:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750741AbWHVFL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:11:56 -0400
Date: Mon, 21 Aug 2006 22:11:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: Paul Jackson <pj@sgi.com>, Anton Blanchard <anton@samba.org>,
       simon.derr@bull.net, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060821221145.ff88769f.akpm@osdl.org>
In-Reply-To: <20060822050401.GB11309@localdomain>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060822050401.GB11309@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 00:04:01 -0500
Nathan Lynch <ntl@pobox.com> wrote:

> > If the kernel provider (ie: distro) has enabled cpusets then it would be
> > appropriate that they also provide a hotplug script which detects whether their
> > user is actually using cpusets and if not, to take some sensible default action. 
> > ie: add the newly-added CPU to the system's single cpuset, no?
> 
> I think it would be more sensible for the default (i.e. user hasn't
> explicitly configured any cpusets) behavior on a CONFIG_CPUSETS=y
> kernel to match the behavior with a CONFIG_CPUSETS=n kernel.

Well...  why?  If he-who-configured the kernel chose cpusets then it's
reasonable to expect he-who-configures to have appropriate userspace
support for that kernel.

>  Right
> now we don't have that.  Binding a task to a newly added cpu just
> fails if CONFIG_CPUSETS=y, but it works if CONFIG_CPUSETS=n.

Sure.  That's because we're not taking appropriate (ie any) action when a
CPU is added.
