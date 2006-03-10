Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752055AbWCJWVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbWCJWVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWCJWVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:21:06 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:26152 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1752055AbWCJWVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:21:05 -0500
X-IronPort-AV: i="4.02,181,1139212800"; 
   d="scan'208"; a="414542740:sNHT30803632"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <gregkh@suse.de>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	<ada8xrjfbd8.fsf@cisco.com>
	<1141948367.10693.53.camel@serpentine.pathscale.com>
	<20060310004505.GB17050@suse.de>
	<1141951725.10693.88.camel@serpentine.pathscale.com>
	<20060310010403.GC9945@suse.de>
	<1141965696.14517.4.camel@camp4.serpentine.com>
	<ada7j72detl.fsf@cisco.com>
	<1141998230.28926.4.camel@localhost.localdomain>
	<ada1wxab533.fsf@cisco.com>
	<1142011952.29925.54.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 10 Mar 2006 14:20:54 -0800
In-Reply-To: <1142011952.29925.54.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Fri, 10 Mar 2006 09:32:32 -0800")
Message-ID: <adawtf29c1l.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 22:20:54.0907 (UTC) FILETIME=[E5DCCCB0:01C64490]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Probably not much.  The motivation was to ensure that if it
    Bryan> got incremented during an iteration, whoever was iterating
    Bryan> would see the update in a timely fashion.

But as far as I can see, you never do atomic_inc() -- only
atomic_set() under a spinlock.
