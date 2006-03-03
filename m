Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWCCSe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWCCSe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCCSe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:34:59 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:40304 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751337AbWCCSe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:34:58 -0500
Date: Fri, 03 Mar 2006 13:31:16 -0500
From: Jon Ringle <jringle@vertical.com>
Subject: Re: Linux running on a PCI Option device?
In-reply-to: <1141396843.8912.49.camel@localhost.localdomain>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
Message-id: <200603031331.16849.jringle@vertical.com>
Organization: Vertical
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <43EAE4AC.6070807@snapgear.com>
 <200603030909.28640.jringle@vertical.com>
 <1141396843.8912.49.camel@localhost.localdomain>
User-Agent: KMail/1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 09:40 am, Adrian Cox wrote:
> Based on only a quick look at the code: if the Windows host is present,
> don't call pci_common_init() in ixdp425_pci_init().

Doing this will prevent the code in ixp4xx_pci_preinit() from executing which 
handles some initialization for both PCI host and option modes. Should I go 
ahead and explicitly call ixp4xx_pci_preinit() from ixdp425_pci_init() if in 
PCI option mode?

Jon
