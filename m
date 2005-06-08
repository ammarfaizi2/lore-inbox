Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVFHNec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVFHNec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFHNe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:34:29 -0400
Received: from ns.suse.de ([195.135.220.2]:11214 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261213AbVFHNeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:34:20 -0400
Date: Wed, 8 Jun 2005 15:34:12 +0200
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: Greg KH <gregkh@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050608133412.GS23831@wotan.suse.de>
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de> <1118129500.5497.16.camel@laptopd505.fenrus.org> <20050607161029.GB15345@suse.de> <1118176872.5497.38.camel@laptopd505.fenrus.org> <20050607220832.GA19173@suse.de> <52ekbdg53q.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ekbdg53q.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I think that the driver definitely needs to be in control of how
> many MSI-X interrupts it gets.  The current mthca driver knows that it
> has three different event queues -- one for firmware command events,
> one for async events such as link up/down, and one for actual tx/rx
> completions -- and uses a separate MSI-X message for each one.

The idea was always to have MSI by default and if the driver 
wants MSI-X it turns off standard MSI and does its own thing
completely.

-Andi
