Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUHDDg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUHDDg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 23:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHDDg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 23:36:56 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:9106 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S265348AbUHDDgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 23:36:54 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Solving suspend-level confusion
Date: Tue, 3 Aug 2004 20:30:41 -0700
User-Agent: KMail/1.6.2
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston>
In-Reply-To: <1091588163.5225.77.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408032030.41410.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 August 2004 19:56, Benjamin Herrenschmidt wrote:

> Actually, I took a shortcut with my PPC implementation of swsusp,
> which was to tweak the numbering of PM_SUSPEND_* so that
> 
>  PM_SUSPEND_STANDBY	= 1
>  PM_SUSPEND_MEM		= 3
>  PM_SUSPEND_DISK	= 4
> 
> Which has the "side effect" of matching S states and mostly D states
> with the exception of disk, for the few drivers that care...

So long as there's a comment explaining what's going on there
("original PCI PM API compatibility") this wins hugely on expedience!


> But in the long run, this may add confusion instead of clearing things,
> I agree we should rather move to completely different types, though I
> don't feel like re-typing every callbacks in the tree right now...

Me either.  But renumbering the PM_SUSPEND_* values would let folk
start discussing what PM should be (and do) without that particular
pressure.

- Dave

