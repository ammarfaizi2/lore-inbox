Return-Path: <linux-kernel-owner+w=401wt.eu-S1751179AbXAFFeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbXAFFeJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 00:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbXAFFeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 00:34:09 -0500
Received: from ozlabs.org ([203.10.76.45]:50507 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbXAFFeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 00:34:08 -0500
Subject: Re: [patch] paravirt: isolate module ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <1168049229.3101.15.camel@laptopd505.fenrus.org>
References: <20070106000715.GA6688@elte.hu>  <459EF537.6090301@vmware.com>
	 <1168049229.3101.15.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 16:34:01 +1100
Message-Id: <1168061641.20372.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-05 at 18:07 -0800, Arjan van de Ven wrote:
> > 
> > I would suggest a slightly different carving.  For one, no TLB flushes.  
> > If you can't modify PTEs, why do you need to have TLB flushes?  And I 
> > would allow CR0 read / write for code which saves and restores FPU state 
> 
> no that is abstracted away by kernel_fpu_begin/end. Modules have no
> business doing that themselves

Sure, but it'll take some time to fix the raid modules (which are the
ones which abuse this).

I'm testing a patch now, I'll send the clts removal patch on top of that
once it's done.

Rusty.

