Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269487AbUINSiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269487AbUINSiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269698AbUINS3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:29:53 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:47614 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269699AbUINSRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:17:50 -0400
Date: Tue, 14 Sep 2004 14:22:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] sched: fix scheduling latencies in mtrr.c
In-Reply-To: <20040914132536.GA9742@elte.hu>
Message-ID: <Pine.LNX.4.53.0409141418280.2297@montezuma.fsmlabs.com>
References: <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu>
 <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu>
 <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu>
 <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu>
 <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu>
 <20040914132536.GA9742@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, Ingo Molnar wrote:

> 
> > fix scheduling latencies in the MTRR-setting codepath.
> > Also, fix bad bug: MTRR's _must_ be set with interrupts disabled!
> 
> patch attached ...
> 
> caveat: one of the wbinvd() removals is correct i believe, but the other
> one might be problematic. It doesnt seem logical to do a wbinvd() at
> that point though ...

Just a data point, Volume 3 "MTRR considerations in MP systems" states 
that the second wbinvd() isn't required for P6 and Pentium 4 but might be 
necessary for future systems.

	Zwane

