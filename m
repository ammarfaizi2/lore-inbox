Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVLMNqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVLMNqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLMNqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:46:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:18922 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964780AbVLMNp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:45:56 -0500
Date: Tue, 13 Dec 2005 14:45:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213134508.GA933@elte.hu>
References: <20051213105459.GA9879@elte.hu> <dhowells1134431145@warthog.cambridge.redhat.com> <1036.1134473085@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036.1134473085@warthog.cambridge.redhat.com>
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


* David Howells <dhowells@redhat.com> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > >      	init_MUTEX_LOCKED()
> > > 	DECLARE_MUTEX_LOCKED()
> > 
> > please kill these two in the simple mutex implementation - they are a 
> > sign of mutexes used as completions.
> 
> That can be done later. It's not necessary to do it in this particular 
> patch set.

i disagree - it's necessary that we dont build complexities into the 
'simple' mutex type, or the whole game starts again. I.e. the 'owner 
unlocks the mutex' rule must be enforced - which makes 
DECLARE_MUTEX_LOCKED() meaningless.

	Ingo
