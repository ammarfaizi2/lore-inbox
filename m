Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934275AbWKTXN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934275AbWKTXN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934276AbWKTXN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:13:59 -0500
Received: from mx0.towertech.it ([213.215.222.73]:9396 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S934275AbWKTXN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:13:59 -0500
Date: Tue, 21 Nov 2006 00:13:52 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2.6.19-rc6 1/6] rtc class /proc/driver/rtc update
Message-ID: <20061121001352.55f3ce2b@inspiron>
In-Reply-To: <200611201017.19961.david-b@pacbell.net>
References: <200611201014.41980.david-b@pacbell.net>
	<200611201017.19961.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 10:17:19 -0800
David Brownell <david-b@pacbell.net> wrote:

> Fix two minor botches in the procfs dumping of RTC alarm status:
> 
>  - Stop confusing "alarm enabled" with "wakeup enabled".
> 
>  - Don't display bogus "irq pending/un-acked" status; those are the rather
>    pointless semantics EFI assigned to this (for a no-IRQs environment).

 I wouldn't change that, the /proc interface to rtc is old
 and should not be used anyhow. Here I'm trying to mimic
 the behaviour of the original one.

 sysfs provides a much better interface
 (once we'll have all the attributes exported, of course :) )

 I don't know if there's any user space tool relying on this.
 If yes, then it should be fixed.

 Any thoughts?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

