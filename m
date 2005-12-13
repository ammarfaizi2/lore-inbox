Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVLMK0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVLMK0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVLMK0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:26:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932609AbVLMK0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:26:08 -0500
Date: Tue, 13 Dec 2005 02:25:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: jakub@redhat.com, ak@suse.de, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051213022529.6f88a981.akpm@osdl.org>
In-Reply-To: <20051213101152.GU23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213075835.GZ15804@wotan.suse.de>
	<20051213004257.0f87d814.akpm@osdl.org>
	<20051213084926.GN23384@wotan.suse.de>
	<20051213010126.0832356d.akpm@osdl.org>
	<20051213010233.50fce969.akpm@osdl.org>
	<20051213100715.GH31785@devserv.devel.redhat.com>
	<20051213101152.GU23384@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
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
> 

3.2.1 works OK on x86.
