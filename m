Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266720AbSKOSxY>; Fri, 15 Nov 2002 13:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266721AbSKOSxY>; Fri, 15 Nov 2002 13:53:24 -0500
Received: from holomorphy.com ([66.224.33.161]:52688 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266720AbSKOSxX>;
	Fri, 15 Nov 2002 13:53:23 -0500
Date: Fri, 15 Nov 2002 10:56:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115185632.GY23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@suse.cz>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com> <20021115094827.GT23425@holomorphy.com> <20021115120233.GC25902@atrey.karlin.mff.cuni.cz> <1037366172.877.30.camel@zion> <20021115181247.GB8763@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115181247.GB8763@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 07:12:47PM +0100, Pavel Machek wrote:
> I just hope we'll never ever see 64GB i386 laptop...
> ... We'll probably have to write simpler equivalent of kmap_atomic for
> use in suspend_asm.S. It is not really *so* deep magic.

64GB raises deadly scalability (read as: box won't boot) issues with
boot-time memory reservations and other things. It's an open question
as to whether it will ever be made to work with mainline Linux, but one
I'd like to see answered "yes", if only because it is in some senses
the ultimate test of leanness: "If you are bloated, you will die."

But like I said, it's very unlikely any strong interest will ever
arise specifically in large-scale i386 checkpointing. Computational
workloads are very attached to having clean and efficient FPU's, which
i386 lacks. RISC etc. boxen with clean FPU's are more important for
that. OTOH if highmem works, why wouldn't bigger highmem boxen work? NFI

The general framework is all I have a direct interest in accommodating.
Aside from that I don't see a real need to make the low-level guts of
large-scale highmem systems support swsusp, though 1GB laptops make sense.

Thanks,
Bill
