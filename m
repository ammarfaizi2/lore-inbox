Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTI2Hi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTI2Hi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:38:28 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25216
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262861AbTI2Hi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:38:27 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Linux 2.6.0-test6
Date: Mon, 29 Sep 2003 02:35:14 -0500
User-Agent: KMail/1.5
Cc: Con Kolivas <kernel@kolivas.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <200309280502.36177.rob@landley.net> <3F77BB2C.7030402@cyberone.com.au>
In-Reply-To: <3F77BB2C.7030402@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290235.14897.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 September 2003 23:55, Nick Piggin wrote:

> >I.E. with your new scheduler, priority levels actually have enough of an
> >effect now that things that aren't reniced can be noticeably starved by
> >things that are.
>
> AFAIK, Con's scheduler doesn't change the nice implementation at all.
> Possibly some of his changes amplify its problems, or, more likely they
> remove most other scheduler problems leaving this one noticable.
>
> If X is running at -20, and xmms at +19, xmms is supposed to still get
> 5% of the CPU. Should be enough to run fine. Unfortunately this is
> achieved by giving X very large timeslices, so xmms's scheduling latency
> becomes large. The interactivity bonuses don't help, either.

It's the old latency vs throughput problem.  Nice only has a single linear 
metric, it says you want more or you want less but it doesn't say more or 
less of _what_.

Rob
