Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUIOPn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUIOPn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUIOPn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:43:29 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:38879 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S266490AbUIOPnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:43:17 -0400
Date: Wed, 15 Sep 2004 16:43:59 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
In-Reply-To: <Pine.LNX.3.96.1040915111445.10950I-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0409151641430.3504-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Bill Davidsen wrote:
> That's exactly why I mentioned using the per-cpu device if present. While
> having CPUs with different loaders is not a feature today, I wouldn't bet
> that will always be true. We know that AMD expects to ship dual core CPUs
> in an Opteron form factor. If I have a dual opteron system and replace one
> CPU with dual core, will I need a different loader? I have no idea, but
> since it's easy to use the per-CPU microcode I would.

The microcode driver handles the case of different types of CPUs in an SMP 
system internally. Namely, it selects the appropriate microcode data 
chunks for each CPU and then uploads them correctly to each one. Anyway, 
it only works for Intel processors, so AMD is not in the equation anyway 
(unless I discover that AMD processors support similar feature and enhance 
the driver to support it).

Kind regards
Tigran

