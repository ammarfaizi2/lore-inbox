Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVC3TeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVC3TeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVC3TeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:34:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55727 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261872AbVC3Tdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:33:52 -0500
Message-ID: <424AFF0C.4010409@pobox.com>
Date: Wed, 30 Mar 2005 14:33:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Felix <gregfelixlkml@gmail.com>
CC: linux-kernel@vger.kernel.org, John Linville <linville@redhat.com>
Subject: Re: PROBLEM: ICH7 SATA drive not detected.
References: <e16ac85e050225153649939bed@mail.gmail.com>	 <421FBC0B.5070004@pobox.com> <e16ac85e05022517024beb5b38@mail.gmail.com>
In-Reply-To: <e16ac85e05022517024beb5b38@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Felix wrote:
> 00:1f.2 Class 0101: 8086:27c0 (prog-if 8f [Master SecP SecO PriP PriO])
>         Subsystem: 103c:3011
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> 
>>TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 
>         Latency: 0
>         Interrupt: pin B routed to IRQ 5
>         Region 0: I/O ports at 10d8 [size=8]
>         Region 1: I/O ports at 10f0 [size=4]
>         Region 2: I/O ports at 10e0 [size=8]
>         Region 3: I/O ports at 10f4 [size=4]
>         Region 4: I/O ports at 10b0 [size=16]
>         Region 5: Memory at e04c4400 (32-bit, non-prefetchable)
> [disabled] [size=1K]


I was hoping that we could detect when this PCI BAR is disabled, and 
base the logic on that.  But it appears that's not feasible for some BIOSen.

I suppose your patch is the best we can do.

	Jeff


