Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSGJLKo>; Wed, 10 Jul 2002 07:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSGJLKn>; Wed, 10 Jul 2002 07:10:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:42484 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315529AbSGJLKk>;
	Wed, 10 Jul 2002 07:10:40 -0400
Message-ID: <3D2C16CD.6010409@gmx.net>
Date: Wed, 10 Jul 2002 13:13:17 +0200
From: Richard Ems <r.ems.home@gmx.net>
Reply-To: r.ems@gmx.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: e100_wait_exec_cmd && e100_wait_exec_simple: Wait failed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea, hi list!

Using SuSE's 8.0 default kernel (k_deflt-2.4.18-58):

Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.8.37
...
eth0 e100_wait_exec_cmd: Wait failed.
...
last message repeated 23 times
last message repeated 34 times
...



And using SuSE's k_deflt-2.4.18-186:
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 2.0.30-k1
...
eth0 e100_wait_exec_simple: Wait failed
...
last message repeated 8 times
last message repeated 25 times
...

I also had machine hangs with both drivers during heavy network load.
Could these hangup's be related to the driver's "error"? Or is it just a 
  "warning"?


from lspci -vvv:

...
02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet 
Controller (rev 01)
         Subsystem: Intel Corp.: Unknown device 3013
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 66 (2000ns min, 14000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 9
         Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at 3400 [size=64]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
...

Do you need any more information?
(P III 800 Mhz, 256 MB RAM)


Thanks for any help, Richard

P.S.: Please reply to r.ems@gmx.net, I'm not on lkml.


-- 
Richard Ems
... e-mail: r.ems@gmx.net
... Computer Science, University of Hamburg

Unix IS user friendly. It's just selective about who its friends are.

