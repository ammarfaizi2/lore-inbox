Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWBWVk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWBWVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWBWVkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:40:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42406 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751780AbWBWVkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:40:55 -0500
Date: Thu, 23 Feb 2006 22:40:03 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, greg@kroah.com,
       len.brown@intel.com, muneda.takahiro@jp.fujitsu.com
Subject: Re: [patch 0/3] New dock patches
Message-ID: <20060223214003.GB1662@elf.ucw.cz>
References: <1140636081.32574.18.camel@whizzy> <20060223210525.GA1735@elf.ucw.cz> <1140730882.11750.33.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140730882.11750.33.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I tested the new version from today... it works okay. It produces some
> > weird messages:
> > 
> > acpiphp: Slot [4294967295] registered
> > ACPI Exception (acpi_bus-0072): AE_NOT_FOUND, No context for object
> > [c1d081e8] [20060210]
> > PCI: Found IBM Dock II Cardbus Bridge applying quirk
> > PCI: Found IBM Dock II Cardbus Bridge applying quirk
> > PCI: Transparent bridge - 0000:02:03.0
> > PCI: Bus #0c (-#0f) is hidden behind transparent bridge #02 (-#0b)
> > Please report the result to linux-kernel to fix this permanently
> > PCI: Bus #10 (-#13) is hidden behind transparent bridge #02 (-#0b)
> > Please report the result to linux-kernel to fix this permanently
> > ACPI Exception (acpi_bus-0072): AE_NOT_FOUND, No context for object
> > [c1d02368] [20060210]
> > 
> > Could the code be fixed not to start numbering slots from -1?
> > 
> > 								Pavel
> 
> Yeah, the problem is that laptops don't implement _SUN, which is used
> for the slot numbering by the existing acpiphp code.  So the slot number
> will read -1 if _SUN is missing.  I'm not sure if 0 is a valid slot
> number, and I wasn't sure if that would make sense either.  I think that
> I'm going to have to provide a separate user space interface to the dock
> anyway, since we now know that it's possible to have a dock station that
> has no pci slots at all.

I'd certainly say that 0 is better slot number then -1... If it is
easy to make it 0 instead of -1, please change it.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
