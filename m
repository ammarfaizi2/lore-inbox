Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWJHJ4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWJHJ4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWJHJ4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 05:56:07 -0400
Received: from www.osadl.org ([213.239.205.134]:14263 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751004AbWJHJ4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 05:56:04 -0400
Subject: Re: + clocksource-convert-generic-timeofday.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: dwalker@mvista.com, johnstul@us.ibm.com, mingo@elte.hu,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610070153.k971rmbq020850@shell0.pdx.osdl.net>
References: <200610070153.k971rmbq020850@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 12:01:11 +0200
Message-Id: <1160301672.22911.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:

> Delete alot of remaining code in kernel/time/clocksource.c that is replaced
> with this patch.  Removed the deprecated "clock" kernel parameter.
> 
> Shifts some of the code around so that the time of day override happens inside
> kernel/timer.c.

Please keep the clocksource code where it is. There is no win to move
more code into timer.c. timer.c contains already enough things, which
are unrelated to each other. If you want to make the code more clear,
move the timekeeping code out of timer.c.

	tglx



