Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265349AbUEZH6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265349AbUEZH6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUEZH6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:58:34 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:60140 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265346AbUEZH6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:58:24 -0400
From: Duncan Sands <baldrick@free.fr>
To: Keith Owens <kaos@sgi.com>, Zwane Mwaikambo <zwane@fsmlabs.com>
Subject: Re: [PATCH][2.6-mm] i386: enable interrupts on contention in spin_lock_irq
Date: Wed, 26 May 2004 09:58:21 +0200
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <14280.1085556586@kao2.melbourne.sgi.com>
In-Reply-To: <14280.1085556586@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405260958.21252.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However I have seen buggy code where spin_lock_irq() was issued with
> interrupts disabled. [...]

Some time ago I sent a patch to lkml that tests for this [1].
And guess what - it happens all over the place [2].  Also, the
scheduler often gets called with interrupts disabled (schedule()
does spin_lock_irq), but the cases I checked all turned out to be
OK [3].  Perhaps it is more problematic now?

Ciao,

Duncan.

[1] http://seclists.org/lists/linux-kernel/2003/May/5585.html
[2] http://seclists.org/lists/linux-kernel/2003/May/5842.html
[3] http://seclists.org/lists/linux-kernel/2003/May/5581.html
