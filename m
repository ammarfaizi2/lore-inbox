Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWE3MGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWE3MGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWE3MGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:06:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:25002 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751415AbWE3MGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:06:22 -0400
Date: Tue, 30 May 2006 14:06:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
Message-ID: <20060530120641.GA8263@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer> <1148990725.8610.1.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148990725.8610.1.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2006-05-30 at 13:58 +0200, Mike Galbraith wrote:
> 
> > =====================================================
> > [ BUG: possible circular locking deadlock detected! ]
> > -----------------------------------------------------
> > mount/2545 is trying to acquire lock:
> >  (&ni->mrec_lock){--..}, at: [<b13d1563>] mutex_lock+0x8/0xa
> > 
> > ...and deadlocks.
> > 
> > I'll try to find out what it hates.
> 
> It hates NTFS.

i'd still love to figure out what's going on here.

hmm ... do you have the NMI watchdog enabled? Could you try with 
nmi_watchdog=0?

	Ingo
