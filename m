Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVHaMLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVHaMLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVHaMLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:11:06 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:58833 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932508AbVHaMLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:11:05 -0400
Date: Wed, 31 Aug 2005 14:11:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Matteo <kundor@kundor.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAX_ARG_PAGES has no effect?
Message-ID: <20050831121144.GA13578@elte.hu>
References: <4314F761.2050908@kundor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4314F761.2050908@kundor.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Matteo <kundor@kundor.org> wrote:

> The other day I was running a grep on a big directory tree and got a 
> "Argument list too long" error.  Since I'd like to have this work 
> without messing with find and xargs each time, I went into 
> include/linux/binfmts.h and changed
> 
> #define MAX_ARG_PAGES 32
> 
> to
> 
> #define MAX_ARG_PAGES 64
> 
> I recompiled and installed the kernel, but there's no change (getconf 
> ARG_MAX still gives 131072.)  What am I missing?

MAX_ARG_PAGES should work just fine. I think the 'getconf ARG_MAX' 
output is hardcoded. (because the kernel does not provide the 
information dynamically)

	Ingo
