Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265258AbUETWXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUETWXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbUETWXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:23:36 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:26887 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S265258AbUETWXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:23:33 -0400
Date: Thu, 20 May 2004 15:25:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: davidm@hpl.hp.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
Message-Id: <20040520152510.02de52a1.akpm@osdl.org>
In-Reply-To: <200405201810.48141.jbarnes@engr.sgi.com>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
	<16557.4709.694265.314748@napali.hpl.hp.com>
	<20040520145658.3a7bf7df.akpm@osdl.org>
	<200405201810.48141.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2004 22:22:30.0119 (UTC) FILETIME=[F063BF70:01C43EB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> On Thursday, May 20, 2004 5:56 pm, Andrew Morton wrote:
> > An alternative might be to remove all the ifdefs, build with
> > -ffunction-sections and let the linker drop any unreferenced code...
> 
> That would probably be even more confusing than the #ifdefs.  At least with 
> those you know that you need to check whether the current code will be 
> called...
> 

Me no understand Jesse.

Removing the ifdefs and letting the linker do the job has the advantage
that the compiler gets to check more code for you.
