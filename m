Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWJGOpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWJGOpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 10:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWJGOpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 10:45:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5569 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932119AbWJGOpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 10:45:40 -0400
Message-ID: <4527BD42.8050502@garzik.org>
Date: Sat, 07 Oct 2006 10:44:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Matthew Wilcox <matthew@wil.cx>, Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] [TULIP] Check the return value from pci_set_mwi()
References: <1160161519800-git-send-email-matthew@wil.cx> <11601615192857-git-send-email-matthew@wil.cx> <4526AB43.7030809@garzik.org> <20061006192842.GO2563@parisc-linux.org> <4526B5BD.4030809@garzik.org> <20061007053448.GC3314@colo.lackof.org>
In-Reply-To: <20061007053448.GC3314@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Fri, Oct 06, 2006 at 03:59:57PM -0400, Jeff Garzik wrote:
>> The unmodified tulip driver checks both MWI and cacheline-size because 
>> one of the clones (PNIC or PNIC2) will let you set the MWI bit, but 
>> hardwires cacheline size to zero.
> 
> Maybe the generic pci_set_mwi() can verify cacheline size is non-zero?
> I don't think each driver should need to enforce this.

Agreed.


>> If the arches do not behave consistently, we need to keep the check in 
>> the tulip driver, to avoid incorrectly programming the csr0 MWI bit.
> 
> Why not fix the arches to be consistent?
> There's alot more drivers than arches...and we have control
> of the arch specific PCI support.

Agreed.

	Jeff



