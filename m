Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWHONrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWHONrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWHONrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:47:17 -0400
Received: from tango.0pointer.de ([217.160.223.3]:13839 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S1030291AbWHONrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:47:16 -0400
Date: Tue, 15 Aug 2006 15:47:12 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Thomas Renninger <trenn@suse.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Message-ID: <20060815134710.GB28473@tango.0pointer.de>
References: <20060810010517.GA20849@curacao> <1155645736.4302.1161.camel@queen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155645736.4302.1161.camel@queen.suse.de>
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15.08.06 14:42, Thomas Renninger (trenn@suse.de) wrote:

> > +config ACPI_MSI_S270
> > +	tristate "MSI S270 Laptop Extras"
> > +	depends on X86
> > +    depends on BACKLIGHT_CLASS_DEVICE
> > +	---help---
> > +	  This is a Linux ACPI driver for MSI S270 laptops. It adds
> > +	  support for Bluetooth, WLAN and LCD brightness control.
> > +
> > +	  More information about this driver is available at
> > +	  <http://0pointer.de/lennart/tchibo.html>.
> > +
> > +	  If you have an MSI S270 laptop, say Y or M here.
> 
> I don't know anything about MSI laptops. But S270 sounds like a very
> specific model to me?

There are quite a lot of different S270 laptops. And the laptops are
sold under various brands and names, hence it's not that specific. 

Until now I found the laptop under the brands MSI, Cytron, TCM,
Medion, Tchibo and the names MegaBook, S270, MD96100, MS-1013,
SAM2000. And I am sure there are even more names/brands...

> Shouldn't the driver just be called acpi_msi driver and try to also
> support other MSI models later that might do things at least
> similar?

The driver uses the ACPI EC but doesn't call any ACPI DSDT method. On
request of Len Brown I moved the driver out of the /drivers/acpi/
namespace and made it use sysfs instead of /proc/acpi:

http://lwn.net/Articles/194916/

Hence I don't think it is a good idea to prefix the driver name with
"acpi_".

I would like to support other laptop models from MSI (specifically
S260), however I don't have access to any of them or to the necessary
hardware information.

But yes, I guess I could rename the driver to "laptop_msi.c" or
something. Although I don't know if the other models use a similar
ACPI EC interface to the S270 model. 

If anyone has a S260 and wants to test this driver on it: please
contact me!

Lennart

-- 
Lennart Poettering; lennart [at] poettering [dot] net
ICQ# 11060553; GPG 0x1A015CC4; http://0pointer.net/lennart/
