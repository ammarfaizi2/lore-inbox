Return-Path: <linux-kernel-owner+w=401wt.eu-S1762706AbWLKK5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762706AbWLKK5p (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762697AbWLKK5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:57:45 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:45023 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762748AbWLKK5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:57:44 -0500
Message-ID: <457D39A2.1070802@garzik.org>
Date: Mon, 11 Dec 2006 05:57:38 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Al Viro <viro@ftp.linux.org.uk>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>	<20061211005557.04643a75.akpm@osdl.org>	<20061211011327.f9478117.akpm@osdl.org>	<20061211092130.GB4587@ftp.linux.org.uk>	<20061211012545.ed945cbd.akpm@osdl.org>	<20061211093314.GC4587@ftp.linux.org.uk>	<20061211014727.21c4ab25.akpm@osdl.org>	<20061211100301.GD4587@ftp.linux.org.uk>	<20061211021718.a6954106.akpm@osdl.org>	<20061211102207.GE4587@ftp.linux.org.uk> <20061211023436.258bb3ea.akpm@osdl.org>
In-Reply-To: <20061211023436.258bb3ea.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> A heck of a lot of things can trigger an /sbin/hotplug run.  It could well
> be that Andrew's driver didn't want to run hotplug at all, but the kernel
> did it anwyay.  But as soon as the script appeared at /sbin/hotplug, and it
> happened to use foo|bar: boom.

In fact, <many> things run /sbin/hotplug but don't necessarily need to :/

I think bcrl used a counter one time, and saw over 1000 /sbin/hotplug 
executions during a single boot.

	Jeff


