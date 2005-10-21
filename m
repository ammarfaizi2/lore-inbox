Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVJUUdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVJUUdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbVJUUdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:33:12 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:6304 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S965140AbVJUUdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:33:12 -0400
Message-ID: <43595071.1090906@oracle.com>
Date: Fri, 21 Oct 2005 13:32:49 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, hch@infradead.org, adilger@clusterfs.com
Subject: Re: [RFC] page lock ordering and OCFS2
References: <20051017222051.GA26414@tetsuo.zabbo.net>	<20051017161744.7df90a67.akpm@osdl.org>	<43544499.5010601@oracle.com>	<435928BC.5000509@oracle.com> <20051021105811.2de09059.akpm@osdl.org>
In-Reply-To: <20051021105811.2de09059.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> patches/add-wake_up_page_all.patch:+EXPORT_SYMBOL(__wake_up_bit_all);
>> patches/add-wake_up_page_all.patch:+EXPORT_SYMBOL(wake_up_page_all);
>> patches/export-pagevec-helpers.patch:+EXPORT_SYMBOL_GPL(pagevec_lookup);
>> patches/export-page_waitqueue.patch:+EXPORT_SYMBOL_GPL(page_waitqueue);
>> patches/export-truncate_complete_pate.patch:+EXPORT_SYMBOL(truncate_complete_page);
>> patches/export-wake_up_page.patch:+EXPORT_SYMBOL(wake_up_page);
> 
> 
> Exporting page_waitqueue seems wrong.  Might be better to add a core
> function to do the wait_event(*page_waitqueue(page), PageFsMisc(page)); and
> export that.

Sure thing.

> How did you come up with this mix of GPL and non-GPL?

Carelessness.  I'll aim for _GPL for anything that still needs to be exported.

> The above looks sane enough.  Please run it by Bill?

OK.

- z

