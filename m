Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270000AbTGVKFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270487AbTGVKFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:05:22 -0400
Received: from [213.39.233.138] ([213.39.233.138]:11480 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S270688AbTGVKFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:05:19 -0400
Date: Tue, 22 Jul 2003 12:20:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Valdis.Kletnieks@vt.edu
Cc: junkio@cox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Port SquashFS to 2.6
Message-ID: <20030722102014.GC29430@wohnheim.fh-wedel.de>
References: <fa.k0do8p6.ch6pps@ifi.uio.no> <fa.hre90bn.e6k5pf@ifi.uio.no> <7vd6g3uvbc.fsf@assigned-by-dhcp.cox.net> <200307220342.h6M3gbgf003555@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307220342.h6M3gbgf003555@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 July 2003 23:42:37 -0400, Valdis.Kletnieks@vt.edu wrote:
> 
> Not necessarily.  It's quite possible (likely even) that one architecture might
> have N bytes overhead per call,  and is allowed a 4K stack, and some other
> architecture has (N+30%) overhead, so 4K isn't enough - 5K is needed. However,
> other considerations cause a whole-page allocation, so instead of allocating
> 5K, it goes to 8K, with a 3K wastage....

And even worse, for short call chains, 4.1k would be enough, but for
long ones, you need up to 5.2k.  How much is too much?  We don't know
and it depends, so make a pessimistic guess.

Joern
