Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbULFKB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbULFKB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 05:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbULFKB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 05:01:28 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:17374 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261478AbULFKBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 05:01:18 -0500
Date: Mon, 6 Dec 2004 03:00:45 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: [RFC] Strange code in cpu_idle()
In-Reply-To: <20041206174604.036c5b08.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.61.0412060258411.1036@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com> <20041206111634.44d6d29c.sfr@canb.auug.org.au>
 <20041206174604.036c5b08.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Stephen Rothwell wrote:

> On Mon, 6 Dec 2004 11:16:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > > Thoughts?
> > 
> > None, sorry :-)
> 
> Actually, Rusty suggests stop_machine() ...

Hmm i believe there is a window with CONFIG_PREEMPT whereupon we read the 
pm_idle pointer, get scheduled out to run the stopmachine thread and 
return with the stale pointer.

Thanks,
	Zwane

