Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWADXt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWADXt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWADXt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:49:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWADXt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:49:58 -0500
Date: Wed, 4 Jan 2006 15:51:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: hch@infradead.org, vda@ilport.com.ua, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fix warning in 8250.c
Message-Id: <20060104155122.0bdfcffb.akpm@osdl.org>
In-Reply-To: <20060104191241.GF3119@flint.arm.linux.org.uk>
References: <200601031012.49068.vda@ilport.com.ua>
	<20060104181425.GE3119@flint.arm.linux.org.uk>
	<20060104181801.GA3605@infradead.org>
	<20060104191241.GF3119@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> > While we're at it can we please kill _INLINE_?  Those functions that should
> > be inlined can become inline, but this macro just obsfucates the serial code.
> 
> No idea - I don't know about x86 nuances and why they wanted:
> 
> #if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
> #define _INLINE_ inline
> #else
> #define _INLINE_
> #endif
> 
> Maybe someone in the x86 world needs to comment?  Does the above even
> mean that we'll ever inline anything marked _INLINE_ ?

I suspect the reasoning behind this is lost in the mists of pre-bk time. 
I'd be inclined to just nuke it and see what happens.  Nothing, I expect.
