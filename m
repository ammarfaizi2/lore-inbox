Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWFWUSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWFWUSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWFWUSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:18:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:41392 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752021AbWFWUSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:18:37 -0400
Message-ID: <449C4C8B.4010009@garzik.org>
Date: Fri, 23 Jun 2006 16:18:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: rajesh.shah@intel.com
CC: ak@suse.de, gregkh@suse.de, akpm@osdl.org, brice@myri.com,
       76306.1226@compuserve.com, arjan@linux.intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/2] PCI: improve extended config space verification
References: <20060623200928.036235000@rshah1-sfield.jf.intel.com>
In-Reply-To: <20060623200928.036235000@rshah1-sfield.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rajesh.shah@intel.com wrote:
> ACPI defines an MCFG table that gives us the pointer to where the
> extended PCI-X/PCI-Express configuration space exists. We validate
> this region today by making sure that the reported range is marked
> as reserved in the int 15 E820 memory map. However, the PCI firmware
> spec states this is optional and BIOS should be reporting the MCFG
> range as a motherboard resources. Several of my systems failed the
> existing check and ended up without extended PCI-Express config
> space. This patch extends the verification to also look for the
> MCFG range as a motherboard resource in ACPI. This solves the
> problem on my i386 as well as x86_64 test systems.

On a related note -- PCI segments potentially enumerated in ACPI -- I 
have a PCI segments patch available at:

'pciseg' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

GregKH also has a few fixes for this which I need to integrate, too.

	Jeff


