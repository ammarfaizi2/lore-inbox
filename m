Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVBIFD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVBIFD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 00:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVBIFD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 00:03:56 -0500
Received: from main.gmane.org ([80.91.229.2]:3714 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261782AbVBIFDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 00:03:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: VM disk cache behavior.
Date: Tue, 08 Feb 2005 23:03:13 -0600
Message-ID: <cuc5fo$7r5$1@sea.gmane.org>
References: <e130a7170502080906596561d7@mail.gmail.com> <20050209003754.GA7298@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-2-179.client.mchsi.com
User-Agent: KNode/0.8.2
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: s
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:

> Most likely is that your app isn't behaving in a cache-friendly way.  If
> your file will fit in memory, just fault it in sequentially (wc -l file)
> and then your app should cook.  If you're not going to fit in memory,
> the vm caching will probably only help if you have some reuse; you could
> develop a pre-faulter to get your IO started ahead of time, but that's
> generally nontrivial.

Of course, what's non-trivial is predicting your upcoming I/O pattern
(unless it's not actually random at all, just messy). Calling madvise to
prefault it is pretty easy if you actually do know what you'll want in the
near future.

