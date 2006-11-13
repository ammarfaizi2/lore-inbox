Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933164AbWKMXgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933164AbWKMXgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933168AbWKMXgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:36:17 -0500
Received: from mga07.intel.com ([143.182.124.22]:54666 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S933164AbWKMXgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:36:16 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,419,1157353200"; 
   d="scan'208"; a="145654029:sNHT22499834"
Subject: Re: 2.6.19-rc5: known regressions
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1u01919yu.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de>
	 <m1y7qm425l.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0611080745150.3667@g5.osdl.org>
	 <20061108162202.GA4729@stusta.de>
	 <1163027494.10806.229.camel@localhost.localdomain>
	 <1163040581.10806.266.camel@localhost.localdomain>
	 <m1u01919yu.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Intel
Date: Mon, 13 Nov 2006 14:46:44 -0800
Message-Id: <1163458004.10806.276.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 22:10 -0700, Eric W. Biederman wrote:

> 
> Cool.  I'm glad to know it was simply a buggy lmbench.
> 
> What is sysconf(_SN_NPROCESSORS_ONLN) doing that it slows down as the
> number of irqs increase?  It is a slow path certainly but possibly
> something we should fix.  My hunch is cat /proc/cpuinfo...
> 

The increase in time of sysconf(_SN_NPROCESSORS_ONLN) call
is within "show_stat" function after looking at profiling data.  
There are a couple of loops that iterate over kstat_irqs 
interrupt statistics and depend on NR_IRQS.  Doesn't 
look like something we need to fix.

Tim
