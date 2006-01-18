Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWARJ5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWARJ5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWARJ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:57:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41746 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751307AbWARJ5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:57:03 -0500
Date: Wed, 18 Jan 2006 09:56:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: Kumar Gala <galak@gate.crashing.org>,
       Kumar Gala <galak@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 6/6] serial8250: convert to the new platform device interface
Message-ID: <20060118095642.GA20588@flint.arm.linux.org.uk>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	Kumar Gala <galak@gate.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
References: <20060116233143.GB23097@flint.arm.linux.org.uk> <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org> <20060117193604.GA25724@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117193604.GA25724@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 08:36:04PM +0100, Olaf Hering wrote:
>  On Mon, Jan 16, Kumar Gala wrote:
> > > Mea Culpa - should've spotted that - that patch is actually rather
> > > broken.  platform_driver_register() can't be moved from where it
> > > initially was.
> > 
> > This seems to fix my issue on arch/powerpc and arch/ppc, please push to 
> > Linus ASAP.
> 
> This fixes also my pseries, p270. Too bad, the 8250 depends on
> CONFIG_ISA now which is not selectable for CONFIG_PPC_PSERIES. 
> Is this patch the way to go for ppc64?

8250 does not depend on ISA - at least not in mainline.  If it did depend
on ISA, that would be completely wrong.

ISA should be set if you have ISA slots on your motherboard (as the help
says).  The presence of 8250 devices does not depend on whether you have
ISA slots or not.

Patch rejected.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
