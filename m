Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVEYVFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVEYVFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVEYVFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:05:38 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:54918 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261566AbVEYVFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:05:25 -0400
Date: Wed, 25 May 2005 23:05:05 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Tom Vier <tmv@comcast.net>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050525205841.GB28913@zero>
Message-Id: <Pine.OSF.4.05.10505252303300.23201-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 May 2005, Tom Vier wrote:

> If irqs are run in threads, which are scheduled, how are they scheduled?
> fifo? What's the point then; simply to let the top half run to completion
> before another top half starts? If it's about setting scheduling priorities
> for irq threads, some one top half can prempt another, why not just use irq
> levels, like bsd (using pic's is slower than using threads?)?
>
Long interrupt handlers can be interrupt by _tasks_, not only other
interrupts! An audio application running in userspace can be scheduled
over an ethernet interrupt handler copying data from the
controller into RAM (without DMA).

Esben

