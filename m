Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280686AbRKNQre>; Wed, 14 Nov 2001 11:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280690AbRKNQrZ>; Wed, 14 Nov 2001 11:47:25 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:51163
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S280686AbRKNQrQ>; Wed, 14 Nov 2001 11:47:16 -0500
Date: Wed, 14 Nov 2001 12:33:25 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML 1.8.4 is available
Message-ID: <20011114123325.A500@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011113175010.A15716@thyrsus.com> <20011113182718.A1630@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113182718.A1630@kroah.com>; from greg@kroah.com on Tue, Nov 13, 2001 at 06:27:19PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com>:
> The following symbols should be allowed to be set to 'm' but are not:
> 	CONFIG_USB

That's odd.  M  shows up as a choice when I do xconfig.

> 	CONFIG_UHCI
> 	CONFIG_UHCI_ALT

My error.  These are declared bool rather than trit in the 1.8.5 rulebase.
I've just fixed tht.

> If CONFIG_USB_SERIAL is set to 'y' CONFIG_USB_SERIAL_DEBUG should be
> allowed to be chosen.  I do not see this happening.

Another rulebase bug, now fixed.

> And why is the CONFIG_USB_SERIAL options in the drivers/usb directory?
> In the CML1 version they live in their own subdirectory quite nicely :)
> Either way they should be in the USB port drivers section, not the "USB
> devices" section of the menu.

Historical reasons.  My rulebase was opriginally one big file for editing
conveniece.  What directory whould the USB serial stuff live in?

> There doesn't seem to be any rules set up for drivers/hotplug.

What symbols should be in there,
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Such are a well regulated militia, composed of the freeholders,
citizen and husbandman, who take up arms to preserve their property,
as individuals, and their rights as freemen.
        -- "M.T. Cicero", in a newspaper letter of 1788 touching the "militia" 
            referred to in the Second Amendment to the Constitution.
