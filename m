Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUF1Fu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUF1Fu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbUF1FuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:50:19 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:21965 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264781AbUF1Fme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:42:34 -0400
Date: Sun, 27 Jun 2004 22:42:27 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040628054227.GB4025@taniwha.stupidest.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain> <20040627000541.GA13325@taniwha.stupidest.org> <pan.2004.06.27.12.00.03.857572@smurf.noris.de> <20040627224115.GA22532@taniwha.stupidest.org> <20040628012407.GC4648@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628012407.GC4648@kiste>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 03:24:07AM +0200, Matthias Urlichs wrote:

> A simple __get_jiffies() implementation could just set up a
> 1/HZ-second timer (and busy-wait for it, and increase its internal
> jiffies counter) every tenth call or so. That would probably slow
> down the whole system somewhat, but I'd assume it'd mostly work.

I think the approach is to look at _why_ people need jiffies and
change this to a cleaner less low-level API using accessor
functions/macros.


  --cw
