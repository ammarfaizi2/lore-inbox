Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbUDOP24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbUDOP24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:28:56 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36548 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264333AbUDOP2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:28:53 -0400
Date: Thu, 15 Apr 2004 11:29:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 4k irqstacks on x86 (and add voyager support)
In-Reply-To: <1082042268.2166.2.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0404151126090.10471@montezuma.fsmlabs.com>
References: <1082042268.2166.2.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, James Bottomley wrote:

> There's a bug in the x86 code in that it sets the boot CPU to zero.
> This isn't correct since some subarch's use physically indexed CPUs.
> However, subarchs have either set the boot cpu before irq_INIT() (or
> just inherited the default zero from INIT_THREAD_INFO()), so it's safe
> to believe current_thread_info()->cpu about the boot cpu.

There is also smp_boot_cpus() which sets it to zero yet again later on =)
