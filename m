Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289911AbSAWRKj>; Wed, 23 Jan 2002 12:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289916AbSAWRKa>; Wed, 23 Jan 2002 12:10:30 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:46853 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S289911AbSAWRKP>;
	Wed, 23 Jan 2002 12:10:15 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201231709.g0NH9em421753@saturn.cs.uml.edu>
Subject: Re: Athlon/AGP issue update
To: davem@redhat.com (David S. Miller)
Date: Wed, 23 Jan 2002 12:09:40 -0500 (EST)
Cc: wli@holomorphy.com, vda@port.imtp.ilyichevsk.odessa.ua,
        linux-kernel@vger.kernel.org, andrea@suse.de, alan@redhat.com,
        akpm@zip.com.au, vherva@niksula.hut.fi
In-Reply-To: <20020123.034755.104030619.davem@redhat.com> from "David S. Miller" at Jan 23, 2002 03:47:55 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
>    From: William Lee Irwin III <wli@holomorphy.com>

>> as there is essentially no infrastructure
>> for controlling the cacheable attribute(s) of user mappings now as
>> I understand it.
>   
> Yes there most certainly are.  The driver's MMAP method can fully edit
> the page protection attributes for that mmap area as it pleases.

That doesn't help for MAP_ANON pages.

That doesn't help when there are multiple useful cache settings.
It's not sane for every arch-independent driver to implement an
ioctl() or alternate devices. For PPC, you'd need 12 devices.

To a limited extent, the PPC can handle conflicting settings in
a useful manner. Not all 12 settings at once, but more than one.
BTW, reverse mappings could be useful for conflicting settings.

It is perfectly reasonable for a user to want non-coherent
memory and memory with odd caching behavior. It is not entirely
unreasonable to want large regions of memory to be BAT-mapped
for somewhat dedicated (Beowulf compute cluster) systems.


