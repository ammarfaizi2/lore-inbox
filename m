Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWAEPTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWAEPTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWAEPTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:19:55 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:39593 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751416AbWAEPTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:19:54 -0500
Date: Thu, 5 Jan 2006 16:19:15 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
cc: Steven Rostedt <rostedt@goodmis.org>, Vegard Lima <Vegard.Lima@hia.no>,
       <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt1-sr1: xfs mount crash
In-Reply-To: <1136473721.31011.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0601051618200.3110-100000@lifa02.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Daniel Walker wrote:

> On Thu, 2006-01-05 at 08:38 -0500, Steven Rostedt wrote:
>
> > Hi Vergard,
> >
> > I just want to make sure I understand the above.
> >
> > The bug happens when CONFIG_DEBUG_RT_LOCKING_MODE is _not_ set?
> >
> > And the bug goes away when it _is_ set?
>
>
> Looks like a race , so maybe a timing issue. Just turn on some debugging
> in the code path that slows/speeds things just enough .
>
> Daniel

CONFIG_DEBUG_RT_LOCKING_MODE turns spinlock_t into raw_spinlock_t again as
far as I can see. It is probably some spinlock_t which has to be a
raw_spinlock_t for the time being.

Esben

>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

