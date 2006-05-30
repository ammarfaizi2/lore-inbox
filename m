Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWE3MBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWE3MBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWE3MBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:01:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:15243 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750924AbWE3MBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:01:50 -0400
Date: Tue, 30 May 2006 14:02:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
Message-ID: <20060530120201.GA8073@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148990326.7599.4.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2006-05-30 at 13:11 +0200, Ingo Molnar wrote:
> > Subject: lock validator, fix NULL type->name bug
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > this should fix the bug reported Mike Galbraith: pass in a non-NULL 
> > mutex name string even if DEBUG_MUTEXES is turned off.
> 
> Well, yes and no.  It cures the oops, and it almost boots.  It passes 
> all tests, and gets to where we start mounting things...
> 
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hdc1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> 
> =====================================================
> [ BUG: possible circular locking deadlock detected! ]
> -----------------------------------------------------
> mount/2545 is trying to acquire lock:
>  (&ni->mrec_lock){--..}, at: [<b13d1563>] mutex_lock+0x8/0xa
> 
> ...and deadlocks.

hm, and no other messages? Are you using serial logging?

	Ingo
