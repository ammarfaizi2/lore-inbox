Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbUKHQjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUKHQjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUKHQhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:37:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261853AbUKHO72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:59:28 -0500
Date: Mon, 8 Nov 2004 14:59:24 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, "Li, Shaohua" <shaohua.li@intel.com>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>,
       Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [ACPI] [PATCH/RFC 0/4]Bind physical devices with ACPI devices
Message-ID: <20041108145924.GA32374@parcelfarce.linux.theplanet.co.uk>
References: <3ACA40606221794F80A5670F0AF15F84041AC032@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC032@pdsmsx403>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 10:46:30PM +0800, Yu, Luming wrote:
> >All we need is an acpi_get_gendev_handle that takes a struct device and
> >returns the acpi_handle for it.  Now, maybe that'd be best 
> >done by placing
> >a pointer in the struct device, but I bet it'd be just as good to walk
> >the namespace looking for the corresponding device.
> 
>   It will fail if you just simply walk namespace to find out 
> the corresponding acpi object, because there are NO
> hardware id or compatible id  can be passed in.
> Please check function acpi_bus_match.

It doesn't need the HID or CID.  Look at Shaohua's patches -- they don't
use HID or CID either.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
