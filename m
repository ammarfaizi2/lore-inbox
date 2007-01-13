Return-Path: <linux-kernel-owner+w=401wt.eu-S1422735AbXAMRoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbXAMRoJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 12:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422736AbXAMRoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 12:44:08 -0500
Received: from [139.30.44.16] ([139.30.44.16]:27582 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1422735AbXAMRoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 12:44:07 -0500
Date: Sat, 13 Jan 2007 18:44:05 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] severing module.h->sched.h
In-Reply-To: <Pine.LNX.4.64.0701102224320.4331@anakin>
Message-ID: <Pine.LNX.4.63.0701131832120.25096@gockel.physik3.uni-rostock.de>
References: <200612041859.kB4Ix2cx013332@hera.kernel.org>
 <Pine.LNX.4.64.0701102224320.4331@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007, Geert Uytterhoeven wrote:

> which needs the definition of struct task_struct.
> 
> The patch below fixes it by including <linux/sched.h> in
> kernel/time/clocksource.c. But perhaps this is the right time to move
> struct task_struct to its own include instead?

I used to post such a patch once every few years, as it allows to remove
the (indirect) include of that sched.h monster from a few thousand files.
If there is interest in such a move, I'll cook up a patch within the next 
weeks.

Tim
