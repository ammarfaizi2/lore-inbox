Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVFORcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVFORcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFORcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:32:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49282 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261242AbVFORbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:31:52 -0400
Message-ID: <42B065F9.7070902@pobox.com>
Date: Wed, 15 Jun 2005 13:31:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Greg KH <gregkh@suse.de>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/04] PCI: use the MCFG table to properly access pci
 devices (i386)
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615094833.GB11898@wotan.suse.de>
In-Reply-To: <20050615094833.GB11898@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, Jun 14, 2005 at 10:31:20PM -0700, Greg KH wrote:
> 
>>Now that we have access to the whole MCFG table, let's properly use it
>>for all pci device accesses (as that's what it is there for, some boxes
>>don't put all the busses into one entry.)
>>
>>If, for some reason, the table is incorrect, we fallback to the "old
>>style" of mmconfig accesses, namely, we just assume the first entry in
>>the table is the one for us, and blindly use it.
> 
> 
> I think it would be better to set different bus->ops at probe
> time, not walk the table at runtime.

Makes sense to me...

	Jeff



