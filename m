Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUFVDvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUFVDvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 23:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUFVDvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 23:51:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52102 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266548AbUFVDvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 23:51:06 -0400
Message-ID: <40D7AC9B.5040409@pobox.com>
Date: Mon, 21 Jun 2004 23:50:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: Question on using MSI in PCI driver
References: <52lligqqlc.fsf@topspin.com>
In-Reply-To: <52lligqqlc.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> I'm looking at implementing MSI/MSI-X support in a PCI device driver
> I'm working on.  However, I've run into an issue with the MSI API that
> I would like some clarification on.
> 
> When I call pci_enable_msi, since my device is MSI-X capable, the
> kernel calls msix_capability_init, which works out the memory region
> where vectors should be written and then calls request_region.  (In
> fact it calls


Not answering your question directly, but...

You are breaking new ground by adding MSI support to a driver.  I thank 
you for this -- alot -- but you should realize there will probably be a 
little bit of PCI core work necessary in order to get things the way you 
want them.

Feel free to propose changes to the PCI core to accomodate your MSI driver.

	Jeff


