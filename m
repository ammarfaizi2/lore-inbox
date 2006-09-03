Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWICIaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWICIaW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 04:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWICIaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 04:30:22 -0400
Received: from www.osadl.org ([213.239.205.134]:8174 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750713AbWICIaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 04:30:21 -0400
Subject: Re: [RFC] Simple userspace interface for PCI drivers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060901211754.GA4884@ucw.cz>
References: <20060830062338.GA10285@kroah.com>
	 <20060901211754.GA4884@ucw.cz>
Content-Type: text/plain
Date: Sun, 03 Sep 2006 10:34:19 +0200
Message-Id: <1157272459.29250.393.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 21:17 +0000, Pavel Machek wrote:
> Hi!
> 
> > And the name is a bit ackward, anyone have a better suggestion?
> 
> drivers/uio (for userspace io driver)?

not too bad.

> And yes, I think this one _should_ taint the kernel. When userspace
> starts playing with interrupts, chances of kernel crash are high.

Userspace does not play with interrupts directly. You still have a small
stub driver, which does the primary interrupt handling, else you would
have a hard time to deal with shared irqs.

> Does it work properly with pci shared interrupts?

See the SERCOS example I posted.

	tglx



-- 
VGER BF report: U 0.500128
