Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUAVARS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 19:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUAVARR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 19:17:17 -0500
Received: from gprs148-45.eurotel.cz ([160.218.148.45]:14464 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266149AbUAVARQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 19:17:16 -0500
Date: Thu, 22 Jan 2004 01:17:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: More cleanups for swsusp
Message-ID: <20040122001706.GB300@elf.ucw.cz>
References: <20040120151358.09608fc3.akpm@osdl.org> <20040121051855.A52872C04B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121051855.A52872C04B@lists.samba.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +	BUG_ON (sizeof(struct link) != PAGE_SIZE);
> > 
> > Looking at the code, this hardly seems worth checking.  But the compiler
> > should just rub this code out anwyay, so whatever.
> > 
> > hmm, one could do:
> > 
> > #define compile_time_assert(expr)					\
> 
> Already there: BUILD_BUG & BUILD_BUG_ON.

Unfortunately that one gives no message to the user (AFAICS), so
if/when people use it extensively, it will get nasty.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
