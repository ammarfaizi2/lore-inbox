Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbRHFDuB>; Sun, 5 Aug 2001 23:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRHFDtl>; Sun, 5 Aug 2001 23:49:41 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:30980
	"HELO marcus.pants.nu") by vger.kernel.org with SMTP
	id <S266580AbRHFDti>; Sun, 5 Aug 2001 23:49:38 -0400
Subject: Re: PPC? (Was: Re: [RFC] /proc/ksyms change for IA64)
To: kaos@ocs.com.au (Keith Owens)
Date: Sun, 5 Aug 2001 20:05:20 -0700 (PDT)
Cc: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <29464.997040507@ocs3.ocs-net> from "Keith Owens" at Aug 06, 2001 05:41:47 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010806030520.153282B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On 05 Aug 2001 11:29:00 +0200,
> kaih@khms.westfalen.de (Kai Henningsen) wrote:
> >kaos@ocs.com.au (Keith Owens)  wrote on 02.08.01 in <22165.996722560@kao2.melbourne.sgi.com>:
> >
> >> The IA64 use of descriptors for function pointers has bitten ksymoops.
> >> For those not familiar with IA64, &func points to a descriptor
> >> containing { &code, &data_context }.
> >
> >That sounds suspiciously like what I remember from PPC. How is this solved
> >on the PPC side?
> 
> Best guess, without access to a PPC box, is that it is not solved.  Any
> arch where function pointers go via a descriptor will have this
> problem.
> 
> PPC users, does /proc/ksyms contain the address of the function code or
> the address of a descriptor which points to the code?  It is easy to
> tell, if function entries in /proc/ksyms are close together (8-128
> bytes apart) and do not match the addresses in System.map then PPC has
> the same problem as IA64.  If this is true, what is the layout of a PPC
> function descriptor so I can handle that case as well?

This is what the MacOS does on ppc, but it's specific to the MacOS, and
is part of the way the MacOS seamlessly integrates 68k code and ppc code
so that they didn't have to have both 68k and ppc versions of all the
system calls. This was basically a trick to pack in extra information
along with a function pointer to tell the Mixed Mode Manager if it needed
to run the 68k emulator and also how to setup the right context. I'm
pretty sure that Linux just does the normal address for function pointers
just like most other architectures.

	Brad Boyer
	flar@allandria.com


