Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWIZWv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWIZWv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWIZWv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:51:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:63712 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932235AbWIZWvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:51:25 -0400
Subject: Re: 2.6.18 Nasty Lockup
From: john stultz <johnstul@us.ibm.com>
To: caglar@pardus.org.tr
Cc: Greg Schafer <gschafer@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200609270015.51465.caglar@pardus.org.tr>
References: <20060926123640.GA7826@tigers.local>
	 <200609270015.51465.caglar@pardus.org.tr>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Sep 2006 15:50:57 -0700
Message-Id: <1159311057.17071.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 00:15 +0300, S.Çağlar Onur wrote:
> 26 Eyl 2006 Sal 15:36 tarihinde, Greg Schafer şunları yazmıştı: 
> > This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> > completely dead machine with only option the reset button. Usually happens
> > within a couple of minutes of desktop use but is 100% reproducible. Problem
> > is still there in a fresh checkout of current Linus git tree (post 2.6.18).
> 
> Same symptoms here and its reproducible after starting the irqbalance (0.12 or 
> 0.13), if i disable irqbalance then everything is going fine.

Hmm.. Not sure about the connection to irqbalance. You're using the TSC
clocksource, so I'm curious if your cpu TSC's are out of sync. Can you
boot w/ "clocksource=acpi_pm" to see if that resolves it?

thanks
-john


