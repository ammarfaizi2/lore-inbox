Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSIDS3K>; Wed, 4 Sep 2002 14:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSIDS3K>; Wed, 4 Sep 2002 14:29:10 -0400
Received: from m86.net195-132-236.noos.fr ([195.132.236.86]:36481 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S313898AbSIDS3J>;
	Wed, 4 Sep 2002 14:29:09 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Tom Rini <trini@kernel.crashing.org>,
       Craig Arsenault <penguin@wombat.ca>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
Date: Tue, 3 Sep 2002 22:28:23 +0200
Message-Id: <20020903202823.7152@192.168.4.1>
In-Reply-To: <137715274.1031128333@[10.10.2.3]>
References: <137715274.1031128333@[10.10.2.3]>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I think you'll find yourself with no virtual address space left to
>do vmalloc / fixmap / kmap type stuff. Or at least you would on i386,
>I presume it's the same for ppc. Sounds like you may have left
>yourself enough space for fixmap & kmap, but any calls to vmalloc
>will probably fail ?

Yes, same problem on PPC, you'll run out of virtual space quite
quickly for vmalloc and ioremap. Stuff a video board with lots
of VRAM or any PCI card exposing large MMIO regions into your
machines and it will probably not even boot.

Ben.


