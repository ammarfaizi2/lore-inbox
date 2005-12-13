Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVLMJK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVLMJK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVLMJK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:10:29 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:26536 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964822AbVLMJK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:10:26 -0500
Date: Tue, 13 Dec 2005 10:09:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, dhowells@redhat.com, torvalds@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213090941.GA20490@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213084926.GN23384@wotan.suse.de>
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

> > It's time to give up on it and just drink more coffee or play more tetris
> > or something, I'm afraid.
> 
> Or start using icecream (http://wiki.kde.org/icecream)

distcc is pretty good too. I have a minimal kernel build done in 19 
seconds, a fuller build (1.5MB bzImage that boots on all my testboxes) 
done in 45 seconds, using gcc 4.0.2.

with the default settings, distcc wasnt saturating my boxes, the key was 
to start distccd with a longer queue size (/etc/sysconfig/distccd):

 OPTIONS="--nice 5 --jobs 128"

and to get the DISTCC_HOSTS tuning right:

 export DISTCC_HOSTS='j/16 n/120 v/40 s/13 e2/7'

in fact my distcc builds are almost as fast as a fully cached ccache 
build coming straight out of RAM ...

	Ingo
