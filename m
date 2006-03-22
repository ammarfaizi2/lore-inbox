Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWCVQoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWCVQoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWCVQoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:44:01 -0500
Received: from mx.pathscale.com ([64.160.42.68]:17835 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751376AbWCVQoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:44:00 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       rdreier@cisco.com, hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603220810170.26286@g5.osdl.org>
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
	 <1142523201.25297.56.camel@camp4.serpentine.com>
	 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
	 <1142538765.10950.16.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
	 <1142974347.29199.87.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603212316001.16342@goblin.wat.veritas.com>
	 <1143043088.17406.17.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.64.0603220810170.26286@g5.osdl.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 22 Mar 2006 08:43:59 -0800
Message-Id: <1143045839.17406.34.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 08:19 -0800, Linus Torvalds wrote:

> Ahh. Isn't this the same problem that the fairly recent "mm: compound 
> release fix" by Nick should fix?

It sure sounds like it to me.

> But anything based on 2.6.16-rc6 should be fine (The bug was fixed by 
> 2.6.16-rc3, methinks). You said:
> 
>    "First of all, it turns out that the BUG I mentioned was reported 
>     against the SLES10 2.6.16-rc6 kernel.  I haven't had a chance to chase 
>     it down yet, but I'm going to have to, because..."
> 
> but if that _really_ is 2.6.16-rc6-based, this problem should have been 
> fixed already.

I'll have to first make sure I can reproduce the problem on SLES10 beta
(since I'm not the one who saw it), then go off and take a look at the
SLES10 beta kernel source and patches to see what's going on.

The SLES10 beta kernels have been following 2.6.16 very closely (each
one has been either based on a git snapshot or a release candidate), but
there's a biggish quilt patch stack on top.  *If* there's a bug at all,
I wouldn't be surprised if it's somewhere in that pile of patches.

	<b

