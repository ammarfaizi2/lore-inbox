Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWCNXQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWCNXQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWCNXQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:16:18 -0500
Received: from xenotime.net ([66.160.160.81]:1223 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932132AbWCNXQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:16:18 -0500
Date: Tue, 14 Mar 2006 15:18:12 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: soft lockup in serial8250_console_write(?)
Message-Id: <20060314151812.2779ed4b.rdunlap@xenotime.net>
In-Reply-To: <20060314214049.GA29536@elte.hu>
References: <20060314134110.3470fc63.rdunlap@xenotime.net>
	<20060314214049.GA29536@elte.hu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006 22:40:49 +0100 Ingo Molnar wrote:

> 
> * Randy.Dunlap <rdunlap@xenotime.net> wrote:
> 
> > Hi,
> > 
> > (x86_64; 2.6.16-rc6; serial console configured but nothing connected 
> > to the serial port)
> > 
> > I'm seeing an occasional soft lockup, maybe in 
> > serial8250_console_write(). (drivers/serial/8250.c)
> > 
> > This function calls wait_for_xmitr() [inline], which in worst case can 
> > spin for 1.010 seconds.  Could this be the cause of a soft lockup?
> 
> hm, it shouldnt cause that. Could you try the attached patch [which is 
> the next-gen softlockup detector], do you get the message even with that 
> one applied?

5/5 good boots with your new patch.
5/5 soft lockups without it.

Is this scheduled for post-2.6.16 ?

Thanks,
---
~Randy
