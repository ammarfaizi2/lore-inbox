Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVL1HtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVL1HtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 02:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVL1HtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 02:49:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:21907 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932496AbVL1HtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 02:49:17 -0500
Date: Wed, 28 Dec 2005 08:48:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/3] mutex subsystem: trylock
Message-ID: <20051228074857.GA4600@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain> <20051227115129.GB23587@elte.hu> <Pine.LNX.4.64.0512271439380.3309@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512271439380.3309@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> > here we go to great trouble trying to avoid the 'slowpath', while we 
> > unconditionally force the next unlock into the slowpath! So we have 
> > not won anything. (on a cycle count basis it's probably even a net 
> > loss)
> 
> I disagree.  [...elaborate analysis of the code ...]

you are right, it should work fine, and should be optimal. I'll add your 
xchg variant to mutex-xchg.h.

	Ingo
