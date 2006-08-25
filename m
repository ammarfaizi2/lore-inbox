Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWHYISv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWHYISv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWHYISv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:18:51 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21123 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932139AbWHYISu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:18:50 -0400
Subject: Re: [patch] dubious process system time.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17646.14556.535277.434642@cargo.ozlabs.ibm.com>
References: <20060824121825.GA4425@skybase>
	 <17646.14556.535277.434642@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 25 Aug 2006 10:18:47 +0200
Message-Id: <1156493927.1640.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 09:40 +1000, Paul Mackerras wrote:
> > The system time that is accounted to a process includes the time spent
> > in three different contexts: normal system time, hardirq time and
> > softirq time.
> 
> Is that true (at the moment) with CONFIG_VIRT_CPU_ACCOUNTING=y?  I
> thought it wasn't.

CONFIG_VIRT_CPU_ACCOUNTING improves the precision of the numbers that
get accounted with account_[user,system,steal]_time. Which bucket the
time goes into is decided in the three functions.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


