Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270586AbTGaXMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274867AbTGaXMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:12:12 -0400
Received: from users.ccur.com ([208.248.32.211]:3250 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S270586AbTGaXMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:12:03 -0400
Date: Thu, 31 Jul 2003 19:11:55 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-ID: <20030731231154.GB7852@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com> <20030731154740.4e21a6e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731154740.4e21a6e2.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Joe Korty <joe.korty@ccur.com> wrote:
> >
> > Lock out users from changing the cpu affinity of those per-cpu system
> > daemons which cannot survive such a change, such as migration/%d.
> 
> Generally we prefer to not add code which purely protects root from making
> mistakes.  Once the sysadmin has nuked his box he'll learn to not do it
> again.

I'd like to be able to write shell scrips that operate on the set of
/proc/[0-9]* without having to know which of the ever-changing list
of processes need to be avoided and which not.

And it's not really root.  It's a SYS_CAP_NICE capability.  All
realtime apps or their admins will have that capability as a matter
of course in their normal daily operations.

Joe
