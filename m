Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWASPtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWASPtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161241AbWASPts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:49:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19460 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161188AbWASPts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:49:48 -0500
Date: Wed, 18 Jan 2006 14:51:16 +0000
From: Pavel Machek <pavel@ucw.cz>
To: dtor_core@ameritech.net
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4] Hot Dock/Undock support
Message-ID: <20060118145116.GA2757@ucw.cz>
References: <1137545813.19858.45.camel@whizzy> <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy> <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy> <20060118222348.GG1580@elf.ucw.cz> <1137629220.31839.56.camel@whizzy> <d120d5000601190723k3339f92eufc3bc1d0832f6058@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000601190723k3339f92eufc3bc1d0832f6058@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Hope this helps.
> > >                                               Pavel
> >
> >
> > so the problem that I see is that this dsdt defines two separate dock
> > devices, one outside the scope of pci, and one within it.  The one
> > outside the scope of pci defines the _EJ0 and _DCK methods.  So, when
> > acpiphp loads, it scans the pci slots for ejectable slots, finds none
> > (because _EJ0 is defined in the dock device that is outside the scope of
> > pci) and exits.  This dsdt is different from the others I've used in
> > that most of them define all methods related to docking under the actual
> > dock bridge (within the scope of pci).  perhaps some acpi people can
> > shed some light on the best way to handle this - otherwise I'm sure I
> > can hack something up that will be less than acceptable :).
> >
> 
> ACPI has (had?) a braindamage - it drops devices that do not present
> when initially scanning ACPI namespace. So if you boot undocked - too
> bad. Driver won't ever see your docking station.

I think I booted docked....

-- 
Thanks, Sharp!
