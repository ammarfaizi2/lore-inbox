Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSGJLUn>; Wed, 10 Jul 2002 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSGJLUm>; Wed, 10 Jul 2002 07:20:42 -0400
Received: from [195.223.140.120] ([195.223.140.120]:16691 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315607AbSGJLUk>; Wed, 10 Jul 2002 07:20:40 -0400
Date: Wed, 10 Jul 2002 13:24:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: r.ems@gmx.net
Cc: linux-kernel@vger.kernel.org, linux.nics@intel.com
Subject: Re: e100_wait_exec_cmd && e100_wait_exec_simple: Wait failed
Message-ID: <20020710112425.GV8878@dualathlon.random>
References: <3D2C16CD.6010409@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2C16CD.6010409@gmx.net>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 01:13:17PM +0200, Richard Ems wrote:
> Hi Andrea, hi list!

Hello Richard,

> 
> Using SuSE's 8.0 default kernel (k_deflt-2.4.18-58):
> 
> Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.8.37
> ...
> eth0 e100_wait_exec_cmd: Wait failed.
> ...
> last message repeated 23 times
> last message repeated 34 times
> ...
> 
> 
> 
> And using SuSE's k_deflt-2.4.18-186:
> Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 2.0.30-k1
> ...
> eth0 e100_wait_exec_simple: Wait failed
> ...
> last message repeated 8 times
> last message repeated 25 times
> ...
> 
> I also had machine hangs with both drivers during heavy network load.
> Could these hangup's be related to the driver's "error"? Or is it just a 
>  "warning"?
> 
> 
> from lspci -vvv:
> 
> ...
> 02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet 
> Controller (rev 01)
>         Subsystem: Intel Corp.: Unknown device 3013
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66 (2000ns min, 14000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 9
>         Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
>         Region 1: I/O ports at 3400 [size=64]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> ...
> 
> Do you need any more information?
> (P III 800 Mhz, 256 MB RAM)
> 
> 
> Thanks for any help, Richard
> 
> P.S.: Please reply to r.ems@gmx.net, I'm not on lkml.

I'm probably not the best person to handle these reports. You should
report to linux.nics@intel.com (CC'ed), they are the authors of the e100
driver.

Until a fix is available I would suggest to try to use the original
linux eepro100 driver and see if the machine hangs goes away that way.

thanks,

Andrea
