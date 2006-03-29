Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWC2CFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWC2CFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWC2CFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:05:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11915
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750751AbWC2CFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:05:49 -0500
Date: Tue, 28 Mar 2006 18:06:05 -0800 (PST)
Message-Id: <20060328.180605.96459770.davem@davemloft.net>
To: horms@verge.net.au
Cc: penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: optimize constant-size kzalloc calls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060329015745.GA29301@verge.net.au>
References: <1142868958.11159.0.camel@localhost>
	<20060329015745.GA29301@verge.net.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horms <horms@verge.net.au>
Date: Wed, 29 Mar 2006 10:57:46 +0900

> I feel like I mist be dreaming, but this patch, which was inlcuded
> in Linus' tree as 40c07ae8daa659b8feb149c84731629386873c16 calls
> __you_cannot_kzalloc_that_much(), but that does not seem to exist.
> 
> On i386 at least that causes a build failure

It's a purposeful build time error introduced so that invalid calls
that specify too large kzalloc() length arguments are caught at build
time.
