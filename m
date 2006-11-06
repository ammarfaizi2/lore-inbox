Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161732AbWKFJVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161732AbWKFJVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161731AbWKFJVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:21:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21717 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161729AbWKFJVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:21:33 -0500
Date: Mon, 6 Nov 2006 10:21:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061106092117.GB2175@elf.ucw.cz>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061105232944.GA23256@vasa.acc.umu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
> > > info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
> > > (-mm1 behaves the same).
> > 
> > Looks like acpi is sending a BUS_CHECK notification to acpiphp on the 
> > PCI Root Bridge whenever the lid opens up.
> > 
> > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > it has no hotpluggable slots.
> 
> How about the docking station?

"Dock" for x60 only contains cdrom slot and aditional slots, no PCI or
PCMCIA slots.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
