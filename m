Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTIEW3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTIEW3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:29:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26517 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265263AbTIEW3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:29:09 -0400
Message-ID: <3F590E28.6090101@pobox.com>
Date: Fri, 05 Sep 2003 18:28:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F59018E.5060604@pobox.com> <200309060016.16545.adq_dvb@lidskialf.net>
In-Reply-To: <200309060016.16545.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:
> On Friday 05 Sep 2003 10:35 pm, Jeff Garzik wrote:
>>This is why we _really_ need you to split up your patches.  Multiple
>>split-up patches, one per email, is preferred.  Don't worry about
>>sending us too much email:  we like it like that.
> 
> 
> If/when I split it up, is it acceptable to number the patches to give the 
> order they have to be applied in?

Absolutely.  It's quite common for me to receive a series of emails, all 
patches, where each successive patch has a dependency on the preceding 
one.  Linus just applies a patch series from Al Viro today which was 
presented as
	[PATCH] large dev_t - second series (1/15)
	[PATCH] large dev_t - second series (2/15)
			...
	[PATCH] large dev_t - second series (15/15)

Many of us have patch-applying scripts, which can apply an entire mbox 
full of patches.  The email subject lines, the patch, and any text you 
wrote in the email are all commited to the BitKeeper repository as a 
single changeset.


>>As an aside, I know at least part of the VIA irq routing stuff still 
>>needs fixing.  For some on-board VIA southbridge devices, irq routing is 
>>accomplished by writing the PCI_INTERRUPT_xxx values to PCI config 
>>registers of the target device; for others, the normal pirq PCI config 
>>registers on the southbridge are used.  Alan's new irq stuff in 2.4.x 
>>IMO should be merged into 2.6.x soonish, as Alan's work makes a big step 
>>towards making it possible to fix some of the harder-to-fix irq routing 
>>problems.
> 
> 
> Is this still an issue when using ACPI? Surely it should insulate the OS from 
> this chipset-specific stuff? 

Correct, proper ACPI tables on VIA will avoid this problem.

	Jeff



