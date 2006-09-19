Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWISJ5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWISJ5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 05:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWISJ5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 05:57:14 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:30838 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750924AbWISJ5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 05:57:13 -0400
Date: Tue, 19 Sep 2006 17:05:08 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Don Mullis <dwm@meer.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
Subject: Re: [patch 7/8] process filtering for fault-injection capabilities
Message-ID: <20060919090508.GC24271@miraclelinux.com>
References: <20060914102012.251231177@localhost.localdomain> <20060914102032.989190948@localhost.localdomain> <1158645291.2419.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158645291.2419.7.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 10:54:51PM -0700, Don Mullis wrote:
> Add functionality to the process_filter variable: A negative argument
> injects failures for only for pid==-process_filter, thereby permitting
> per-process failures from boot time.
> 

Is it better to add new filter for this purpose?
Because someone may want to filter by tgid instead of pid.

- positive value is for task->pid
- nevative value is for task->tgid

> Add printk, called upon each failure injection.
> 

This printk() will be very useful. But it is better to make
configurable, and the pid is not reliable in interrupt context.

