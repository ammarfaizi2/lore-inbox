Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268193AbUHKTqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268193AbUHKTqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268195AbUHKTqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:46:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56245 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268193AbUHKTq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:46:26 -0400
Date: Wed, 11 Aug 2004 15:50:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, lhcs-devel@lists.sourceforge.net
Subject: Re: [PATCH][2.6-mm] i386 Hotplug CPU
Message-ID: <20040811135019.GC1120@openzaurus.ucw.cz>
References: <1090870667.22306.40.camel@pants.austin.ibm.com> <20040726170157.7f4b414c.akpm@osdl.org> <Pine.LNX.4.58.0407270137510.25781@montezuma.fsmlabs.com> <Pine.LNX.4.58.0407270440200.23985@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407270440200.23985@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +#ifdef CONFIG_HOTPLUG_CPU
> +#include <asm/nmi.h>
> +/* We don't actually take CPU down, just spin without interrupts. */
> +static inline void play_dead(void)
> +{

Well... if this can be fixed to really take cpu down, it will
be immediately usefull for suspend-to-ram. If it is made to
at least survive registers being overwritten, it will be usefull
for suspend-to-disk...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

