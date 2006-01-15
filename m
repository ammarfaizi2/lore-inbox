Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWAOErw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWAOErw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 23:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWAOErw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 23:47:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:6623 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751102AbWAOErv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 23:47:51 -0500
Date: Sun, 15 Jan 2006 05:48:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, rolandd@cisco.com
Subject: Re: [patch 2.6.15-mm4] sem2mutex: infiniband, #2
Message-ID: <20060115044806.GB7456@elte.hu>
References: <20060114150949.GA24284@elte.hu> <20060115015910.GK26421@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115015910.GK26421@krispykreme>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Blanchard <anton@samba.org> wrote:

> Hi Ingo,
> 
> Just a small thing, it looks like the script is doing a double include
> of linux/mutex.h a few times:

> > -#include <asm/semaphore.h>
> > +#include <linux/mutex.h>
> > +#include <linux/mutex.h>

yeah. I fixed this up in later patches (and in the queue to Andrew). I 
double-checked 2.6.15-mm4, it doesnt seem to be affected by this 
problem.

	Ingo
