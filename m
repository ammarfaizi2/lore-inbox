Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTITSY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 14:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTITSY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 14:24:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5578 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261929AbTITSY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 14:24:58 -0400
Message-ID: <3F6C9B6B.4070308@pobox.com>
Date: Sat, 20 Sep 2003 14:24:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 fix pci_generic_prep_mwi export breakage
References: <200309171038.48602.bjorn.helgaas@hp.com>
In-Reply-To: <200309171038.48602.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> I think the recent change to pci.c to export pci_generic_prep_mwi() 
> is incorrect.
> 
> pci_generic_prep_mwi() is only defined if !HAVE_ARCH_PCI_MWI,
> so it is wrong to export it.  In particular, it breaks on
> ia64, because we define HAVE_ARCH_PCI_MWI.
> 
> It looks to me like the following patch should be applied.  This
> removes the export and in fact makes pci_generic_prep_mwi() static
> as it is in 2.5.


Looks OK to me.  Marcelo applied this already, right?

	Jeff



