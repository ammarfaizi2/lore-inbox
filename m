Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbUDOPdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbUDOPdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:33:43 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:13802 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264332AbUDOPdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:33:41 -0400
Subject: Re: [PATCH] fix 4k irqstacks on x86 (and add voyager support)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404151126090.10471@montezuma.fsmlabs.com>
References: <1082042268.2166.2.camel@mulgrave> 
	<Pine.LNX.4.58.0404151126090.10471@montezuma.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Apr 2004 10:33:25 -0500
Message-Id: <1082043207.1804.4.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 10:29, Zwane Mwaikambo wrote:
> > There's a bug in the x86 code in that it sets the boot CPU to zero.
> > This isn't correct since some subarch's use physically indexed CPUs.
> > However, subarchs have either set the boot cpu before irq_INIT() (or
> > just inherited the default zero from INIT_THREAD_INFO()), so it's safe
> > to believe current_thread_info()->cpu about the boot cpu.
> 
> There is also smp_boot_cpus() which sets it to zero yet again later on =)

That's PC specific, not subarch generic, so it doesn't matter to me.

James


