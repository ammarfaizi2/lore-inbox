Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310912AbSCSLrO>; Tue, 19 Mar 2002 06:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310864AbSCSLrG>; Tue, 19 Mar 2002 06:47:06 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:34728 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S310829AbSCSLrD>; Tue, 19 Mar 2002 06:47:03 -0500
Message-ID: <3C972505.4080001@antefacto.com>
Date: Tue, 19 Mar 2002 11:46:13 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: S W <egberts@yahoo.com>
CC: linux-kernel@vger.kernel.org, davej@suse.de, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.19-pre2 Cyrix III SEGFAULT (Cyrix II redux?)
In-Reply-To: <20020316180705.34916.qmail@web10506.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're noticing weirdness here also.
Certain apps are SEGFAULTing. Some apps much
more than others. An important point is that
the apps SEGFAULTed in the exact same place
each time. Doing a trace of the core didn't
show anything weird being executed, it just
SEGFAULTed. Does this suggest a cache issue?
A power cycle changed things (made the faults
more/less frequent). The particular app we were
having trouble with was snmpd (net-snmp). Also
much less frequent was vim and bash. When these
crashed, it was also in the same place. An
important note is that snmpd would crash in
exactly the same place across power cycles.
Recompiling a later version of snmpd "fixed"
the problem. I.E. SEGFAULTs are now very infrequent.
We saved the particular snmpd binary that was
causing trouble, for testing.

We tested with Samuel II & Ezra & Celeron CPUs on
both Advantech PCM9576 & Ibase M700 motherboards.
Celeron was OK, Samuel II was OK, ezra caused segfaults.

We also passed memtest86 (RAM is also ECC) and
multiple kernel compiles worked OK also.

Kernel 2.4.16
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
glibc 2.2.4

Padraig.

S W wrote:
> In compiling the kernel, I've been experiencing the
> same gcc-2.96 (and gcc-3.0+) SEGFAULT again on Cyrix
> III GigaPro (733Mhz, Samuel II core chipset).
> 
> But I recalled Linux 2.2 having a bug fix for broken
> L2 cache in Cyrix II.  So, it got me thinking again...
> (did Cyrix fix this L2 cache in certain subsequential
> core?)
> 
> Does anyone recall where exactly are the Cyrix II L2
> cache bug fix in the kernelso that I can experiement
> them toward the Cyrix III?
> 
> Assuming no else sees VM bugs, I'll assume that this
> is Cyrix-specific.  I've seen various VM BUGs for each
> patch releases since 2.4.17 particularly when
> compiling.
> 
> MOBO DETAILS:
> Soyo 7VEM motherboard (686A PL133, despite having an
> ALL VIA-chipsets (Cyrix III-733Mhz, VIA-VT82C596A
> multifunctional audio/AGPvideo/modem, Rhine Ethernet,
> Trident APG), no drivers are loaded into the kernel
> except for EXT2, Trident Video (no framebuffer
> support) and IDE (via82cxxx.c).  BARE KERNEL.  (BTW,
> it was a $250 Fry's special running a barebone
> multimedia Linux, so no snickering please.).
> Passed memtest86.

