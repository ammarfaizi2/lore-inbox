Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTIGQvk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 12:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTIGQvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 12:51:40 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:11529
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263355AbTIGQvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 12:51:38 -0400
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, jyau_kernel_dev@hotmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030906231856.6282cd44.akpm@osdl.org>
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>
	 <1062878664.3754.12.camel@boobies.awol.org>
	 <3F5ABD3A.7060709@cyberone.com.au>  <20030906231856.6282cd44.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1062954122.12822.3.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 07 Sep 2003 13:02:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-07 at 02:18, Andrew Morton wrote:

> We cannot just jam all this code into Linus's tree while crossing our
> fingers and hoping that something will turn up to fix this problem. 
> Because we don't know what causes it, nor whether we even _can_ fix it.

Actually, this would be my argument _for_ Nick's approach.  It is simple
and we all understand it.

There are a _lot_ of scheduler changes in 2.6-mm, and who knows which
ones are an improvement, a detriment, and a noop?  It is like bandaids
on top of bandaids, to fix corner cases.

And we _do_ know what causes the problem: the interactivity estimator
misestimates interactivity.  What we do not know is what fixes it.

	Robert Love


