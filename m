Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTKHUXp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTKHUXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:23:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2441 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262128AbTKHUXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:23:43 -0500
Message-ID: <3FAD50B6.2020502@pobox.com>
Date: Sat, 08 Nov 2003 15:23:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] libata fixes
References: <20031108172621.GA8041@gtf.org> <pan.2003.11.08.20.16.54.779374@altlinux.ru>
In-Reply-To: <pan.2003.11.08.20.16.54.779374@altlinux.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> (Not about this particular libata update)
> 
> static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
> ...
> 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,
> 	  quirk_intel_ide_combined },
> 
> Won't this oops if some Intel device would be hotplugged?  A similar
> problem with quirk_via_bridge was just fixed.


We should probably start marking entries as "no hotplug" because many of 
the quirks have no need to be run after initial boot.

	Jeff



