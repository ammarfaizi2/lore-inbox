Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSFTVkk>; Thu, 20 Jun 2002 17:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFTVki>; Thu, 20 Jun 2002 17:40:38 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:6550 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S315611AbSFTVkU>; Thu, 20 Jun 2002 17:40:20 -0400
Message-Id: <200206202138.g5KLcsO04303@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Dave Jones <davej@suse.de>
Subject: Re: Linux 2.5.23-dj2
Date: Thu, 20 Jun 2002 23:42:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <200206192133.g5JLXH814796@mail.science.uva.nl> <20020619234035.R29373@suse.de>
In-Reply-To: <20020619234035.R29373@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 23:40, Dave Jones wrote:
> On Wed, Jun 19, 2002 at 11:36:20PM +0200, Rudmer van Dijk wrote:
>  > Ok I can run -dj2, but I cannot use X 8-( although this time no BUG or
>  > panic.
>
> 1, any agpgart related messages in the logs/dmesg ?
> 2. Can you disable agpgart, and try again. I'm fairly certain this
>    is the cause, but just in case..

just checked 2 but no improvement, also checked without drm again no 
solution...

otherwise the system seems stable (also when running X) but I also saw the 
'spurious 8259A interrupt: IRQ7.' message after a couple of minutes. I know 
that this has got something to do with local apic, but nothing more...

this is from dmesg:
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
<snip>
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1128.5606 MHz.
..... host bus clock speed is 265.5435 MHz.
cpu: 0, clocks: 2655435, slice: 1327717
CPU0<T0:2655424,T1:1327696,D:11,S:1327717,C:2655435>

(interresting: this differs from 2.4.19-pre10-ac2... but there I get the same 
spurious interrupt)

UP system, athlon 1133, mobo: ecs k7s5am

gandalf:~ # lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 
(rev
01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:0b.0 Ethernet controller: Winbond Electronics Corp W89C940
00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:11.0 Ethernet controller: Winbond Electronics Corp W89C940
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)


	Rudmer
