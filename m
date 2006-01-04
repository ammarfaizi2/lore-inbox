Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbWADWgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbWADWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbWADWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:36:09 -0500
Received: from mailhub.hp.com ([192.151.27.10]:38807 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S965292AbWADWgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:36:07 -0500
Subject: Re: [PATCH 2.6.15 1/2] ia64: use i386 dmi_scan.c
From: Alex Williamson <alex.williamson@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060104221627.GA26064@lists.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com>
Content-Type: text/plain
Organization: OSLO R&D
Date: Wed, 04 Jan 2006 15:36:03 -0700
Message-Id: <1136414164.6198.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 16:16 -0600, Matt Domsch wrote:
> Andi Kleen has a patch in his x86_64 tree which enables the use of
> i386 dmi_scan.c on x86_64.  dmi_scan.c functions are being used by the
> drivers/char/ipmi/ipmi_si_intf.c driver for autodetecting the ports or
> memory spaces where the IPMI controllers may be found.

   Can't this be done via ACPI/EFI?  I'm really opposed to adding
anything to ia64 that blindly picks memory ranges and starts scanning
for magic legacy tables.  If nothing else, this can be found via
efi.smbios.  Thanks,

	Alex

