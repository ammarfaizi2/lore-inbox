Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVBQXeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVBQXeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVBQXcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:32:43 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:32903
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261242AbVBQXaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:30:55 -0500
Date: Thu, 17 Feb 2005 15:30:31 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@suse.de>
Cc: benh@kernel.crashing.org, ak@suse.de, nickpiggin@yahoo.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
Message-Id: <20050217153031.011f873f.davem@davemloft.net>
In-Reply-To: <20050217230342.GA3115@wotan.suse.de>
References: <4214A1EC.4070102@yahoo.com.au>
	<4214A437.8050900@yahoo.com.au>
	<20050217194336.GA8314@wotan.suse.de>
	<1108680578.5665.14.camel@gaston>
	<20050217230342.GA3115@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 00:03:42 +0100
Andi Kleen <ak@suse.de> wrote:

> And to be honest we only have about 6 or 7 of these walkers
> in the whole kernel. And 90% of them are in memory.c
> While doing 4level I think I changed all of them around several
> times and it wasn't that big an issue.  So it's not that we
> have a big pressing problem here... 

It's super error prone.  A regression added by your edit of these
walkers for the 4level changes was only discovered and fixed
yesterday by the ppc folks.

I absolutely support any change which consolidates these things.
