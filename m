Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSEJANR>; Thu, 9 May 2002 20:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315288AbSEJANQ>; Thu, 9 May 2002 20:13:16 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:24073 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315260AbSEJANP>; Thu, 9 May 2002 20:13:15 -0400
Message-ID: <3CDB108F.8B092095@linux-m68k.org>
Date: Fri, 10 May 2002 02:13:03 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <Pine.LNX.4.21.0205062053050.32715-100000@serv> <E175wJO-0008Lz-00@starship> <3CDAFF7C.57A59FB8@linux-m68k.org> <E175xEi-0008Mi-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Daniel Phillips wrote:

> Show me where the 'physical' address is actually treated as a physical address.
> You can't, because it isn't.  The 'physical' address is merely a zero-based
> logical address, and the code *relies* on it being contiguous.

Most of the code doesn't care about physical addresses, because they
either work with virtual memory or with the page structure. Physical
addresses are only interesting to pass them to the hardware or to put
them into the page table.

> Your code is going to do __pa there, and you are going to go walking into places
> you don't expect.  Even you need my logical address space abstraction, or else you
> want to go making global changes to the common kernel code that just add cruft.

So far I've only seen a virtual address with some offset. You can maybe
move that offset around, but you can't remove it. In the end it's the
same.

> I enjoy the feeling of removing cruft, even when it's an uphill battle.

I'm happy to see patches.

bye, Roman
