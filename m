Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVFEH6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVFEH6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 03:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVFEH6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 03:58:40 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:24787 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261505AbVFEH6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 03:58:35 -0400
Date: Sun, 5 Jun 2005 09:58:05 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: patch] Real-Time Preemption, plist fixes
In-Reply-To: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
Message-Id: <Pine.OSF.4.05.10506050953040.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2005, Thomas Gleixner wrote:

> [...] 
>   *
>   * Based on simple lists (include/linux/list.h).
> @@ -17,35 +22,50 @@
>   * a priority too (the highest of all the nodes), stored in the head
>   * of the list (that is a node itself).
>   *
> - * Addition is O(1), removal is O(1), change of priority of a node is
> - * O(1).
> + * Addition is O(N), removal is O(1), change of priority of a node is
> + * O(N).
>   *
> - * Addition and change of priority's order is really O(K), where K is
> - * a constant being the maximum number of different priorities you
> - * will store in the list. Being a constant, it means it is O(1).
> - *

What is N? The number of nodes in the list or the number of different
priorities? If it is the number of nodes in total this exercise is
worthless: You could just as well have a sorted list.

But I hope and also think that the original explanation was correct.

Esben

