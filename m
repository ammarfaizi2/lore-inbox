Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTEWBbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 21:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTEWBbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 21:31:48 -0400
Received: from dp.samba.org ([66.70.73.150]:15553 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263572AbTEWBbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 21:31:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] per-cpu support inside modules (minimal) 
Cc: kiran@in.ibm.com, dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com
In-reply-to: Your message of "Thu, 22 May 2003 03:15:38 MST."
             <20030522031538.2cd124b8.akpm@digeo.com> 
Date: Fri, 23 May 2003 09:51:28 +1000
Message-Id: <20030523014452.8D89D2C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030522031538.2cd124b8.akpm@digeo.com> you write:
> > +static inline unsigned int abs(int val)
> >  +{
> >  +	if (val < 0)
> >  +		return -val;
> >  +	return val;
> >  +}
> 
> Several architectures define their own abs() in asm/system.h which
> return signed int.

Hmm, it's actually declated that way in linux/kernel.h, too:

	extern int abs(int);

But AFAICT it's never actually defined.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
