Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUHBFOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUHBFOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 01:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUHBFOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 01:14:07 -0400
Received: from digitalimplant.org ([64.62.235.95]:6302 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266259AbUHBFOF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 01:14:05 -0400
Date: Sun, 1 Aug 2004 22:13:34 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [0/25] Merge pmdisk and swsusp
In-Reply-To: <20040718222704.GG31958@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.50.0408012210550.8159-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
 <20040718222704.GG31958@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jul 2004, Pavel Machek wrote:

> > <mochel@digitalimplant.org> (04/07/17 1.1865)
> >    [swsusp] Remove unneeded suspend_pagedir_lock.
>
> How do you guarantee that while copying pages back and forth,
> interrupts are disabled? They have to be, because memory snapshots are
> no longer atomic.

(This was cleared up in person in Ottawa, but just for the record: )

Interrupts are disabled in swsusp_suspend() and swsusp_resume(), using
local_irq_disable(), instead of doing spin_lock_irq().


	Pat
