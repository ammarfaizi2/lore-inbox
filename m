Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUGHJAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUGHJAs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUGHJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 05:00:48 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:9234 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S265422AbUGHJAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 05:00:47 -0400
Message-ID: <40ED0DDC.20602@hist.no>
Date: Thu, 08 Jul 2004 11:03:24 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Davide Rossetti <davide.rossetti@roma1.infn.it>,
       linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
References: <200407011215.59723.bjorn.helgaas@hp.com>	<20040701115339.A4265@unix-os.sc.intel.com>	<40EBED33.3050707@roma1.infn.it> <40EBF07B.8040003@hist.no> <52vfgzoisd.fsf@topspin.com>
In-Reply-To: <52vfgzoisd.fsf@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

>    Helge> Won't that put a bad load on the bus?  Someone else might
>    Helge> need it: * Another cpu in a smp system * Any device doing
>    Helge> bus-master transfers, even in a UP system
>
>Actually with MSI, the PCI device writes directly to a host address.
>In the proposed usage in this mail thread, the address is in host
>memory, so there's no bus load to poll the memory.  Presumably the
>memory will be pulled into cache for the duration of the poll loop, so
>there's not even any memory bandwidth consumed.  (Of course this only
>works on an architecture where PCI DMA is cache coherent)
>  
>
I see.  Still, this should only be used when we expect a
short wait only, similiar to situations when we use a spinlock.
Otherwise, the cpu could be put to better use by scheduling.

Helge Hafting
