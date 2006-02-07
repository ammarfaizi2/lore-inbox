Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWBGBhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWBGBhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWBGBhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:37:39 -0500
Received: from quechua.inka.de ([193.197.184.2]:42462 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932438AbWBGBhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:37:38 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: implement swap prefetching
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060206163842.7ff70c49.akpm@osdl.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1F6HnU-0000TT-00@calista.inka.de>
Date: Tue, 07 Feb 2006 02:37:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>> +/*
>> + * How many pages to prefetch at a time. We prefetch SWAP_CLUSTER_MAX *
>> + * swap_prefetch per PREFETCH_INTERVAL, but prefetch ten times as much at a
>> + * time in laptop_mode to minimise the time we keep the disk spinning.
>> + */
>> +static inline unsigned long prefetch_pages(void)
>> +{
>> +     return (SWAP_CLUSTER_MAX * swap_prefetch * (1 + 9 * !!laptop_mode));
>> +}
> 
> I don't think this should be done in-kernel.  There's a nice script to
> start and stop laptop mode.  We can make this decision in that script.

I agree, the default could be depending on laptop mode, but if a value is
specified or changed by sysctl, it should not be automatically tuned (in
that case)

Gruss
Bernd
