Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWDNXCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWDNXCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 19:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWDNXCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 19:02:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:58647 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751296AbWDNXCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 19:02:22 -0400
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23419961:sNHT15985431"
Subject: RE: [patch 1/3] acpi: dock driver
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mochel@linux.intel.com, arjan@linux.intel.com,
       muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6300EE2@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6300EE2@hdsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Apr 2006 16:11:00 -0700
Message-Id: <1145056260.29319.55.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 14 Apr 2006 23:02:21.0174 (UTC) FILETIME=[7C404960:01C66017]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 15:42 -0700, Brown, Len wrote:
>  Re: indenting & white-space
> 
> Please run the whole thing through the latest Lindent.
> It will delete the white space.
> It will do a couple of stupid things with indenting --
> such as with MODULE_AUTHOR --
> feel free to hand tweak those by hand.
> 
> Re: acpi_os_free()
> Please call kfree() instead, that wrapper is intended
> just for the ACPICA core and although it appears symmetric,
> it really shouldn't be used outside drivers/acpi/*/*.c

Really?  why is it exported then?  We use this in drivers/pci/hotplug as
well, and it is all over the place in drivers/acpi.  Should I be
modifying the hotplug drivers to not use this call?
