Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWG2XKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWG2XKU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWG2XKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:10:19 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:50817 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750746AbWG2XKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:10:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Date: Sun, 30 Jul 2006 01:10:01 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org, linux-mm@kvack.org
References: <20060727015639.9c89db57.akpm@osdl.org> <200607292059.59106.rjw@sisk.pl> <44CBE9D5.9030707@gmail.com>
In-Reply-To: <44CBE9D5.9030707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607300110.01943.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 01:06, Jiri Slaby wrote:
> Rafael J. Wysocki napsal(a):
> > Hi,
> > 
> > On Saturday 29 July 2006 19:58, Jiri Slaby wrote:
> >> Andrew Morton napsal(a):
> >>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> >> Hello,
> >>
> >> I have problems with swsusp again. While suspending, the very last thing kernel
> >> writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
> >> Here is a snapshot of the screen:
> >> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
> >>
> >> It's SMP system (HT), higmem enabled (1 gig of ram).
> > 
> > Most probably it hangs in device_power_up(), so the problem seems to be
> > with one of the devices that are resumed with IRQs off.
> > 
> > Does vanila .18-rc2 work?
> 
> Yup, it does.

Hm, in fact this may be a problem with any device driver.

Could you please boot the system with init=/bin/bash and try to suspend?

Rafael
