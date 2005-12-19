Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVLSQf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVLSQf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVLSQf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:35:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42903 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964827AbVLSQfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:35:25 -0500
Date: Mon, 19 Dec 2005 17:34:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 09/15] Generic Mutex Subsystem, mutex-migration-helper-x86_64.patch
Message-ID: <20051219163441.GD8160@elte.hu>
References: <20051219013827.GE28038@elte.hu> <20051219043032.GH23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219043032.GH23384@wotan.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> On Mon, Dec 19, 2005 at 02:38:27AM +0100, Ingo Molnar wrote:
> > 
> > introduce the arch_semaphore type on x86_64, to ease migration to 
> > mutexes.
> 
> As a small feedback I don't think the name arch_semaphore is very good 
> because it means nothing.  How about counting_semaphore which is what 
> it actually is?

yeah, this is one of the open issues, and i have no strong preference 
for any of the naming variants. I considered two things when i went for 
the 'arch_semaphore' name:

1) the name should be temporary, and we could make it 'struct semaphore' 
   once the transition phase is over. Linus is totally correct 
   suggesting that there's nothing wrong about the 'struct semaphore' 
   name. It just happens to clash with my intended type-based 
   categorization of 'known counting semaphores' from 'unknown 
   semaphores'.

2) i wanted to signal that this is the per-arch semaphore 
   implementation.

another candidate name was 'struct __semaphore'. I like 'struct 
counting_semaphore' too, but maybe it's a bit too long as a name?  
Anyway, i'm very much open to suggestions how to name it best.

	Ingo
