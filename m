Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313653AbSDPJUF>; Tue, 16 Apr 2002 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313654AbSDPJUE>; Tue, 16 Apr 2002 05:20:04 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:61193 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S313653AbSDPJUD>; Tue, 16 Apr 2002 05:20:03 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Linux 2.4.19-pre7
Date: 16 Apr 2002 08:57:44 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnabnps8.evm.kraxel@bytesex.org>
In-Reply-To: <Pine.LNX.4.21.0204160049130.18896-100000@freak.distro.conectiva>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1018947464 15351 127.0.0.1 (16 Apr 2002 08:57:44 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>  
>  Hi, 
>  
>  Here goes pre7.

This one breaks my serial ports.  Related config:

bogomips kraxel /work/bk/2.4/build# grep CONFIG_SERIAL .config
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
bogomips kraxel /work/bk/2.4/build# 

If I try to boot the box with serial console enabled
(console=ttyS0,115200n8 console=tty0) it hangs at boot time.  Without
the "console=ttyS0 ..." it boots just fine.  But I get no login prompt
at the serial line.  Syslog shows this:

Apr 16 10:43:21 bogomips agetty[979]: ttyS0: ioctl: Input/output error
Apr 16 10:43:31 bogomips agetty[1022]: ttyS0: ioctl: Input/output error
Apr 16 10:43:42 bogomips agetty[1023]: ttyS0: ioctl: Input/output error
Apr 16 10:43:52 bogomips agetty[1025]: ttyS0: ioctl: Input/output error
Apr 16 10:44:02 bogomips agetty[1030]: ttyS0: ioctl: Input/output error
Apr 16 10:44:12 bogomips agetty[1040]: ttyS0: ioctl: Input/output error
Apr 16 10:44:22 bogomips agetty[1044]: ttyS0: ioctl: Input/output error
Apr 16 10:44:32 bogomips agetty[1071]: ttyS0: ioctl: Input/output error
Apr 16 10:44:42 bogomips agetty[1111]: ttyS0: ioctl: Input/output error
Apr 16 10:44:52 bogomips init: Id "S0" respawning too fast: disabled for 5 minutes

-pre6 works just fine.

  Gerd

