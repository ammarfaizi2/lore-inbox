Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVCPMXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVCPMXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVCPMXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:23:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:16831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262553AbVCPMX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:23:28 -0500
Date: Wed, 16 Mar 2005 04:23:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: noahm@csail.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-Id: <20050316042306.259ba8e1.akpm@osdl.org>
In-Reply-To: <20050316003134.GY7699@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu>
	<20050316003134.GY7699@opteron.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> -	ret = dqstats.allocated_dquots;
>  +	ret = (dqstats.free_dquots / 100) * sysctl_vfs_cache_pressure;

Oh I see.  Yes, using .allocated_dquots was wrong.
