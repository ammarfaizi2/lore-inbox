Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965838AbWKTPVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965838AbWKTPVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965899AbWKTPVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:21:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13316 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965904AbWKTPVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:21:04 -0500
Date: Mon, 20 Nov 2006 15:20:41 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: first proposal for pci resume quirk interface
Message-ID: <20061120152041.GA4199@ucw.cz>
References: <20061114175510.6e7c7119@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114175510.6e7c7119@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Looks okay to me.


>  #define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)			\
>  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,			\
>  			vendor##device##hook, vendor, device, hook)
> +#define DECLARE_PCI_FIXUP_RESUME(vendor, device, hook)			\
> +	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,			\
> +			resume##vendor##device##hook, vendor, device, hook)

Maybe having DECLARE_PCI_FIXUP_ALWAYS (meaning ENABLE+RESUME)  would reduce the code
duplication?

-- 
Thanks for all the (sleeping) penguins.
