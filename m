Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUDNB1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 21:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUDNB1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 21:27:03 -0400
Received: from fmr10.intel.com ([192.55.52.30]:13206 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S263551AbUDNB1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 21:27:00 -0400
Subject: Re: [PATCH] fix Acer TravelMate 360 interrupt routing
From: Len Brown <len.brown@intel.com>
To: daniel.ritz@gmx.ch
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F8369@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F8369@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1081906004.2258.673.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Apr 2004 21:26:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-10 at 16:24, Daniel Ritz wrote:

>  ... routing via ACPI fails too.

Does everything work when booted in ACPI mode with "pci=noacpi"?

If so, I wouldn't be eager to add a model-specific !ACPI mode workaround
-- which if it goes into the kernel will be there forever.

Also, I'm not enthusiastic about adding the dmi entry for "pci=noacpi"
until we've taken a swing at finding out why Linux/ACPI doesn't work out
of the box on this platform and given up.  For we might find a fix for
this platform that helps other platforms.  Adding the platform-specific
automatic workaround just masks the problem for owners of that exact
model.

So for the ACPI mode part, I encourage you to file a bug here

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
Component Config-Interrupts
and assign it to me.  Or if a bug is open already,
please direct me to it.

thanks,
-Len


