Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153994AbQCaXJP>; Fri, 31 Mar 2000 18:09:15 -0500
Received: by vger.rutgers.edu id <S153886AbQCaXI1>; Fri, 31 Mar 2000 18:08:27 -0500
Received: from mail.webmaster.com ([209.133.28.73]:51067 "EHLO shell.webmaster.com") by vger.rutgers.edu with ESMTP id <S153911AbQCaXAy>; Fri, 31 Mar 2000 18:00:54 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <root@chaos.analogic.com>
Cc: "'LINUX-KERNEL mailing list'" <linux-kernel@vger.rutgers.edu>
Subject: RE: Time synchronization between two LINUX computer
Date: Fri, 31 Mar 2000 15:05:04 -0800
Message-ID: <000901bf9b65$8c85bbc0$0100000a@youwant.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
In-Reply-To: <Pine.LNX.3.95.1000331141023.2256A-100000@chaos.analogic.com>
Importance: Normal
Sender: owner-linux-kernel@vger.rutgers.edu


> I would think so since, for instance, file date/times don't have much
> resolution. However, the original inquiry implied microsecond resolution
> time-difference between machines.

	On my home LAN, I have quite a few machines running NTP. Here's what a
'xntpdc -p' looks like on one of 'em:

       st poll reach  delay   offset    disp
=======================================================================
+ A     2 1024  377 0.00050 -0.004370 0.00218
= B     1  256  377 0.00020  0.000176 0.00006
- C     2   64   36 0.00861  0.000055 1.93866
* D     1  128  377 0.00018  0.000174 0.00005
- E     2   64   16 0.00032  0.001583 1.93872
- F     2  256  377 0.00844  0.000222 0.00333
- G     2  512  367 0.00069 -0.000021 0.06850
+ H     2  256  377 0.00334  0.000112 0.00545
- I     2  512  377 -0.0150 -0.008419 0.01424

	A is an Irix machine on my LAN. B is a local stratum one public time
server. C is a customer's machine on a remote WAN. D is a local stratum one
public time server. E is a FreeBSD 3 box on my LAN (SMP. FreeBSD SMP doesn't
keep very good time). F is a customer's machine on a remote WAN. G is my
UltraSparc. H is my local Cisco router. I is a Windows 98 box. The machine I
ran this on is a Linux box.

	You'll notice that <1ms resolution is possible between Linux and FreeBSD UP
machines with recent kernels.

	DS


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
