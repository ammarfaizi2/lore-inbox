Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVEIVvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVEIVvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVEIVvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:51:17 -0400
Received: from graphe.net ([209.204.138.32]:19982 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261535AbVEIVvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:51:15 -0400
Date: Mon, 9 May 2005 14:51:14 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
In-Reply-To: <20050509144255.17d3b9aa.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0505091449580.29090@graphe.net>
References: <424D373F.1BCBF2AC@tv-sign.ru> <424E6441.12A6BC03@tv-sign.ru>
 <Pine.LNX.4.58.0505091312490.27740@graphe.net> <20050509144255.17d3b9aa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Andrew Morton wrote:

> ptype_base is an array, but I cannot see any race around ptype_base.  So
> look to see if ptype_base is corrupted as well, keep walking back through
> memory, see where the scribble starts.

There is no corruption around ptype_all as you can see from the log. There
is a list of hex numbers which are from ptype_all -8 to ptype_all +8.
Looks okay to me.

> 2.6.12-rc3-mm3 has different patches:
>
> timers-fixes-improvements.patch
> timers-fixes-improvements-smp_processor_id-fix.patch
> timers-fixes-improvements-fix.patch
> timers-fix-__mod_timer-vs-__run_timers-deadlock.patch
> timers-fix-__mod_timer-vs-__run_timers-deadlock-tidy.patch
> timers-comments-update.patch
> kernel-timerc-remove-a-goto-construct.patch

Ok. Will try these.

