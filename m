Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030927AbWKOTXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030927AbWKOTXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030926AbWKOTXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:23:24 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:6547 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030929AbWKOTXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:23:23 -0500
Message-ID: <455B6928.5030202@garzik.org>
Date: Wed, 15 Nov 2006 14:23:20 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <20061114.192117.112621278.davem@davemloft.net>	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>	<455A938A.4060002@garzik.org>	<20061114.201549.69019823.davem@davemloft.net>	<455A9664.50404@garzik.org> <20061115110953.6cafdef8@freekitty>
In-Reply-To: <20061115110953.6cafdef8@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Tue, 14 Nov 2006 23:24:04 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> David Miller wrote:
>>> Is this absolutely true?  I've never been sure about this point, and I
>>> was rather convinced after reading various documents that once you
>>> program up the MSI registers to start generating MSI this implicitly
>>> disabled INTX and this was even in the PCI specification.
>>>
>>> It would be great to get a definitive answer on this.
>>>
>>> If it is mandatory, perhaps the driver shouldn't be doing it and
>>> rather the PCI layer MSI enabling should.
> 
> pci_enable_msi() calls msi_capability_init() and that disables intx
> already.
[...]
> The driver shouldn't deal with this, pci_disable_msi() does.

Explicit code reference please?

AFAICS the PCI layer only touched INTx bit for PCI-Express devices.

	Jeff


