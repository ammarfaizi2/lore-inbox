Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVDLXVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVDLXVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVDLXKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:10:31 -0400
Received: from users.ccur.com ([208.248.32.211]:16114 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S262971AbVDLUdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:33:53 -0400
Date: Tue, 12 Apr 2005 16:33:29 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       mingo@elte.hu
Subject: Re: FUSYN and RT
Message-ID: <20050412203329.GA15304@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1113329702.23407.148.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113329702.23407.148.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 11:15:02AM -0700, Daniel Walker wrote:

> It seems like these two locks are going to interact on a very limited
> basis. Fusyn will be the user space mutex, and the RT mutex is only in
> the kernel. You can't lock an RT mutex and hold it, then lock a Fusyn
> mutex (anyone disagree?). That is assuming Fusyn stays in user space.

Well yeah, but you could lock a fusyn, then invoke a system call which
locks a kernel semaphore.

Regards,
Joe
--
"Money can buy bandwidth, but latency is forever" -- John Mashey
