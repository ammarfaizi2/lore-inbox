Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317495AbSGEQCK>; Fri, 5 Jul 2002 12:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSGEQCJ>; Fri, 5 Jul 2002 12:02:09 -0400
Received: from ns1.yifansoft.com ([64.61.26.50]:7437 "HELO mail.yifansoft.com")
	by vger.kernel.org with SMTP id <S317495AbSGEQCH>;
	Fri, 5 Jul 2002 12:02:07 -0400
From: "Pablo Fischer" <exilion@yifan.net>
To: "Mark Hahn" <hahn@physics.mcmaster.ca>,
       "Pablo Fischer" <exilion@yifan.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: StackPages errors (CALLTRACE)
Date: Fri, 5 Jul 2002 11:06:20 -0600
Message-ID: <IDEJJDGBFBNEKLNKFPAEEEAJCDAA.exilion@yifan.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0207051154160.14284-100000@coffee.psychology.mcmaster.ca>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ohh.. ok..

So.

1) Its more a HW problem? (a PRocessor problem?) I have AMD K6

2) So.. you are telling me that I cant solve it? :(, only if I change the
proccessor to a Pentium?..

Paul Fischer.


>>>

> >Because you are trying to execute a CMOV (0f 4x) instruction. The module
> >you are loading is compiled for PPro or higher.
>
> 1) Whats that? the CMMOV?..

it's an instruction, "conditional move", which appeared first
in the Intel P6, and is not supported by your processor.

> 2) Could I fix it with the kernel?.. YES, how?. Please Im newbie and I
would
> like to fix it.

no, it's not a kernel issue.  the problem is the binary module
you are trying to use: whoever compiled it chose compiler flags
that make it impossible to use on your CPU (any CPU which lacks
cmov, such as all pentium's (P5), K6, etc.  athlons, though,
have cmov.)

> 3) If the fix its in the kernel, at what menu is it?.

none.  strictly a problem with the module.


>
> Thanks.
>
>
> Pablo Fischer wrote:
> > Hi..
> >
> > I have MDK 8.2 and I get this error with: MDK 8.2, RH 7.2, RH 7.3.. but
> > just with ONE COMPUTER, the other computers works fine.
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
> > Stack: c0263a10 c1040000 c0263a4c 00000212 00000000 00000000 c4c10f60
> > c4d79c9e
> > c11e4e60 00000001 00000000 00000000 00000001 00000001 00000000 bffff752
> > c3430460 fffffdfd c398cde0 c0312ae0 c4d79f97 c3430460 bffff758 bffff758
> > Call Trace:
> >
>
[af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-1548
> 448/96]
>
[af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-7049
> 8/96]
>
[af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-6973
> 7/96] [file_ioctl+340/368] [sys_ioctl+546/608]
> > Call Trace: [<c4c10f60>] [<c4d79c9e>] [<c4d79f97>] [<c01413b4>]
> > [<c01415f2>]
> > [system_call+51/64]
> > [<c0106f23>]
> > Code: 0f 44 c2 8b 57 04 0d 80 00 00 c0 89 42 18 8b 07 8b 57 04 8b
> >
> > Why I get that error?
>
> Because you are trying to execute a CMOV (0f 4x) instruction. The module
> you are loading is compiled for PPro or higher.
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
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
operator may differ from spokesperson.	            hahn@mcmaster.ca
                                              http://hahn.mcmaster.ca/~hahn


