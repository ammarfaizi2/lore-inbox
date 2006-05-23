Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWEWQ7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWEWQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWEWQ7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:59:47 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:8447 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750795AbWEWQ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:59:47 -0400
Message-ID: <44733F7B.9070009@de.ibm.com>
Date: Tue, 23 May 2006 18:59:39 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Balbir Singh <balbir@in.ibm.com>
Subject: Re: [Patch 0/6] statistics infrastructure
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060519092411.6b859b51.akpm@osdl.org>
In-Reply-To: <20060519092411.6b859b51.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Peschke <mp3@de.ibm.com> wrote:
>> My patch series is a proposal for a generic implementation of statistics.
> 
> This uses debugfs for the user interface, but the
> per-task-delay-accounting-*.patch series from Balbir creates an extensible
> netlink-based system for passing instrumentation results back to userspace.
> 
> Can this code be converted to use those netlink interfaces, or is Balbir's
> approach unsuitable, or hasn't it even been considered, or what?
> 

Andrew,

taskstats, Balbir'r approach, is too specific and doesn't work for me.
It is by design limited to per-task data.

My statistics code is not limited to per-task statistics, but allows exploiters
to have data been accumulated and been shown for whatever entity they need to,
may it be for tasks, for SCSI disks, per adapter, per queue, per interface,
for a device driver, etc.

If you want me to change my code to use netlink anyway, I might be able to
implement my own genetlink family. I haven't look at the details of that yet.

	Martin



