Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbTJOMxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbTJOMxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:53:47 -0400
Received: from web40907.mail.yahoo.com ([66.218.78.204]:9760 "HELO
	web40907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263091AbTJOMxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:53:45 -0400
Message-ID: <20031015125344.59726.qmail@web40907.mail.yahoo.com>
Date: Wed, 15 Oct 2003 05:53:44 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test7-mm1
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0310151441300.1333@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Schmielau,

--- Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> > You're welcome. Unfortunately I got this non-fatal Oops when I first booted:
> >
> > ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
> > ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
> > Packet=[2048]
> > Debug: sleeping function called from invalid context at mm/slab.c:1869
> [...]
> > I don't see any patches in your ChangeLog which could have caused this, since
> > it didn't happen under 2.6.0-test7 or 2.6.0-test6-mm4.
> 
> "might_sleep-vs-jiffies-wrap.patch" pops to mind, it probably just didn't
> get reported in earlier kernels because starting with INITIAL_JIFFIES!=0
> broke the rate limiting logic (sorry for that)

Well, I don't use the IEEE1394 drivers (yet), so like I said, it's non-fatal. Are
there any other debugging options I can enable that would help pinpoint this
(i.e frame pointers?)

Interesting part of .config:

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y


> 
> Tim
> 

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
