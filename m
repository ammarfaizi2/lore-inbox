Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbRGJX15>; Tue, 10 Jul 2001 19:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267172AbRGJX1r>; Tue, 10 Jul 2001 19:27:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22710 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267173AbRGJX1c>; Tue, 10 Jul 2001 19:27:32 -0400
Date: Tue, 10 Jul 2001 16:24:09 -0700
From: "Martin J. Bligh" <mbligh@sequent.com>
Reply-To: "Martin J. Bligh" <mbligh@sequent.com>
To: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@ns.caldera.de>,
        hpa@zytor.com
cc: linux-kernel@vger.kernel.org
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <2644803717.994782249@W-MBLIG.beaverton.ibm.com>
In-Reply-To: <85256A85.007E98E0.00@D51MTA03.pok.ibm.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For IA32/i386/x86:
>
> The Linus-kernel only supports a maximum of 15 Pentium IIIs
> due to APIC addressing (4 bits, with 0xf meaning "broadcast").
>
> Pentium 4 uses 0xff for broadcast, so lots more of them can
> be supported (when you can find a P-4 MP server).
>
> I have heard of some IBM/Sequent patches that modify the
> logical vs. physical APIC addressing scheme to make 16-way
> systems work.

I'll be posting the patches for this in about a week's time (just
going through a code review first). They should make up to a
32 way (8 quad) system work, though I've only actually tested
it up to 16 procs.

The main changes are to use "Logical clustered APIC addressing"
mode rather than flat logical, and to bootstrap via NMIs rather than
the usual INIT, INIT, STARTUP IPI sequence.

I can't keep up with the traffic on this list, but if you're interested,
bug me by email (mbligh@sequent.com / mbligh@us.ibm.com).

Martin.

PS. Takes 32 secs to compile the kernel, and that's on an older,
slower machine ;-)
