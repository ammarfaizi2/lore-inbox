Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWI1Jp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWI1Jp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWI1Jp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:45:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:1505 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751812AbWI1Jp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:45:57 -0400
Message-ID: <451B99C5.7080809@garzik.org>
Date: Thu, 28 Sep 2006 05:45:41 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86[-64] PCI domain support
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com>
In-Reply-To: <20060928093332.GG22787@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Tue, Sep 26, 2006 at 03:15:08PM -0400, Jeff Garzik wrote:
>> The x86[-64] PCI domain effort needs to be restarted, because we've got
>> machines out in the field that need this in order for some devices to
>> work.
>>
> This breaks the Calgary IOMMU, since it uses sysdata for other
> purposes (going back from a bus to its IO address space). I'm looking
> into it.

You'll need to modify struct pci_sysdata in 
include/asm-{i386,x86_64}/pci.h to include the data that you previously 
stored directly into the sysdata pointer.

	Jeff



