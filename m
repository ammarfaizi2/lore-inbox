Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVFHEjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVFHEjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 00:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVFHEjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 00:39:13 -0400
Received: from colo.lackof.org ([198.49.126.79]:22991 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262099AbVFHEjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 00:39:05 -0400
Date: Tue, 7 Jun 2005 22:42:44 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Roland Dreier <roland@topspin.com>
Cc: Greg KH <gregkh@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050608044244.GC21060@colo.lackof.org>
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de> <1118129500.5497.16.camel@laptopd505.fenrus.org> <20050607161029.GB15345@suse.de> <1118176872.5497.38.camel@laptopd505.fenrus.org> <20050607220832.GA19173@suse.de> <52ekbdg53q.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ekbdg53q.fsf@topspin.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 03:43:53PM -0700, Roland Dreier wrote:
> I'm sure other MSI-X capable devices can slice and dice things differently.

Yes. Need to talk to Neterion about MSI-X support for their 10Gige
product. I expect Intel's 10Gige also can make use of MSI-X.

One of the key things MSI-X was expected to do was distribute
seperate TX/RX "queues" (aka descriptor rings) across CPUs.
As such, each CPU would "own" a set of queues.

I don't know if the 10GigE cards were in fact able to implement
this functionality. But I would like to know if they did/do.

thanks
grant
