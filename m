Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVFHNhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFHNhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFHNhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:37:52 -0400
Received: from ns.suse.de ([195.135.220.2]:34254 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261233AbVFHNhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:37:39 -0400
Date: Wed, 8 Jun 2005 15:37:32 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050608133732.GV23831@wotan.suse.de>
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de> <1118129500.5497.16.camel@laptopd505.fenrus.org> <20050607161029.GB15345@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607161029.GB15345@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The issue is, if pci_enable_msix() fails, we want to fall back to MSI,
> so you need to call pci_enable_msi() for that (after calling
> pci_disable_msi() before calling pci_enable_msix(), what a mess...)

It is messy in that case, but still preferable to having MSI code
in every driver. I suppose most devices will not use MSI-X for some time...

-Andi
