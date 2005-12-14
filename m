Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVLNC5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVLNC5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVLNC5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:57:12 -0500
Received: from cantor2.suse.de ([195.135.220.15]:52154 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932526AbVLNC5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:57:12 -0500
Date: Wed, 14 Dec 2005 03:57:10 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] atomic_long_t & include/asm-generic/atomic.h V2
Message-ID: <20051214025710.GD23384@wotan.suse.de>
References: <Pine.LNX.4.62.0512131417390.24002@schroedinger.engr.sgi.com> <20051213154916.6667b6d8.akpm@osdl.org> <Pine.LNX.4.62.0512131849550.24909@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512131849550.24909@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How about requiring that all 64-bit archs implement atomic64_t and do:
> 
> It may be reasonable to have 64 bit arches that are not 
> capable of 64 bit atomic ops. As far as I can remember sparc was initially
> a 32 bit platform without 32 bit atomic ops.

Why? I don't think we have any crippled 64bit platforms like this.
And if somebody wants to port linux to such a hypothetical crippled
64bit platform they can do the necessary work themselves.

Or just implement 64bit atomic_t with spinlocks.

-Andi
