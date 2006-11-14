Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755393AbWKNFkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbWKNFkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 00:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbWKNFkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 00:40:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:2954 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1755393AbWKNFkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 00:40:51 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Use dev_sysdata for ACPI and remove firmware_data
Date: Tue, 14 Nov 2006 00:43:30 -0500
User-Agent: KMail/1.8.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1163033916.28571.803.camel@localhost.localdomain> <20061110054944.GB9137@kroah.com>
In-Reply-To: <20061110054944.GB9137@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140043.30714.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 00:49, Greg KH wrote:
> On Thu, Nov 09, 2006 at 11:58:36AM +1100, Benjamin Herrenschmidt wrote:
> > This patch changes ACPI to use the new dev_sysdata on x86 and x86_64 (is there
> > any other arch using ACPI ?) to store it's acpi_handle. It also removes the
> > firmware_data field from struct device as this was the only user.
> 
> Yeah!  I've wanted to drop firmware_data for a while now :)

device.firmware_data was born when we went to link Linux devices
and ACPI devices using device.platform_data and found it was already used.
You recommended we create a new field to avoid the conflict, and
IIR the discussion suggested that eventually device.platform_data use
would get cleaned up and the fields could perhaps some day be combined.

I don't know if we are any closer to that day, before or after this change.

However, I'm fine with Ben's re-name -- it changes no functionality on ACPI-enabled
systems while potentially deleting an unused pointer/dev on other architectures.

Please ship his patch #2 along with patch #1 that it depends on.

Acked-by: Len Brown <len.brown@intel.com>

thanks
-Len
