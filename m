Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSI0ECN>; Fri, 27 Sep 2002 00:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbSI0ECN>; Fri, 27 Sep 2002 00:02:13 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:35300 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261624AbSI0ECM>; Fri, 27 Sep 2002 00:02:12 -0400
Message-ID: <3D93D9F7.2040601@snapgear.com>
Date: Fri, 27 Sep 2002 14:09:27 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
References: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk> <3D927278.6040205@snapgear.com> <20020926155618.D5179@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Matthew Wilcox wrote:
> On Thu, Sep 26, 2002 at 12:35:36PM +1000, Greg Ungerer wrote:
> 
>>BTW, the original this came from is in the kernel tree
>>at arch/ppc/8xx_io/fec.c. 
> 
> Heh.. looks like that driver should move to drivers/net too.

Indeed. Drivers in the arch directories is just wrong.


>>I don't think this will work. This is not a device that can be
>>determined to be present like a PCI device. It is more like an
>>ISA device, it needs to be probed to figure out if it is really
>>there. I can't see any way not to use Space.c for non-auto-detectable
>>type devices... (Offcourse I could be missing something :-) 
> 
> Sure you can use module_init for non-pci devices... look at 3c501.c and
> 3c59x.c for examples.

OK, that is what I needed :-)
The trick is to define locally your net_device structure.
OK, all fixed up now, no Space.c entries required.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

