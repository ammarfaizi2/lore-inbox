Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSKVQES>; Fri, 22 Nov 2002 11:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSKVQES>; Fri, 22 Nov 2002 11:04:18 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24592
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264984AbSKVQER>; Fri, 22 Nov 2002 11:04:17 -0500
Subject: Re: calling schedule() from interupt context
From: Robert Love <rml@tech9.net>
To: dan carpenter <error27@email.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021122160409.28049.qmail@email.com>
References: <20021122160409.28049.qmail@email.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037981475.1504.4316.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 22 Nov 2002 11:11:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-22 at 11:04, dan carpenter wrote:

> ok.  I'm an idiot.
> 
> The script only checks things at compile time not at runtime.  So you are 
> right, of course, that this couldn't happen in real life because of the
> preemp_count.  

Still, neat scripts.

Statically searching code has a lot of applications that run-time
checking does not have.  For example, there _are_ a lot of things you do
not want to call from interrupts: down(), kmalloc() without GFP_ATOMIC,
etc. etc.

And could you get it to check for code paths that could possibly
double-acquire the same lock?

etc. etc... be creative.

> Thanks for the explanation...  

No problem.

	Robert Love

