Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRDCRTu>; Tue, 3 Apr 2001 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132373AbRDCRTk>; Tue, 3 Apr 2001 13:19:40 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:46555 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132372AbRDCRTW>; Tue, 3 Apr 2001 13:19:22 -0400
Message-ID: <3AC9A367.2A1F6F7A@uow.edu.au>
Date: Tue, 03 Apr 2001 03:18:15 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: German Gomez Garcia <german@piraos.com>
CC: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange problems with 2.4.3.
In-Reply-To: <Pine.LNX.4.21.0104021133500.450-100000@hal9000.piraos.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

German Gomez Garcia wrote:
> 
> ...
> eth1: transmit timed out, tx_status 82 status e605.
> diagnostics: net 04d8 media 8880 dma 000000ba.
> eth1: Interrupt posted but not delivered IRQ blocked by another device?

If this happens immediately after startup then possibly the
PCI initialisation has got itself broken.

If it happens after some time of correct operation then it's
just the usual APIC bug.  Add the `noapic' option to your
LILO boot command line or use a -ac kernel.

Which is it?

> 
>         And finally after some time up the system just hangs up, the time
> is between 5 and 12 hours. No console activity, no SysRQ, nothing on the
> logs, just hanged up.

Dunno about this.  It may be related, maybe not.

-
