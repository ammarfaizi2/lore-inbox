Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSGEJWU>; Fri, 5 Jul 2002 05:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSGEJWT>; Fri, 5 Jul 2002 05:22:19 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:29129 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S316182AbSGEJWS>;
	Fri, 5 Jul 2002 05:22:18 -0400
Message-ID: <3D2565E1.9050708@iram.es>
Date: Fri, 05 Jul 2002 11:24:49 +0200
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020531
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pablo Fischer <exilion@yifan.net>, linux-kernel@vger.kernel.org
Subject: Re: StackPages errors (CALLTRACE)
References: <1025849217.2921.34.camel@pablo.fischer.com.mx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Fischer wrote:
> Hi..
> 
> I have MDK 8.2 and I get this error with: MDK 8.2, RH 7.2, RH 7.3.. but
> just with ONE COMPUTER, the other computers works fine.
> 
> Ok.. I have a SpeedTouch, but to get it work I need to
> 
> 1) modprobe the module
> 2) Then.. call the speedmgmt (a binary)
> 
> When I call the speedmgmt, I get:
> 
> 
> Process speedmgmt (pid: 1748, stackpage=c1827000)
> Stack: c0263a10 c1040000 c0263a4c 00000212 00000000 00000000 c4c10f60
> c4d79c9e
> c11e4e60 00000001 00000000 00000000 00000001 00000001 00000000 bffff752
> c3430460 fffffdfd c398cde0 c0312ae0 c4d79f97 c3430460 bffff758 bffff758
> Call Trace:
> [af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-1548448/96] [af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-70498/96] [af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-69737/96] [file_ioctl+340/368] [sys_ioctl+546/608]
> Call Trace: [<c4c10f60>] [<c4d79c9e>] [<c4d79f97>] [<c01413b4>]
> [<c01415f2>]
> [system_call+51/64]
> [<c0106f23>]
> Code: 0f 44 c2 8b 57 04 0d 80 00 00 c0 89 42 18 8b 07 8b 57 04 8b
> 
> Why I get that error?

Because you are trying to execute a CMOV (0f 4x) instruction. The module
you are loading is compiled for PPro or higher.

> 
> I have a Compaq (AMD K6 - 500mhz) and 64 of Memory.

Hence no CMOV support (cat /proc/cpuinfo).

	Gabriel.


