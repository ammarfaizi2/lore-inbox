Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263909AbRFIXAJ>; Sat, 9 Jun 2001 19:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264494AbRFIW77>; Sat, 9 Jun 2001 18:59:59 -0400
Received: from imladris.infradead.org ([194.205.184.45]:63760 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S263909AbRFIW7t>;
	Sat, 9 Jun 2001 18:59:49 -0400
Date: Sat, 9 Jun 2001 23:58:55 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: "David S. Miller" <davem@redhat.com>
cc: Adrian Cox <adrian@humboldt.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable endianess problem in TLAN driver
In-Reply-To: <15138.42357.146305.892652@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0106092356360.23184-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

On Sat, 9 Jun 2001, David S. Miller wrote:

 > Adrian Cox writes:

 >>> +#if defined(__powerpc__)
 >>> +#define inw(addr)                      le32_to_cpu(inw(addr))
 >>> +#define inl(addr)                      le32_to_cpu(inl(addr))
 >>> +#define outw(val, addr)                outw(cpu_to_le32(val), addr)
 >>> +#define outl(val, addr)                outl(cpu_to_le32(val), addr)
 >>> +#endif

 >> On ppc the inw, inl, outw, and outl functions already byteswap,
 >> so by adding the extra byteswap you're now passing unswapped
 >> data to the chip.

 > Yes, and this is true for every architecture.

 > All of {in,out}{b,w,l}() and {read/write}{b,w,l}() swap to/from
 > bus endianness for you.

Even if that wasn't true, aren't the above all self-recursive
definitions that would prevent anything calling them from compiling?

Best wishes from Riley.

