Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbSI3NKj>; Mon, 30 Sep 2002 09:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262053AbSI3NKj>; Mon, 30 Sep 2002 09:10:39 -0400
Received: from theorie3.physik.uni-erlangen.de ([131.188.166.130]:13317 "EHLO
	theorie3.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262052AbSI3NKd>; Mon, 30 Sep 2002 09:10:33 -0400
Date: Mon, 30 Sep 2002 15:15:23 +0200
From: Norbert Nemec <nobbi@theorie3.physik.uni-erlangen.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serious Problems with PCI and SMP
Message-ID: <20020930131523.GA504@cognac.physik.uni-erlangen.de>
Reply-To: Norbert Nemec <nobbi@theorie3.physik.uni-erlangen.de>
References: <20020923155355.GA565@cognac.physik.uni-erlangen.de> <200209240828.g8O8Stp24897@Port.imtp.ilyichevsk.odessa.ua> <20020926090754.GA22448@cognac.physik.uni-erlangen.de> <200209261204.g8QC4vp04049@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209261204.g8QC4vp04049@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 02:59:14PM -0200, Denis Vlasenko wrote:
> Can you try to boot 486-optimized kernel?

Doesn't make any difference at all. :-(

> Can you remove one CPU and run SMP kernel on UP configuration?

Tried it, but the kernel immediately goes into an endless loop complaining about
an "apic error at cpu0" (no matter which CPU I remove), even before I get to
see anything interesting.

I'm really desperate: the only suggestion I did not try yet, was to test a 
2.5 kernel. Anyhow, even if I tried that (right now I'm still dreading the idea)
and even if it should work, I still wouldn't have any idea which detail of the
2.5 line should be backported to fix the bug. :-(

Maybe I should try the 2.2 line? I know that 2.2.13 is working (but I don't have
the .config files for those old, working kernels) and I know that 2.2.19 is broken.
Therefore I would need at least 2-3 compiles to know where the bug was introduced
and then I still wouldn't know what to do with that information.

Perhaps, I'll just wait for 2.6 to be published or for the 6 machines to get thrown
out some day. :-(

Ciao,
Nobbi

> On 26 September 2002 07:07, Norbert Nemec wrote:
> 
> BTW, for lkml readers: this was in original post:
> =================================================
> We have a number of machines with identical dual PPro 200 mainboards. They all
> run fine on 2.2.13 kernels. Trying 2.4.18,2.4.19,2.4.20-pre7 and even 2.2.19, 
> the same problem shows up:
> With SMP activated in the kernel, I get the boot-messages
> ---------
> PCI: PCI BIOS revision 2.10 entry at 0xfb0a0, last bus=0
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI BIOS passed nonexistent PCI bus 0!
> PCI BIOS passed nonexistent PCI bus 0!
> Limiting direct PCI/PCI transfers.
> ---------
> Afterwards, everything runs fine, except that PCI seems to be only half-way
> functional: network-cards don't give any error messages but behave just
> as if the cable was disconnected scsi-cards give strange errors (don't recall
> what exactly)
> With SMP disabled in the kernel, everything works just fine.
> ================================
> > > Post your .config and dmesg
> >
> > Here they are. In this version, CONFIG_PCI_GOBIOS=y is set. Switching to
> > CONFIG_PCI_GODIRECT=y or CONFIG_PCI_GOANY=y only adds the line
> > ----
> >  PCI: PCI BIOS revision 2.10 entry at 0xfb0a0, last bus=0
> > +PCI: Using configuration type 1
> >  PCI: Probing PCI hardware
> > ----
> > without any further difference.
> 
> > .config:
> > ---------------------------
> > #
> > # Processor type and features
> > #
> > CONFIG_M686=y
 

-- 
-- _____________________________________Norbert "Nobbi" Nemec
-- Hindenburgstr. 44   ...   D-91054 Erlangen   ...   Germany
-- eMail: <Norbert@Nemec-online.de>  Tel: +49-(0)-9131-204180
