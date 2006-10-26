Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423560AbWJZXUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423560AbWJZXUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423684AbWJZXUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:20:03 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:4020 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1423560AbWJZXT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:19:59 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, iss_storagedev@hp.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH cciss: fix printk format warning
X-Message-Flag: Warning: May contain useful information
References: <20061023214608.f09074e9.randy.dunlap@oracle.com>
	<20061026160245.26f86ce2.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 26 Oct 2006 16:19:56 -0700
In-Reply-To: <20061026160245.26f86ce2.akpm@osdl.org> (Andrew Morton's message of "Thu, 26 Oct 2006 16:02:45 -0700")
Message-ID: <ada64e67jhf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Oct 2006 23:19:56.0582 (UTC) FILETIME=[3FE00460:01C6F955]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > >  	if (*total_size != (__u32) 0)
 > 
 > Why is cciss_read_capacity casting *total_size to u32?

It's not -- it's actually casting 0 to __32 -- there's no cast on the
*total_size side of the comparison.  However that just makes the cast
look even fishier.

 - R.
