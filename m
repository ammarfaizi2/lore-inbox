Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbTEGDvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 23:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTEGDvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 23:51:53 -0400
Received: from dp.samba.org ([66.70.73.150]:4742 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262871AbTEGDvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 23:51:52 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16056.34210.319959.255815@argo.ozlabs.ibm.com>
Date: Wed, 7 May 2003 14:03:46 +1000
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] kmalloc_percpu
In-Reply-To: <20030507024135.GW8978@holomorphy.com>
References: <20030506014745.02508f0d.akpm@digeo.com>
	<20030507023126.12F702C019@lists.samba.org>
	<20030507024135.GW8978@holomorphy.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
> On Wed, May 07, 2003 at 11:57:13AM +1000, Rusty Russell wrote:
> > Paul Mackerras points out that we could get the numa-aware allocation
> > plus "one big alloc" properties by playing with page mappings: reserve
> > 1MB of virtual address, and map more pages as required.  I didn't
> > think that we'd need that yet, though.
> 
> This is somewhat painful to do (though possible) on i386. The cost of
> task migration would increase at the very least.

Explain?  We're not talking about having the same address mapped
differently on different CPUs, we're just talking about something
which is the equivalent of a sparsely-instantiated vmalloc.

Paul.
