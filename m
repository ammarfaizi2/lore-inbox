Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265343AbUEZHrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUEZHrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265344AbUEZHrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:47:24 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:23277 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265343AbUEZHrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:47:23 -0400
Date: Wed, 26 May 2004 03:48:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Keith Owens <kaos@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6-mm] i386: enable interrupts on contention in
 spin_lock_irq 
In-Reply-To: <14280.1085556586@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58.0405260345470.1794@montezuma.fsmlabs.com>
References: <14280.1085556586@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Keith Owens wrote:

> Your patch opens a window where data that was protected by the disabled
> interrupt on entry becomes unprotected while waiting for the lock and
> can therefore change.
>
> It could be that I am worrying unnecessarily, after all any code that
> calls spin_lock_irq() with interrupts already disabled is probably
> wrong to start off with.  But it does need to be considered as a
> possible failure mode.

Granted there might be code like that, i'll throw in some debugging code
locally to test for such a condition. It wouldn't necessarily be a bug but
a very uncool way of obfuscating the locking.

Thanks,
	Zwane

