Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUEZIKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUEZIKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 04:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUEZIKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 04:10:08 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:20207 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265348AbUEZIKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:10:05 -0400
Date: Wed, 26 May 2004 04:11:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Keith Owens <kaos@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6-mm] i386: enable interrupts on contention in
 spin_lock_irq
In-Reply-To: <200405260958.21252.baldrick@free.fr>
Message-ID: <Pine.LNX.4.58.0405260401320.1794@montezuma.fsmlabs.com>
References: <14280.1085556586@kao2.melbourne.sgi.com> <200405260958.21252.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Duncan Sands wrote:

> > However I have seen buggy code where spin_lock_irq() was issued with
> > interrupts disabled. [...]
>
> Some time ago I sent a patch to lkml that tests for this [1].
> And guess what - it happens all over the place [2].  Also, the
> scheduler often gets called with interrupts disabled (schedule()
> does spin_lock_irq), but the cases I checked all turned out to be
> OK [3].  Perhaps it is more problematic now?

I'll run with the debug code and audit any suspect ones. The ones
mentioned below all seem ok.

> [1] http://seclists.org/lists/linux-kernel/2003/May/5585.html
> [2] http://seclists.org/lists/linux-kernel/2003/May/5842.html
> [3] http://seclists.org/lists/linux-kernel/2003/May/5581.html
