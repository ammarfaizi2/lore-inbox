Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTJOMqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTJOMqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:46:21 -0400
Received: from [139.30.44.16] ([139.30.44.16]:29600 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263073AbTJOMqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:46:18 -0400
Date: Wed, 15 Oct 2003 14:46:08 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Bradley Chapman <kakadu_croc@yahoo.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7-mm1
In-Reply-To: <20031015123444.46223.qmail@web40904.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0310151441300.1333@gockel.physik3.uni-rostock.de>
References: <20031015123444.46223.qmail@web40904.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're welcome. Unfortunately I got this non-fatal Oops when I first booted:
>
> ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
> ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
> Packet=[2048]
> Debug: sleeping function called from invalid context at mm/slab.c:1869
[...]
> I don't see any patches in your ChangeLog which could have caused this, since
> it didn't happen under 2.6.0-test7 or 2.6.0-test6-mm4.

"might_sleep-vs-jiffies-wrap.patch" pops to mind, it probably just didn't
get reported in earlier kernels because starting with INITIAL_JIFFIES!=0
broke the rate limiting logic (sorry for that)

Tim

