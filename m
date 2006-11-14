Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755383AbWKNFuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383AbWKNFuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 00:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbWKNFuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 00:50:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:32166 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1755383AbWKNFuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 00:50:52 -0500
Subject: Re: [PATCH 2/2] Use dev_sysdata for ACPI and remove firmware_data
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Len Brown <lenb@kernel.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200611140043.30714.len.brown@intel.com>
References: <1163033916.28571.803.camel@localhost.localdomain>
	 <20061110054944.GB9137@kroah.com>  <200611140043.30714.len.brown@intel.com>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 16:50:13 +1100
Message-Id: <1163483414.5940.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> device.firmware_data was born when we went to link Linux devices
> and ACPI devices using device.platform_data and found it was already used.
> You recommended we create a new field to avoid the conflict, and
> IIR the discussion suggested that eventually device.platform_data use
> would get cleaned up and the fields could perhaps some day be combined.
> 
> I don't know if we are any closer to that day, before or after this change.

I've audited use of platform data and plan to get rid of it too :-)

(Or actually move it to platform_device where it belongs and fix other
abusers)

> However, I'm fine with Ben's re-name -- it changes no functionality on ACPI-enabled
> systems while potentially deleting an unused pointer/dev on other architectures.
> 
> Please ship his patch #2 along with patch #1 that it depends on.
> 
> Acked-by: Len Brown <len.brown@intel.com>

Excellent, thanks !

Cheers,
Ben.


