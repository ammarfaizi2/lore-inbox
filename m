Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVCGIki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVCGIki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVCGIki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:40:38 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:61152 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261699AbVCGIkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:40:05 -0500
Subject: Re: [Bug 4298] swsusp fails to suspend if CONFIG_DEBUG_PAGEALLOC
	is also enabled
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Stefan Seyfried <seife@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       barryn@pobox.com, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <422C0A6B.1060700@suse.de>
References: <20050306030852.23eb59db.akpm@osdl.org>
	 <20050306225730.GA1414@elf.ucw.cz> <20050306195954.6d13cff9.akpm@osdl.org>
	 <422C0A6B.1060700@suse.de>
Content-Type: text/plain
Message-Id: <1110184908.23356.7.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 07 Mar 2005 19:41:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-03-07 at 19:01, Stefan Seyfried wrote:
> Andrew Morton wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> 
> >> Okay, that is because low-level assembly requires PSE (4mb pages for
> >> kernel) and DEBUG_PAGEALLOC disables that capability.
> >> 
> >> If you feel like rewriting assembly code to turn off paging (and thus
> >> working with PSE), go ahead, but I do not think it is worth the
> >> trouble.
> >> 
> >> OTOH we should at least tell people what went wrong, some people seen
> >> same problem on VIA cpus... Please apply,
> >> 
> > 
> > Isn't some Kconfig solution appropriate here?
> 
> Yes, but only for the CONFIG_DEBUG_PAGEALLOC case, it does not solve the
> "cpu has no PSE" case for VIA CPUs. So the Kconfig solution is an extra
> bonus.

Yeah - separate issues. Suspend2 has worked with CONFIG_DEBUG_PAGEALLOC.
You just have to map in all the pages before doing the atomic copies.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


