Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTEWW5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 18:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbTEWW5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 18:57:52 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:11840 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263718AbTEWW5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 18:57:51 -0400
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [BUGS] 2.5.69 syncppp
Date: Fri, 23 May 2003 18:11:02 -0500
Message-ID: <OPENKONOOJPFMJFAJLHAKEPCCBAA.paulkf@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20030523143138.4701982e.akpm@digeo.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sppp_lcp_open() is called from other places
> without that lock held, so it is probably not
> totally stupid to drop it in the timer handler too.

That section was previously covered by cli/sti,
and I changed it to use the spinlock instead
when cli/sti went away in 2.5.x. 

I thought it was in place to serialize state changes.
I'll look at it harder, you may be right in that
it is not necessary.

> It's good (and surprising) that someone is
> actually using that stuff.

It's not pretty, but it works.
Some customers prefer it to pppd.

> Please beat on it for a while.

Yes, that code is in need of a good beating :-)

Paul Fulghum
paulkf@microgate.com


