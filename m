Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVESN5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVESN5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVESN5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:57:04 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:58857 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262502AbVESN5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:57:00 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Gilbert, John" <JGG@dolby.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       linux-os@analogic.com
In-Reply-To: <1116505655.6027.45.camel@laptopd505.fenrus.org>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	 <20050518195337.GX5112@stusta.de>
	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	 <20050519112840.GE5112@stusta.de>
	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	 <1116505655.6027.45.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 09:56:45 -0400
Message-Id: <1116511005.15866.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 14:27 +0200, Arjan van de Ven wrote:

> 
> >  	SMP
> userspace should not care! Any app that looks at this is buggy; remember
> the fully preemptable nature of userspace

Hmm, you seem to be assuming what userspace is looking at SMP for.  Say
you might want to run some daemon on each CPU and set affinity
accordingly, or some other reason.  But I guess you can get that
information from looking at /proc/cpuinfo, and maybe someplace else.

Really, what is needed is to get the kernel to give all the information
to libc that is needed via /proc, /sysfs, system calls, etc. such that
we can remove /usr/include/{linux,asm,asm-generic} and not worry about
user programs using kernel headers.  Users will continue to include them
as long as they are in /usr/include.  Heck what does /usr stand for
anyway?  It's not /krnl/include.

-- Steve


