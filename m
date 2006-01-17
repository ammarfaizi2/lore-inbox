Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWAQCfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWAQCfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 21:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWAQCfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 21:35:44 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:1456 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751292AbWAQCfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 21:35:43 -0500
X-ORBL: [67.117.73.34]
Date: Mon, 16 Jan 2006 18:35:24 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 6/6] serial8250: convert to the new platform device interface
Message-ID: <20060117023524.GQ4511@atomide.com>
References: <20060116233143.GB23097@flint.arm.linux.org.uk> <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kumar Gala <galak@gate.crashing.org> [060116 16:02]:
> On Mon, 16 Jan 2006, Russell King wrote:
> 
> > On Mon, Jan 16, 2006 at 04:27:17PM -0600, Kumar Gala wrote:
> > > This patch is breaking arch/ppc & arch/powerpc usage of 8250.c.  The  
> > > issue appears to be with the order in which platform_driver_register 
> > > () is called vs platform_device_add().
> > > 
> > > arch/powerpc/kernel/legacy_serial.c registers an 8250 device on the  
> > > platform bus before 8250_init() gets called.
> > > 
> > > Changing the order of platform_driver_register() vs  
> > > platform_device_add() fixes the issue.  I'm still not sure what the  
> > > correct solution to this is. Ideas? comments?
> > 
> > Mea Culpa - should've spotted that - that patch is actually rather
> > broken.  platform_driver_register() can't be moved from where it
> > initially was.
> 
> This seems to fix my issue on arch/powerpc and arch/ppc, please push to 
> Linus ASAP.

This patch fixes problems on omap too.

Tony
