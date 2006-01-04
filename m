Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWADAV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWADAV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWADAV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:21:27 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:58564 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S964893AbWADAV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:21:26 -0500
Date: Tue, 3 Jan 2006 16:21:13 -0800
From: Greg KH <greg@kroah.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Patch 6/6] Delay accounting: Connector interface
Message-ID: <20060104002112.GA18730@kroah.com>
References: <43BB05D8.6070101@watson.ibm.com> <43BB09D4.2060209@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BB09D4.2060209@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 11:33:40PM +0000, Shailabh Nagar wrote:
> Changes since 11/14/05:
> 
> - explicit versioning of statistics data returned
> - new command type for returning per-tgid stats
> - for cpu running time, use tsk->sched_info.cpu_time (collected by schedstats)
> 
> First post 11/14/05
> 
> delayacct-connector.patch
> 
> Creates a connector interface for getting delay and cpu statistics of tasks
> during their lifetime and when they exit. The cpu stats are available only if
> CONFIG_SCHEDSTATS is enabled.

Why do you use this when we can send typesafe data through netlink
messages now?  Because of that, I think the whole connector code can be
deleted :)

Unless I missed something in the connector code that is not present in
netlink...

thanks,

greg k-h
