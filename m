Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUKHRMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUKHRMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUKHRIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:08:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53165 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261939AbUKHQi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:38:56 -0500
Date: Mon, 8 Nov 2004 16:38:55 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, "Li, Shaohua" <shaohua.li@intel.com>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>,
       Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [ACPI] [PATCH/RFC 0/4]Bind physical devices with ACPI devices
Message-ID: <20041108163855.GC32374@parcelfarce.linux.theplanet.co.uk>
References: <3ACA40606221794F80A5670F0AF15F84041AC033@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC033@pdsmsx403>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 12:08:03AM +0800, Yu, Luming wrote:
> >On Mon, Nov 08, 2004 at 10:46:30PM +0800, Yu, Luming wrote:
> >> >All we need is an acpi_get_gendev_handle that takes a 
> >struct device and
> >> >returns the acpi_handle for it.  Now, maybe that'd be best 
> >> >done by placing
> >> >a pointer in the struct device, but I bet it'd be just as 
> >good to walk
> >> >the namespace looking for the corresponding device.
> 
>   We need not only able to locate acpi object IDE0
> but also we need to locate object PRIM underneath
> IDE0,  and MSTR underneath PRIM. Thus, IDE driver 
> can fully take advantage from ACPI, in terms of 
> configuration and power management.
> 
>   Maybe we need to invent a method called
> map_device_addr_to_acpi_handle to be  generic solution.

I think we're saying the same thing in different words here ...

Note that an acpi_get_gendev_handle() or map_device_addr_to_acpi_handle()
function doesn't *preclude* putting a void * in struct device.  It does
let us choose whether or not to do so.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
