Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWFQHMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWFQHMA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 03:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWFQHMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 03:12:00 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:39560 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932464AbWFQHL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 03:11:59 -0400
Message-ID: <4493AB39.7010409@myri.com>
Date: Sat, 17 Jun 2006 03:11:53 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport
 capabilities
References: <4493709A.7050603@myri.com> <20060617062840.GD31645@kroah.com>
In-Reply-To: <20060617062840.GD31645@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Whitelisting looks all well and good today, and maybe for the rest of
> the year.  But what about 3 years from now when everyone has shaken all
> of the MSI bugs out of their chipsets finally?  Do you really want to
> add a new quirk for _every_ new chipset that comes out?  I don't think
> that it is managable over the long run.
>   

We could still reverse the default. Right now, unless pci=forcemsi is
passed, I disable MSI if we don't know whether the chipset supports it.
Once blacklisting has been improved/completed, we can enable MSI by
default (and keep "pci=nomsi" in case a non-blacklisted chipset appears).

Or we could enable MSI by default on PCI-E chipsets and disable by
default on non-PCI-E (ie we whitelist non-PCI-E only) ? PCI-E chipsets
seem to support MSI pretty well.

I am ok with any strategy as long as I don't end up passing "pci=nomsi"
on most new machines I will install in the next 10 years (as I did with
"noapic" in the past) :)

Brice

