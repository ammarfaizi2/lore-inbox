Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSIDS7G>; Wed, 4 Sep 2002 14:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSIDS7G>; Wed, 4 Sep 2002 14:59:06 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:54192 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S314396AbSIDS7G>; Wed, 4 Sep 2002 14:59:06 -0400
Date: Wed, 4 Sep 2002 15:02:52 -0400 (EDT)
X-Sybari-Space: 00000000 00000000 00000000
From: Craig Arsenault <penguin@wombat.ca>
X-X-Sender: craig@tabmow.ca.nortel.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
In-Reply-To: <20020903202823.7152@192.168.4.1>
Message-ID: <Pine.LNX.4.44L.0209041453060.8359-100000@tabmow.ca.nortel.com>
References: <137715274.1031128333@[10.10.2.3]> <20020903202823.7152@192.168.4.1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Benjamin Herrenschmidt wrote:

> >I think you'll find yourself with no virtual address space left to
> >do vmalloc / fixmap / kmap type stuff. Or at least you would on i386,
> >I presume it's the same for ppc. Sounds like you may have left
> >yourself enough space for fixmap & kmap, but any calls to vmalloc
> >will probably fail ?
>
> Yes, same problem on PPC, you'll run out of virtual space quite
> quickly for vmalloc and ioremap. Stuff a video board with lots
> of VRAM or any PCI card exposing large MMIO regions into your
> machines and it will probably not even boot.
>
> Ben.
>

Ben,
  But doesn't using Matt's suggestion and moving both MAX_LOW_MEM and
changing KERNELBASE take care of this?  It's an embedded board with no
video, but it does have one PCI Mezzanine Card (PMC) on it.

Thanks.

--
Craig.
+------------------------------------------------------+
http://www.wombat.ca/rpmon.html    RP Music Monitor
http://www.washington.edu/pine/    Pine @ the U of Wash.
+-------------=*sent via Pine4.44*=--------------------+





