Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTAKNS0>; Sat, 11 Jan 2003 08:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267207AbTAKNS0>; Sat, 11 Jan 2003 08:18:26 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:30938 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267204AbTAKNSZ>;
	Sat, 11 Jan 2003 08:18:25 -0500
Date: Sat, 11 Jan 2003 14:23:24 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301111323.OAA26365@harpo.it.uu.se>
To: davidsen@tmr.com, rddunlap@osdl.org
Subject: Re: [BUG] 2.5.5x can't find my printer
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003 22:08:00 -0500 (EST), Bill Davidsen wrote:
>On Fri, 10 Jan 2003, Randy.Dunlap wrote:
>
>> On Fri, 10 Jan 2003, Bill Davidsen wrote:
>> 
>> | The 2.5.5x kernels can't find my printer. 2.4 kernels work fine. dmesg
>> | attached, I'll send config if anyone cares.
>> |
>> | Known problem, new problem, or just some config error? The modules load
>> | but don't find anything.
>> |
>> | lsmod:
>> | Module                  Size  Used by
>> | apm                    15140
>> | parport_pc             33320
>> | parport                34496
>> 
>> I'm having trouble seeing the trouble.
>
>The lpr/lpq programs tell me /dev/lp0 "no such device", and catting a file

parport printing works for me since 2.5.54 when a module param bug
that affected parport_pc was fixed. From your module listing above,
you seem to be missing the lp module. Ensure that CONFIG_PRINTER=m
and that your /etc/modprobe.conf contains 'alias char-major-6 lp'.

/Mikael
