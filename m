Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVDVIli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVDVIli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 04:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVDVIli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 04:41:38 -0400
Received: from redpine-92-161-hyd.redpinesignals.com ([203.196.161.92]:2780
	"EHLO redpinesignals.com") by vger.kernel.org with ESMTP
	id S261878AbVDVIlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 04:41:35 -0400
Message-ID: <4268BB87.1030902@redpinesignals.com>
Date: Fri, 22 Apr 2005 14:23:27 +0530
From: P Lavin <lavin.p@redpinesignals.com>
Reply-To: lavin.p@redpinesignals.com
Organization: www.redpinesignals.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel TI TLAN driver
References: <200504220800.j3M80GSL006528@kruuna.helsinki.fi>
In-Reply-To: <200504220800.j3M80GSL006528@kruuna.helsinki.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you send me the oops capture ??

Atro Tossavainen wrote:
> Hi,
> 
> I got my hands on a Texas Instruments ThunderLAN PCI 100 Mbit card (PCI
> ID 104c:0500), which is what SGI are supplying if you want a second NIC
> in your O2.  It appears that this card is not supported by the tlan
> driver in the Linux kernel (at least not in 2.4.29, which is what I am
> using on the machine I tried it on).  Patching the driver with the
> relevant PCI IDs allowed the detection of the card, as shown in dmesg:
> 
> ThunderLAN driver v1.15
> TLAN: eth0 irq=15, io=8400, Compaq NetFlex-3/E, Rev. 48
> TLAN: 1 device installed, PCI: 1  EISA: 0
> 
> and in "ifconfig eth0":
> 
> eth0	Link encap: Ethernet   HWaddr 00:00:58:01:55:53
> 
> (and the rest of the normal stuff)
> 
> but trying to configure the interface with an address and bringing
> it up caused a kernel oops.  (This is on Alpha.)
> 
> # ifconfig eth0 inet blah... up
> Unable to handle kernel paging request at virtual address 00000000093fcb04
> Segmentation fault
> 
> In dmesg, there is an
> 
> ifconfig(4218): Oops 0
> followed by a register dump, a trace, and some code.
> 
> Any ideas?
> 

-- 
P.Lavin
Software Engineer,
Redpine Signals ,Inc.
Hyderabad.
http://www.redpinesignals.com
