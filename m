Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUHLAwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUHLAwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUHLAuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:50:40 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:59345 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268515AbUHLAk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:40:58 -0400
Date: Wed, 11 Aug 2004 20:44:53 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, lhcs-devel@lists.sourceforge.net
Subject: Re: [lhcs-devel] Re: [PATCH][2.6-mm] i386 Hotplug CPU
In-Reply-To: <20040811135019.GC1120@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.58.0408112043100.2544@montezuma.fsmlabs.com>
References: <1090870667.22306.40.camel@pants.austin.ibm.com>
 <20040726170157.7f4b414c.akpm@osdl.org> <Pine.LNX.4.58.0407270137510.25781@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0407270440200.23985@montezuma.fsmlabs.com>
 <20040811135019.GC1120@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, 11 Aug 2004, Pavel Machek wrote:

> > +#ifdef CONFIG_HOTPLUG_CPU
> > +#include <asm/nmi.h>
> > +/* We don't actually take CPU down, just spin without interrupts. */
> > +static inline void play_dead(void)
> > +{
>
> Well... if this can be fixed to really take cpu down, it will
> be immediately usefull for suspend-to-ram. If it is made to
> at least survive registers being overwritten, it will be usefull
> for suspend-to-disk...

Yeah i recall you mentioning this earlier, i'll look into adding the
necessary bits so that you have enough state to resume from. Your
mentioning this was one of the reasons i wanted this in.

Thanks,
	Zwane

