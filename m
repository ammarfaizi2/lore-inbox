Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262143AbSIZC2P>; Wed, 25 Sep 2002 22:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262144AbSIZC2P>; Wed, 25 Sep 2002 22:28:15 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:37075 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262143AbSIZC2O>; Wed, 25 Sep 2002 22:28:14 -0400
Message-ID: <3D927278.6040205@snapgear.com>
Date: Thu, 26 Sep 2002 12:35:36 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
References: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Some more comments on the ethernet driver.

BTW, the original this came from is in the kernel tree
at arch/ppc/8xx_io/fec.c.

Matthew Wilcox wrote:
> Motorola 5272 ethernet driver:
> * In Config.in, let's conditionalise it on CONFIG_PPC or something
> * Can you use module_init() so it doesn't need an entry in Space.c?

I don't think this will work. This is not a device that can be
determined to be present like a PCI device. It is more like an
ISA device, it needs to be probed to figure out if it is really
there. I can't see any way not to use Space.c for non-auto-detectable
type devices... (Offcourse I could be missing something :-)


> * You're defining CONFIG_* variables in the .c file.  I don't know whether
>   this is something we're still trying to avoid doing ... Greg, you seem
>   to be CodingStyle enforcer, what's the word?

I missed this the first time through :-)
I am not sure what you mean, CodingStyle enforcer?
Can you elaborate for me?

Regards
Greg

------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

