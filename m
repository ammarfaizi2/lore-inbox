Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWBVUXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWBVUXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWBVUXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:23:43 -0500
Received: from ns2.suse.de ([195.135.220.15]:22424 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422660AbWBVUX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:23:29 -0500
From: Chris Mason <mason@suse.de>
To: Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] Enable remote RCU callback processing on SMP systems
Date: Wed, 22 Feb 2006 15:23:22 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, okir@suse.de
References: <20060206145137.GA30059@sgi.com>
In-Reply-To: <20060206145137.GA30059@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221523.23739.mason@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 09:51, Dimitri Sivanich wrote:
> Reposting this patch that I'd submitted back on 1/26.  Any thoughts on
> the basic approach in addition to the code itself?  Is it possible to
> get this applied?  Note that this should have negligible effect on
> those not configuring remote rcu callback processing.

Aside from the possible race we talked about in __rcu_process_callbacks, I 
don't have huge objections here.  But if the underlying problem is the cost 
of kmem_cache_free, would it be better to limit that instead of trying to 
push the latency around to specific cpus?

-chris
