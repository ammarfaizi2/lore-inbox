Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317549AbSGET4n>; Fri, 5 Jul 2002 15:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSGET4m>; Fri, 5 Jul 2002 15:56:42 -0400
Received: from [213.4.129.129] ([213.4.129.129]:22266 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id <S317549AbSGET4l>;
	Fri, 5 Jul 2002 15:56:41 -0400
Date: Fri, 5 Jul 2002 22:00:20 +0200
From: Diego Calleja <diegocg@teleline.es>
To: "Pablo Fischer" <exilion@yifan.net>
Cc: paubert@iram.es, linux-kernel@vger.kernel.org
Subject: Re: StackPages errors (CALLTRACE)
Message-Id: <20020705220020.77ef07b8.diegocg@teleline.es>
In-Reply-To: <IDEJJDGBFBNEKLNKFPAEIEAHCDAA.exilion@yifan.net>
References: <3D2565E1.9050708@iram.es>
	<IDEJJDGBFBNEKLNKFPAEIEAHCDAA.exilion@yifan.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002 10:47:50 -0600
"Pablo Fischer" <exilion@yifan.net> escribió:

> >Because you are trying to execute a CMOV (0f 4x) instruction. The
> >module you are loading is compiled for PPro or higher.
> 
> 1) Whats that? the CMMOV?..
> 2) Could I fix it with the kernel?.. YES, how?. Please Im newbie and I
> would like to fix it.
> 3) If the fix its in the kernel, at what menu is it?.
It seems that you have to recompile the module for yor processor, or if
you want you can use the cmov emulation (and others) patch that has benn
submited a few days ago by Willy Tarreau.

> 
> Thanks.
> 
> 
> Pablo Fischer wrote:
> > Hi..
> >
> > I have MDK 8.2 and I get this error with: MDK 8.2, RH 7.2, RH 7.3..
> > but just with ONE COMPUTER, the other computers works fine.
> >
> > Ok.. I have a SpeedTouch, but to get it work I need to
> >
> > 1) modprobe the module
> > 2) Then.. call the speedmgmt (a binary)
> >
> > When I call the speedmgmt, I get:
> >
> >
> > Process speedmgmt (pid: 1748, stackpage=c1827000)
> > Stack: c0263a10 c1040000 c0263a4c 00000212 00000000 00000000
> > c4c10f60 c4d79c9e
> > c11e4e60 00000001 00000000 00000000 00000001 00000001 00000000
> > bffff752 c3430460 fffffdfd c398cde0 c0312ae0 c4d79f97 c3430460
> > bffff758 bffff758 Call Trace:
> >
> [af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pa
> c+-1548 448/96]
> [af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pa
> c+-7049 8/96]
> [af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pa
> c+-6973 7/96] [file_ioctl+340/368] [sys_ioctl+546/608]
> > Call Trace: [<c4c10f60>] [<c4d79c9e>] [<c4d79f97>] [<c01413b4>]
> > [<c01415f2>]
> > [system_call+51/64]
> > [<c0106f23>]
> > Code: 0f 44 c2 8b 57 04 0d 80 00 00 c0 89 42 18 8b 07 8b 57 04 8b
> >
> > Why I get that error?
> 
> Because you are trying to execute a CMOV (0f 4x) instruction. The
> module you are loading is compiled for PPro or higher.
> 
> >
> > I have a Compaq (AMD K6 - 500mhz) and 64 of Memory.
> 
> Hence no CMOV support (cat /proc/cpuinfo).
> 
> 	Gabriel.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
