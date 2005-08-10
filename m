Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbVHJX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbVHJX0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHJX0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:26:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:2194 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932600AbVHJX0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:26:16 -0400
Date: Thu, 11 Aug 2005 01:26:15 +0200
From: Andi Kleen <ak@suse.de>
To: Mike Waychison <mikew@google.com>
Cc: YhLu <YhLu@tyan.com>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org,
       "'discuss@x86-64.org'" <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Message-ID: <20050810232614.GC27628@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB> <42FA8A4B.4090408@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA8A4B.4090408@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 04:14:19PM -0700, Mike Waychison wrote:
> YhLu wrote:
> >andi,
> >
> >please refer the patch, it will move cpu_set(, cpu_callin_map) from
> >smi_callin to start_secondary.
> 
> 
> This patch fixes an apparent race / lockup on our 2-way dual cores (when 
> applied against 2.6.12.3).  The machine was locking up after 
> "Initializing CPU#2".

The real solution for this issue is the smp_call_function_single patch from Eric
that I reposted yesterday. Yh's patch just changed the timing slightly.


-Andi
