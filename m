Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVFIOEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVFIOEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 10:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVFIOEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 10:04:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:21385 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262401AbVFIOEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 10:04:02 -0400
Date: Thu, 9 Jun 2005 16:03:51 +0200
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: Andi Kleen <ak@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050609140351.GD23831@wotan.suse.de>
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com> <20050608050212.GD21060@colo.lackof.org> <20050608133226.GR23831@wotan.suse.de> <52oeagethh.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52oeagethh.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 08:52:26AM -0700, Roland Dreier wrote:
>     Andi> x86-64 will eventually too, I definitely plan for it at some
>     Andi> point.  We need it for very big machines where 255 interrupt
>     Andi> vectors are not enough. And as you say with MSI-X it becomes
>     Andi> even more important.
> 
> MSI-X already works fine on x86-64.  For example, on the machine I'm

Yes, but only as long as you dont have too many devices. The problem
is that there are only 255 interrupt vectors right now, and that 
is not enough for bigger systems with many devices.

> sending this from, an Athlon64 system with Nforce 4 (and yes I am
> using IP-over-InfiniBand as the only network connection on my workstation):

A single CPU box does not even appear on the radar here.

-Andi
