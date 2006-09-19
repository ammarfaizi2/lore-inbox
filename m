Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWISRnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWISRnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWISRnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:43:50 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:59916 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1030390AbWISRnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:43:49 -0400
Subject: Re: [patch 7/8] process filtering for fault-injection capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
In-Reply-To: <20060919090508.GC24271@miraclelinux.com>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102032.989190948@localhost.localdomain>
	 <1158645291.2419.7.camel@localhost.localdomain>
	 <20060919090508.GC24271@miraclelinux.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 10:38:30 -0700
Message-Id: <1158687510.2509.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 17:05 +0800, Akinobu Mita wrote:
> On Mon, Sep 18, 2006 at 10:54:51PM -0700, Don Mullis wrote:
> > Add functionality to the process_filter variable: A negative argument
> > injects failures for only for pid==-process_filter, thereby permitting
> > per-process failures from boot time.
> > 
> 
> Is it better to add new filter for this purpose?
> Because someone may want to filter by tgid instead of pid.
> 
> - positive value is for task->pid
> - nevative value is for task->tgid

Your idea sounds good to me.

> > Add printk, called upon each failure injection.
> > 
> 
> This printk() will be very useful. But it is better to make
> configurable, and the pid is not reliable in interrupt context.

Okay.  We do need some output now, for testing.


