Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268696AbRG3Wfh>; Mon, 30 Jul 2001 18:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRG3Wf3>; Mon, 30 Jul 2001 18:35:29 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:32389 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S268675AbRG3WfI>;
	Mon, 30 Jul 2001 18:35:08 -0400
Message-ID: <3B65E2FD.48D52C@randomlogic.com>
Date: Mon, 30 Jul 2001 15:43:09 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD-760 AGP Support
In-Reply-To: <3B5CDFC1.4D954891@randomlogic.com> <3B5D9799.70807@valinux.com> <3B661C70.2010303@fugmann.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Anders Peter Fugmann wrote:
> 
> I do not know if you still want reports,
> but here is one anyway:-)
> 
> I've just bought an ASUS A7M266, and
> agpgart is working perfectly with my Gforce256, using the
> 'agp_try_unsupported=1' option
> 
> The kernel is 2.4.7-ac3.
> 
> Output from lspci -vvv is attached.
> 

Thanks.

I actually have my agpgart module recognizing the AMD-762 (AMD760 MP Northbridge). I added a #define for its ID (700c) right along with the existing Irongate
#define. I no longer have to use agp_try_unsupported in order to load the agpgart driver. I haven't yet gotten the PCI code to recognize the various IDs for the
Host Bridge, PCI Bridge, ISA and IDE.

It appears that the AMD760 MP chipset has the same register map as the previous set, with some additional registers enabled for new functionality (in the older
chip, these registers are listed as Reserved).

I've also found that I my ATA100 drive is operating as a straight 16-bit IDE drive. I can enable DMA, Ultra66, Write Cache, and 32-bit I/O using hdparm, but it
will be nice when all this can be set automagically by the system.

I also see in your attachment some IDs that I have not seen in the code nor in AMDs data/rev documents. The IDs for my chipset are 700c (Host) and 700d (PCI).

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
