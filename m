Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933202AbWKNAEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202AbWKNAEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933205AbWKNAEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:04:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44708 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S933202AbWKNAEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:04:00 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: tim.c.chen@linux.intel.com
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5: known regressions
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<m1y7qm425l.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611080745150.3667@g5.osdl.org>
	<20061108162202.GA4729@stusta.de>
	<1163027494.10806.229.camel@localhost.localdomain>
	<1163040581.10806.266.camel@localhost.localdomain>
	<m1u01919yu.fsf@ebiederm.dsl.xmission.com>
	<1163458004.10806.276.camel@localhost.localdomain>
Date: Mon, 13 Nov 2006 17:03:14 -0700
In-Reply-To: <1163458004.10806.276.camel@localhost.localdomain> (Tim Chen's
	message of "Mon, 13 Nov 2006 14:46:44 -0800")
Message-ID: <m1ac2uopx9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen <tim.c.chen@linux.intel.com> writes:

> On Wed, 2006-11-08 at 22:10 -0700, Eric W. Biederman wrote:
>
>> 
>> Cool.  I'm glad to know it was simply a buggy lmbench.
>> 
>> What is sysconf(_SN_NPROCESSORS_ONLN) doing that it slows down as the
>> number of irqs increase?  It is a slow path certainly but possibly
>> something we should fix.  My hunch is cat /proc/cpuinfo...
>> 
>
> The increase in time of sysconf(_SN_NPROCESSORS_ONLN) call
> is within "show_stat" function after looking at profiling data.  
> There are a couple of loops that iterate over kstat_irqs 
> interrupt statistics and depend on NR_IRQS.  Doesn't 
> look like something we need to fix.

Thanks.

Eric

