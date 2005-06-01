Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVFANGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFANGX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFANEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:04:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3838 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261278AbVFANEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:04:06 -0400
Date: Wed, 1 Jun 2005 06:04:01 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
In-Reply-To: <20050601092102.GB13041@elte.hu>
Message-ID: <Pine.LNX.4.10.10506010559050.23911-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Jun 2005, Ingo Molnar wrote:

> 
> * Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > Another problem in plist_add:
> > 
> > > existing_sp_head:
> > > 	itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
> > > 	list_add(&pl->sp_node, &itr_pl2->sp_node);
> > 
> > This breaks fifo ordering.
> 
> Daniel, is the issue (and other issues) Oleg noticed still present? I'm 
> still a bit uneasy about the complexity of the plist changes.

I think this one isn't right. We could make a test quite to check
correctness. Find the errors before they find us. Oleg may even have
something like that already half done. 

Are you concerned with plist as a whole, or just my recent changes?

There is still a problem with plist_for_each() missing the first list
member, which I need to fix. 

Daniel

