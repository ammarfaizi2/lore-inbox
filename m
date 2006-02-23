Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWBWVXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWBWVXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWBWVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:23:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751784AbWBWVXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:23:23 -0500
Date: Thu, 23 Feb 2006 22:05:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, greg@kroah.com,
       len.brown@intel.com, muneda.takahiro@jp.fujitsu.com
Subject: Re: [patch 0/3] New dock patches
Message-ID: <20060223210525.GA1735@elf.ucw.cz>
References: <1140636081.32574.18.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140636081.32574.18.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hello, this is a new set of docking station patches which replaces
> the old docking station patches.  It applies to 2.6.16-rc4-mm1.  It
> is new and improved over the old version, in that it can now handle
> laptops which define docking stations outside of the scope of PCI.
> 
> Thanks to everyone who provided feedback on the original patches, and
> especially to Pavel who is the only brave soul to test these patches
> out so far :).  As always, I would appreciate feedback on these 
> patches.

I tested the new version from today... it works okay. It produces some
weird messages:

acpiphp: Slot [4294967295] registered
ACPI Exception (acpi_bus-0072): AE_NOT_FOUND, No context for object
[c1d081e8] [20060210]
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Transparent bridge - 0000:02:03.0
PCI: Bus #0c (-#0f) is hidden behind transparent bridge #02 (-#0b)
Please report the result to linux-kernel to fix this permanently
PCI: Bus #10 (-#13) is hidden behind transparent bridge #02 (-#0b)
Please report the result to linux-kernel to fix this permanently
ACPI Exception (acpi_bus-0072): AE_NOT_FOUND, No context for object
[c1d02368] [20060210]

Could the code be fixed not to start numbering slots from -1?

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
