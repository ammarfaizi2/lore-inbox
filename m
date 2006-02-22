Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWBVGu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWBVGu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 01:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBVGu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 01:50:27 -0500
Received: from sd291.sivit.org ([194.146.225.122]:5385 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1751342AbWBVGu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 01:50:26 -0500
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
From: Stelian Pop <stelian@popies.net>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Matt_Domsch@dell.com,
       hostmaster@ed-soft.at, Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <200602212209.07586.ak@suse.de>
References: <43FA5293.4070807@ed-soft.at> <p73ek1w4x3a.fsf@verdi.suse.de>
	 <20060221125919.5085de5f.akpm@osdl.org>  <200602212209.07586.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 22 Feb 2006 07:50:22 +0100
Message-Id: <1140591022.4813.7.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 21 février 2006 à 22:09 +0100, Andi Kleen a écrit :
> On Tuesday 21 February 2006 21:59, Andrew Morton wrote:

> > OK, thanks.  I don't think we actually know who is trying to unmap some
> > memory which acpi didn't map.
> > 
> > Edgar, can you please describe the bug which you're trying to fix?
> 
> I think the bug is clear - the logic in acpi_os_unmap_memory needs to match 
> what acpi_os_map_memory() does for EFI. In particular this means not calling
> iounmap.
> 
> He probably has a EFI system where this caused troubles.

This EFI system is the new Intel Core Duo based Apple iMac (Edgar
described the process of booting Linux on this pretty box at 
http://www.mactel-linux.org/)

In particular, the iounmap problem is visible in the logs at
http://www.mactel-linux.org/wiki/Dmesg

Stelian.
-- 
Stelian Pop <stelian@popies.net>

