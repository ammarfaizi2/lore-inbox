Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTIJKHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbTIJKHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:07:39 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:26156 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261692AbTIJKHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:07:36 -0400
Date: Wed, 10 Sep 2003 12:07:29 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Luca Veraldi <luca.veraldi@katamail.com>, alexander.riesen@synopsys.COM,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910120729.C14352@devserv.devel.redhat.com>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910095255.GA21313@mail.jlokier.co.uk>; from jamie@shareable.org on Wed, Sep 10, 2003 at 10:52:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:52:55AM +0100, Jamie Lokier wrote:
> Arjan van de Ven wrote:
> > > The overhead implied by a memcpy() is the same, in the oder of magnitude,
> > > ***whatever*** kernel version you can develop.
> > 
> > yes a copy of a page is about 3000 to 4000 cycles on an x86 box in the
> > uncached case. A pagetable operation (like the cpu setting the accessed
> > or dirty bit) is in that same order I suspect (maybe half this, but not
> > a lot less). Changing pagetable content is even more because all the
> > tlb's and internal cpu state will need to be flushed... which is also a
> > microcode operation for the cpu. And it's deadly in an SMP environment.
> 
> I have just done a measurement on a 366MHz PII Celeron

This test is sort of the worst case against my argument:
1) It's a cpu with low memory bandwidth
2) It's a 1 CPU system
3) It's a pII not pIV; the pII is way more efficient cycle wise
   for pagetable operations

