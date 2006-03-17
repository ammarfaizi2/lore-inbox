Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752477AbWCQBKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbWCQBKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbWCQBKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:10:47 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:46740 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1752477AbWCQBKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:10:46 -0500
X-IronPort-AV: i="4.03,103,1141632000"; 
   d="scan'208"; a="262446959:sNHT31013172"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Remapping pages mapped to userspace
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
	<Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	<adad5gmne20.fsf_-_@cisco.com>
	<1142553361.15045.19.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Mar 2006 17:10:45 -0800
In-Reply-To: <1142553361.15045.19.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 16 Mar 2006 15:56:01 -0800")
Message-ID: <adau09xnaei.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Mar 2006 01:10:45.0731 (UTC) FILETIME=[9E8BA330:01C6495F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Why would you not want accesses to explode?  Exploding
    Bryan> seems like the right behaviour to me, since there's no
    Bryan> hardware for userspace to talk to any more.

I think it is better for userspace to be notified that the hardware is
gone, and have any accesses before it acts on that notification to be
silently discarded.

 - R.
