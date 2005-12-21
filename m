Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVLUG1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVLUG1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 01:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVLUG1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 01:27:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44005 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932285AbVLUG1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 01:27:02 -0500
Date: Wed, 21 Dec 2005 07:26:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051221062623.GB32711@elte.hu>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com> <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <Pine.LNX.4.64.0512202304580.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512202304580.26663@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> > Please consider using (a variant of) xchg() instead.  Although 
> > atomic_dec() is available on all architectures, its implementation is 
> > far from being the most efficient thing to do for them all.
> 
> Actually, the best thing to do is to let the architecture do what is 
> the most efficient. [...]

i have already added something similar. Furthermore, i have also 
eliminated the CMPXCHG requirement from MUTEX_FASTPATH, which should 
open ARM up to the generic lockless fastpath. (but you can still choose 
to reimplement it in the architecture) I'll send a new queue later 
today.

	Ingo
