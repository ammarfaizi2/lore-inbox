Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbUAOBh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUAOBh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:37:27 -0500
Received: from dp.samba.org ([66.70.73.150]:18823 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264144AbUAOBh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:37:26 -0500
Date: Thu, 15 Jan 2004 10:20:48 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, eike-kernel@sf-tec.de,
       rth@twiddle.net, torvalds@osdl.org
Subject: Re: [2.6 patch] if ... BUG() -> BUG_ON()
Message-Id: <20040115102048.4689664e.rusty@rustcorp.com.au>
In-Reply-To: <20040113213230.GY9677@fs.tum.de>
References: <20040113213230.GY9677@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 22:32:30 +0100
Adrian Bunk <bunk@fs.tum.de> wrote:

> Hi Andrew,
> 
> four months ago, Rolf Eike Beer <eike-kernel@sf-tec.de> sent a patch 
> against 2.6.0-test5-bk1 that converted several if ... BUG() to BUG_ON()
> (this might in some cases result in slightly faster code).

You know, I dislike this.

The right fix is to hack gcc to allow functions (in this case, BUG()) to have
an "unlikely" attribute, and therefore know that this branch is unlikely.

Making code slightly less readable for minor (and hopefully temporary)
optimizations is IMHO not a worthy use of your time.

Quick!  To the GCC sources!  Run!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
