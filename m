Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVIWHRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVIWHRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVIWHRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:17:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48529
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750725AbVIWHRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:17:38 -0400
Date: Fri, 23 Sep 2005 00:17:29 -0700 (PDT)
Message-Id: <20050923.001729.101033164.davem@davemloft.net>
To: akpm@osdl.org
Cc: kiran@scalex86.org, rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and bigrefs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050923001013.28b7f032.akpm@osdl.org>
References: <20050923062529.GA4209@localhost.localdomain>
	<20050923001013.28b7f032.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Fri, 23 Sep 2005 00:10:13 -0700

> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > Hi Andrew,
> > This patchset contains alloc_percpu + bigrefs + bigrefs for netdevice
> > refcount.  This patchset improves tbench lo performance by 6% on a 8 way IBM
> > x445.
> 
> I think we'd need more comprehensive benchmarks than this before adding
> large amounts of complex core code.

I agree.  tbench over loopback is about as far from real life
as it gets.

I'm still against expanding these networking datastructures with
bigrefs just for this stuff.  Some people have per-cpu and per-node on
the brain, and it's starting to bloat things up a little bit too much.
