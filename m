Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUDHAd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUDHAd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:33:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:24535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbUDHAdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:33:55 -0400
Date: Wed, 7 Apr 2004 17:32:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: jeremy@sgi.com, jbarnes@sgi.com, davidm@hpl.hp.com,
       trini@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm2 (build error in arch/ia64/kernel/setup.c)
Message-Id: <20040407173258.30ada354.akpm@osdl.org>
In-Reply-To: <1081381848.10944.67.camel@bach>
References: <20040406223321.704682ed.akpm@osdl.org>
	<20040407090845.GA790466@sgi.com>
	<20040407105832.39547a4e.akpm@osdl.org>
	<1081381848.10944.67.camel@bach>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> On Thu, 2004-04-08 at 03:58, Andrew Morton wrote:
>  > diff -puN arch/ia64/kernel/setup.c~early-param-rusty-ia64-fix arch/ia64/kernel/setup.c
>  > --- 25/arch/ia64/kernel/setup.c~early-param-rusty-ia64-fix	Wed Apr  7 10:56:36 2004
>  > +++ 25-akpm/arch/ia64/kernel/setup.c	Wed Apr  7 10:56:54 2004
>  > @@ -360,7 +360,7 @@ setup_arch (void)
>  >  	/* enable IA-64 Machine Check Abort Handling */
>  >  	ia64_mca_init();
>  >  
>  > -	platform_setup(cmdline_p);
>  > +	platform_setup(saved_command_line);
>  >  	paging_init();
>  >  }
>  >  
> 
>  More widespread fix (not tested).

Guys, these patches have been causing pain for two weeks.  They have thus
far required at least twelve bugfixes and I have every expectation that it
will take weeks in Linus's tree to identify and fix all the as-yet
undiscovered bugs.  They are taking way too much time which could otherwise
be spent on all the other broken stuff people like to send me.

So I've dropped them all.  They're at
http://www.zip.com.au/~akpm/linux/patches/early-param/.  That includes this
most recent patch of Rusty's.


