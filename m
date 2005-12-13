Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVLMKQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVLMKQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVLMKQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:16:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932601AbVLMKQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:16:01 -0500
Date: Tue, 13 Dec 2005 05:15:42 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213101542.GJ31785@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213010233.50fce969.akpm@osdl.org> <20051213100715.GH31785@devserv.devel.redhat.com> <20051213101152.GU23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213101152.GU23384@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 11:11:53AM +0100, Andi Kleen wrote:
> > Guess
> > 
> > #if __GNUC__ == 3 && __GNUC_MINOR__ < 3
> > #error Your compiler is too buggy; it is known to miscompile kernels.
> > #error    Known good compilers: 3.3, 3.4, 4.0
> > #endif
> > 
> > would be better.  __GNUC__ < 2 will certainly be errored about in other
> > places and it is bad to suggest compilers that are no longer supported
> > as known good ones.
> 
> Are there really any known serious miscompilation with 3.1/3.2?  
> (I knew it used to miscompile some loops on x86-64, but I think I worked
> around all that) 
> 
> Preventing SLES9 and RHEL3 users from easily compiling new kernels
> isn't good.

The above is ARM solely, the comment there mentions some ARM postreload bug
that was only fixed in 3.3+.
I'd say 3.2 should be generally supported for the time being on arches
where there weren't significant problems with it.

	Jakub
