Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVLNEHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVLNEHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 23:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbVLNEHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 23:07:09 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:18414 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030431AbVLNEHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 23:07:07 -0500
Date: Tue, 13 Dec 2005 20:06:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: dada1@cosmosbay.com, clameter@engr.sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051213200651.44845df4.pj@sgi.com>
In-Reply-To: <20051214040236.GF23384@wotan.suse.de>
References: <20051212020211.1394bc17.pj@sgi.com>
	<20051212021247.388385da.akpm@osdl.org>
	<20051213075345.c39f335d.pj@sgi.com>
	<439EF75D.50206@cosmosbay.com>
	<Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
	<439F0B43.4080500@cosmosbay.com>
	<20051213130350.464a3054.pj@sgi.com>
	<439F3F6E.6010701@cosmosbay.com>
	<20051213142346.ccd3081a.pj@sgi.com>
	<20051213195457.4e2b31af.pj@sgi.com>
	<20051214040236.GF23384@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> That is why call_rcu.et.al. is a better interface if you want performance.
> It runs the freeing batched in the background.

True.

In this case, my free'ing code is non-trivial, and my performance
requirements very minimal.  So I'll take the easier synchronize_rcu()
over the asynchronous call_rcu().

But, yes, that's the tradeoff.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
