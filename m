Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVHDUro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVHDUro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVHDUrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:47:17 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:55686 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262674AbVHDUqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:46:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove suspend() calls from shutdown path
Date: Thu, 4 Aug 2005 22:51:14 +0200
User-Agent: KMail/1.8.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <1123148187.30257.55.camel@gaston> <20050804121604.GA4659@gemtek.lt> <1123168844.30257.64.camel@gaston>
In-Reply-To: <1123168844.30257.64.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508042251.14740.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 4 of August 2005 17:20, Benjamin Herrenschmidt wrote:
> On Thu, 2005-08-04 at 15:16 +0300, Zilvinas Valinskas wrote:
> > Hello Ben, Andrew, 
> > 
> > This patch helps me if I disconnect all USB peripherals before shutting
> > down notebook. With connected peripherals (USB mouse, PL2303
> > USB<->serial converter/port) - powering off process stops right after
> > unmounting filesystems but before hda power off ... 
> > 
> > There is a bug report for this too:
> > http://bugzilla.kernel.org/show_bug.cgi?id=4992
> 
> This is unclear.
> 
> I would expect the behaviour you report to happen _without_ this patch,
> that is with current git tree, and I would expect this patch to fix it
> by reverting to the previous 2.6.12 behaviour...

I had this problem on a dual-core Athlon-based machine, but the patch
apparently fixed it.

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
