Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTINIsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTINIsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:48:18 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:62597 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262347AbTINIsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:48:14 -0400
Subject: Re: [PATCH] file locking memory leak
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Wade <neroz@ii.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, willy@debian.org
In-Reply-To: <3F642723.6000203@ii.net>
References: <20030912201316.GD21596@parcelfarce.linux.theplanet.co.uk>
	 <3F642723.6000203@ii.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063529292.18181.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 14 Sep 2003 10:48:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-14 at 10:30, Wade wrote:
> Matthew Wilcox wrote:
> > This patch fixes a memory leak in the file locking code.  Each attempt
> > to unlock a file would result in the leak of a file lock.  Many thanks
> > to Martin Josefsson for providing the testcase which enabled me to figure
> > out the problem.
> > 
> 
> Is this a problem for 2.4 as well?

No, it was introduced in the locking-rewrite in 2.5

A new patch which fixes another leak as well has been produced by Willy,
now I can't reproduce any leaks at all. I assume it will be merged in
-mm or in Linus tree when he gets back.

-- 
/Martin
