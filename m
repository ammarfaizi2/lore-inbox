Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVBDGDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVBDGDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVBDGDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:03:11 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:63132 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263234AbVBDGCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:02:51 -0500
Date: Fri, 04 Feb 2005 15:02:54 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] Re: kdump on non-boot cpu
Cc: Vivek Goyal <vgoyal@in.ibm.com>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m1fz0d9mag.fsf@ebiederm.dsl.xmission.com>
References: <20050204082358.18ED.ODA@valinux.co.jp> <m1fz0d9mag.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050204144438.18F9.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The reason I was asking and assuming you had a 32bit kernel is that
> you were quoting pieces of arch/i386/kernel/crash.c instead of
> arch/x86_64/kernel/crash.c

Using "arch/i386/kernel/crash.c" is just for explanation how we avoid
the hang. (I found x86_64 kdump is not supported in 2.6.11-rc2-mm1 :-))

The attached log is a log of running mkdump (it supports x86_64). not kdump.
The basic procedure before jumping new kernel is almost same as kdump.
So I inform this infromation to you since I think it may be helpfull 
for kdump development.

> Ok. Thanks.  This is a legitimate bug.  And it is probably the reason
> I even care about the non-SMP interrupt case some days.  The problem
> is that the kernel just assumes interrupts are setup in non-APIC mode
> when it starts booting, and quite possibly only the bootstrap cpu can
> see those interrupts. 
> 
> So I believe the fix needs to be to enable apics before we calibrate
> the delay timer.  I'm not certain off the top of my head what that
> patch will look like but it should not be fundamentally hard.  
> With that code in place we also don't need to do any APIC shutdown
> as the kernel knows enough to completely setup the apics.

I see. Thank you for your explanation.

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

