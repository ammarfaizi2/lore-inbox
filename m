Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVHDU7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVHDU7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVHDU5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:57:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262679AbVHDU5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:57:01 -0400
Date: Thu, 4 Aug 2005 13:58:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, zilvinas@gemtek.lt,
       torvalds@osdl.org
Subject: Re: [PATCH] Remove suspend() calls from shutdown path
Message-Id: <20050804135833.07a6702f.akpm@osdl.org>
In-Reply-To: <200508042251.14740.rjw@sisk.pl>
References: <1123148187.30257.55.camel@gaston>
	<20050804121604.GA4659@gemtek.lt>
	<1123168844.30257.64.camel@gaston>
	<200508042251.14740.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Thursday, 4 of August 2005 17:20, Benjamin Herrenschmidt wrote:
> > On Thu, 2005-08-04 at 15:16 +0300, Zilvinas Valinskas wrote:
> > > Hello Ben, Andrew, 
> > > 
> > > This patch helps me if I disconnect all USB peripherals before shutting
> > > down notebook. With connected peripherals (USB mouse, PL2303
> > > USB<->serial converter/port) - powering off process stops right after
> > > unmounting filesystems but before hda power off ... 
> > > 
> > > There is a bug report for this too:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=4992
> > 
> > This is unclear.
> > 
> > I would expect the behaviour you report to happen _without_ this patch,
> > that is with current git tree, and I would expect this patch to fix it
> > by reverting to the previous 2.6.12 behaviour...
> 
> I had this problem on a dual-core Athlon-based machine, but the patch
> apparently fixed it.
> 

So are all the (three?) bugs (regressions) which you were reporting now
fixed?
