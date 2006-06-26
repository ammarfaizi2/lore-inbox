Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932933AbWFZTNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbWFZTNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWFZTNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:13:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:52365 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932933AbWFZTNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:13:20 -0400
Message-ID: <44A03198.3060909@watson.ibm.com>
Date: Mon, 26 Jun 2006 15:12:24 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, Balbir Singh <balbir@in.ibm.com>,
       Chris Sturtivant <csturtiv@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] delay accounting taskstats interface send tgid once
References: <44A02331.8020903@watson.ibm.com> <44A02FB0.6000505@sgi.com>
In-Reply-To: <44A02FB0.6000505@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Shailabh,
> 
> Is this patch supposed to go on top of all other patches? Or is it
> supposed to replace any? I had failure applying this patch on top
> of all previously applied.

This is my series file (effectively). So it should have applied on
top of the new lock patch (which is now integrated into -mm2). But I'll send out
another one that's explicitly on top of the -mm2 patchset. Since we've been
privately exchanging patches, the series wasn't clear.

--Shailabh


Series for this patch:

#********** 2.6.17-mm1 patchset, ported to 2.6.17, start
per-task-delay-accounting-setup.patch
per-task-delay-accounting-setup-fix-1.patch
per-task-delay-accounting-setup-fix-2.patch
per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection.patch
per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection-fix-1.patch
per-task-delay-accounting-cpu-delay-collection-via-schedstats.patch
per-task-delay-accounting-cpu-delay-collection-via-schedstats-fix-1.patch
per-task-delay-accounting-utilities-for-genetlink-usage.patch
per-task-delay-accounting-taskstats-interface.patch
per-task-delay-accounting-taskstats-interface-fix-1.patch
per-task-delay-accounting-taskstats-interface-fix-2.patch
per-task-delay-accounting-taskstats-interface-fix-exit-race-in-per-task-delay-accounting.patch
per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface.patch
per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-use-portable-cputime-api-in-__delayacct_add_tsk.patch
per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-fix-return-value-of-delayacct_add_tsk.patch
per-task-delay-accounting-documentation.patch
per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays.patch
per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays-warning-fix.patch
#*********** 2.6.17-mm1 patchset, ported to 2.6.17, end
taskstats-interface-revised-exit-race-locking.patch
taskstats-interface-send-tgid-once.patch

