Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVJBNvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVJBNvU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 09:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVJBNvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 09:51:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:60104 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751014AbVJBNvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 09:51:19 -0400
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051002102726.GB26677@opteron.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
	 <200509231036.16921.kernel@kolivas.org>
	 <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
	 <20050923153158.GA4548@x30.random>
	 <1127509047.8880.4.camel@kleikamp.austin.ibm.com>
	 <1127509155.8875.6.camel@kleikamp.austin.ibm.com>
	 <1127511979.8875.11.camel@kleikamp.austin.ibm.com>
	 <20050928223829.GH10408@opteron.random>
	 <1128126424.10237.7.camel@kleikamp.austin.ibm.com>
	 <20051002102726.GB26677@opteron.random>
Content-Type: text/plain
Date: Sun, 02 Oct 2005 08:51:12 -0500
Message-Id: <1128261072.9382.4.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-02 at 12:27 +0200, Andrea Arcangeli wrote:
> On Fri, Sep 30, 2005 at 07:27:04PM -0500, Dave Kleikamp wrote:
> > I tracked down my problem to a bug in jfs.  jfs is explicitly setting
> 
> Ok great this explain things, so perhaps my last hack attempt of not
> accounting the unstable pages in the "nr_reclaimable" isn't needed.

Maybe it is.  I just retested the fixed jfs on 2.6.14-rc2-mm1, and I
still see the hang.  I can probably debug it further on Monday if
necessary.

> What about Valids, were you using jfs too along with ext3? If a single
> fs has a bug the loop can happen (it could happen in mainline too,
> except it was less likely to be visible there).
> 
> Note Valids, your smtp server bounces back my emails.
> 
-- 
David Kleikamp
IBM Linux Technology Center

