Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTKMEw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 23:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTKMEw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 23:52:28 -0500
Received: from taco.zianet.com ([216.234.192.159]:64008 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261563AbTKMEw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 23:52:26 -0500
From: Steven Cole <elenstev@mesatop.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dax Kelson <dax@gurulabs.com>
Subject: Re: List of SCO files
Date: Wed, 12 Nov 2003 21:50:43 -0700
User-Agent: KMail/1.5
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1068679942.3082.131.camel@mentor.gurulabs.com> <1068691791.13135.41.camel@gaston>
In-Reply-To: <1068691791.13135.41.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311122150.43307.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 November 2003 07:49 pm, Benjamin Herrenschmidt wrote:
> Or just include/asm-m68k/spinlock.h :)
>
> The whole file is just:
>
> #ifndef __M68K_SPINLOCK_H
> #define __M68K_SPINLOCK_H
>
> #error "m68k doesn't do SMP yet"
>
> #endif

Here's my personal favorite, file 490 of 591.  
See if you can spot the purloined Intellectual Property:

[steven@spc 2.6-bk-current]$ cat include/asm-v850/percpu.h
#ifndef __V850_PERCPU_H__
#define __V850_PERCPU_H__

#include <asm-generic/percpu.h>

/* This is a stupid hack to satisfy some grotty implicit include-file
   dependency; basically, <linux/smp.h> uses BUG_ON, which calls BUG, but
   doesn't include the necessary headers to define it.  In the twisted
   festering mess of includes this must all be resolved somehow on other
   platforms, but I haven't the faintest idea how, and don't care; here will
   do, even though doesn't actually make any sense.  */
#include <asm/page.h>

#endif /* __V850_PERCPU_H__ */

I'm betting on the "This is a stupid hack" phrase.  Undoubtably SCO's code
is littered with comments like that.

Steven
