Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbUAVEQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 23:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUAVEQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 23:16:38 -0500
Received: from dp.samba.org ([66.70.73.150]:25245 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263518AbUAVEQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 23:16:37 -0500
Date: Thu, 22 Jan 2004 13:03:39 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: More cleanups for swsusp
Message-Id: <20040122130339.009eeb7d.rusty@rustcorp.com.au>
In-Reply-To: <20040121183938.GE14797@waste.org>
References: <20040120225219.GA19190@elf.ucw.cz>
	<20040121051855.B0C282C0A7@lists.samba.org>
	<20040120213037.66c9d5a0.akpm@osdl.org>
	<20040121183938.GE14797@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004 12:39:38 -0600
Matt Mackall <mpm@selenic.com> wrote:

> > >  3) BUG_ON(complex condition expression) is much less clear than:
> > > 
> > >  	if (complex condition expression)
> > >  		BUG();
> 
> Disagree. All BUG_ON() stuff should read like:
> 
> /* check that impossible stuff didn't happen, move along, nothing to see */
> BUG_ON(...);

You can disagree all you like.

But Linus only allowed BUG_ON() because of the branch-prediction problem,
preferring explicit "if (x) BUG()".  I happen to agree with him, especially
if x is a complex expression.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
