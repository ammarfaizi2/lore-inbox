Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbUL0QJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbUL0QJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUL0QJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:09:19 -0500
Received: from holomorphy.com ([207.189.100.168]:27601 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261922AbUL0QJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 11:09:05 -0500
Date: Mon, 27 Dec 2004 08:08:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@HansenPartnership.com, paulus@samba.org,
       davem@davemloft.net, lethal@linux-sh.org, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, takata@inux-m32r.org, ak@suse.de,
       rth@twiddle.net, matthew@wil.cx
Subject: Re: [PATCH] fix conflicting cpu_idle() declarations
Message-ID: <20041227160848.GC771@holomorphy.com>
References: <41D033FE.7AD17627@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D033FE.7AD17627@tv-sign.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 07:10:38PM +0300, Oleg Nesterov wrote:
> cpu_idle() declared/defined in
> init/main.c:				void cpu_idle(void)
> i386/kernel/process.c			void cpu_idle(void)
> i386/kernel/smpboot.c:		int  cpu_idle(void)
> i386/mach-voyager/voyager_smp.c:	int  cpu_idle(void)
> ppc/kernel/idle.c:			int  cpu_idle(void)
> ppc/kernel/smp.c:			int  cpu_idle(void *unused)
> ppc64/kernel/idle.c:			int  cpu_idle(void)
> ppc64/kernel/smp.c:			int  cpu_idle(void *unused)
> sparc/kernel/process.c:		int  cpu_idle(void)
> sparc64/kernel/process.c:		int  cpu_idle(void)
> sh/kernel/process.c:			void cpu_idle(void *unused)
> sh/kernel/smp.c:			int  cpu_idle(void *unused)
> ia64/kernel/smpboot.c:		int  cpu_idle(void)
> ia64/kernel/process.c:		void cpu_idle(void *unused)

It's remarkable that several arches are internally inconsistent. Anyway,
this will likely be a shoo-in, as it removes more code than it adds. The
mess surrounding cpu_idle() has been aggravating for some time.


-- wli
