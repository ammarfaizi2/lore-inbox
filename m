Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSIYMdZ>; Wed, 25 Sep 2002 08:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbSIYMdZ>; Wed, 25 Sep 2002 08:33:25 -0400
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:63036 "EHLO
	mailout6-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S261963AbSIYMdZ>; Wed, 25 Sep 2002 08:33:25 -0400
Subject: Re: Polling /proc/apm causes usb hiccups and clock drift
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020924162205.GB7775@titan.lahn.de>
References: <1032873120.3056.7.camel@sirius.strandboge.cxm> 
	<20020924162205.GB7775@titan.lahn.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Sep 2002 08:39:04 -0400
Message-Id: <1032957544.18424.5.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-24 at 12:22, Philipp Matthias Hahn wrote:
> Hi James!
> 
> On Tue, Sep 24, 2002 at 09:12:00AM -0400, James D Strandboge wrote:
> > Disabling the battstat-applet and not touching /proc/apm lets xawtv work
> > fine without the above errors.  Polling /proc/apm also causes clock
> > drift.
> > 
> > I have a Dell Inspiron 8200 laptop (1.6Ghz Pentium 4).  Using kernel
> > 2.4.18-686 from debian.  I read that this happened to people in the 2.2
> > series.  Is this a kernel apm bug or BIOS problem?  Do I just have to
> > live with it?
> 
> This is a known BIOS limitation. Interrupts are disabled during
> APM-BIOS calls and they may take a long time, during which the kernel
> might miss some clock interrupts.
> You can try to enable CONFIG_APM_ALLOW_INTS=y during kernel compile, but
> your BIOS might not like it.
> 
Thanks.  Yes I have this disabled because it has caused problems with
others using the inspiron 8200.  I will play with it though.  This most
definitely is a BIOS bug then, and I have to live with it.  Is ACPI any
better?

Jamie Strandboge

-- 
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

