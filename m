Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWBOVdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWBOVdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWBOVdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:33:10 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:34731 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751296AbWBOVdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:33:09 -0500
Date: Wed, 15 Feb 2006 22:31:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Message-ID: <20060215213122.GA17450@elte.hu>
References: <20060215151711.GA31569@elte.hu> <Pine.LNX.4.64.0602151059300.14526@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602151059300.14526@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> >This patchset provides a new (written from scratch) implementation of
> >robust futexes, called "lightweight robust futexes". We believe this new
> >implementation is faster and simpler than the vma-based robust futex
> >solutions presented before, and we'd like this patchset to be adopted in
> >the upstream kernel. This is version 1 of the patchset.
> 
> 	Next point of discussion must be PI. [...]

robustness is an orthogonal feature to Priority Inheritance. In fact it 
was requested before on lkml to separate robustness support from PI 
support, and the vma-based robust futex patches now do precisely that - 
they dont offer PI. So no, PI does not play here, it's a separate thing.

	Ingo
