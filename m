Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266120AbUGTSe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbUGTSe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUGTSe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:34:28 -0400
Received: from thunderdog.allegientsystems.com ([208.251.178.238]:38294 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id S266115AbUGTSe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:34:26 -0400
Message-ID: <40FD65C2.7060408@optonline.net>
Date: Tue, 20 Jul 2004 14:34:42 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Pavel Machek <pavel@suse.cz>, linux-scsi@vger.kernel.org,
       random1@o-o.yi.org, Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
References: <40FD38A0.3000603@optonline.net> <20040720155928.GC10921@atrey.karlin.mff.cuni.cz> <40FD4CFA.6070603@optonline.net> <20040720174611.GI10921@atrey.karlin.mff.cuni.cz> <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston>
In-Reply-To: <1090347939.1993.7.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> 2 comments here:
> 
>  - The low level bus state (PCI D state for example) and the "linux"
> state should be 2 different entities.
> 
>  - For PCI, we probably want a hook so the arch can implement it's own
> version of pci_set_power_state() so that ACPI can use it's own trickery
> there.

Ok, so the takeaway message for driver writers is to treat the 
pci_dev->suspend() state parameter as an opaque value as far as 
possible, and just pass it on to the other layers

