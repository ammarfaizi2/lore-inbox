Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbTHBPOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 11:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbTHBPOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 11:14:36 -0400
Received: from [66.212.224.118] ([66.212.224.118]:23044 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S268160AbTHBPOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 11:14:35 -0400
Date: Sat, 2 Aug 2003 11:02:53 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
In-Reply-To: <20030802144310.GH22824@waste.org>
Message-ID: <Pine.LNX.4.53.0308021102260.3473@montezuma.mastecende.com>
References: <20030802042445.GD22824@waste.org> <20030802040015.0fcafda2.akpm@osdl.org>
 <Pine.LNX.4.53.0308020832520.3473@montezuma.mastecende.com>
 <20030802144310.GH22824@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Aug 2003, Matt Mackall wrote:

> On Sat, Aug 02, 2003 at 08:35:22AM -0400, Zwane Mwaikambo wrote:
> > On Sat, 2 Aug 2003, Andrew Morton wrote:
> > > Cannot perform userspace access while holding a lock - a pagefault could
> > > occur, perform IO, schedule away and the same CPU tries to take the same
> > > lock via a different process.
> > 
> > Perhaps might_sleep() in *_user, copy_* etc is in order?
> 
> Wouldn't have caught this case - this interface hasn't actually been
> used/useful for many years as it only gives access to one of the
> pools and has never been atomic either.

Aha, thanks for the explanation.

	Zwane
-- 
function.linuxpower.ca
