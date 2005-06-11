Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVFKQg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVFKQg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVFKQg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:36:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59383 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261729AbVFKQgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:36:22 -0400
Date: Sat, 11 Jun 2005 09:36:11 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <Pine.OSF.4.05.10506111612070.2917-100000@da410.phys.au.dk>
Message-ID: <Pine.LNX.4.10.10506110930050.27294-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2005, Esben Nielsen wrote:

> For me it is perfectly ok if RCU code, buffer caches etc use
> raw_local_irq_disable(). I consider that code to be "core" code.

This distinction seem completly baseless to me. Core code doesn't
carry any weight . The question is , can the code be called from real
interrupt context ? If not then don't protect it.

> 
> The current soft-irq states only gives us better hard-irq latency but
> nothing else. I think the overhead runtime and the complication of the
> code is way too big for gaining only that. 

Interrupt response is massive, check the adeos vs. RT numbers . They did
one test which was just interrupt latency.


Daniel

