Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVFHNcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVFHNcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVFHNcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:32:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:63181 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261212AbVFHNc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:32:27 -0400
Date: Wed, 8 Jun 2005 15:32:26 +0200
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050608133226.GR23831@wotan.suse.de>
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com> <20050608050212.GD21060@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608050212.GD21060@colo.lackof.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also see one minor weakness in the assumption that CPU Vectors
> are global. Both IA64/PARISC can support per-CPU Vector tables.

x86-64 will eventually too, I definitely plan for it at some point.
We need it for very big machines where 255 interrupt vectors 
are not enough. And as you say with MSI-X it becomes even more
important.

-Andi
