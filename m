Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286206AbRLTH5a>; Thu, 20 Dec 2001 02:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbRLTH5V>; Thu, 20 Dec 2001 02:57:21 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:54022
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S286206AbRLTH5O>; Thu, 20 Dec 2001 02:57:14 -0500
Message-Id: <5.1.0.14.2.20011220024656.01e0cd20@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Dec 2001 02:51:42 -0500
To: "David S. Miller" <davem@redhat.com>
From: Stevie O <stevie@qrpff.net>
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Cc: Mika.Liljeberg@welho.com, kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
In-Reply-To: <20011219.234020.98861143.davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>
 <3C1FA558.E889A00D@welho.com>
 <20011218.122813.63057831.davem@redhat.com>
 <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:40 PM 12/19/2001 -0800, David S. Miller wrote:
>They should trap on it or handle it, silent "garbage" is really not
>nice behavior.

hah, I wish. The ARM7 has seven "exception" vectors -- that's it.

0x00 = RESET
0x04 = Undefined instruction
0x08 = Software interrupt (SWI instruction, used to escape the restricted 
USR cpu mode)
0x0C = Data abort (a very very very much lesser form of an access 
violation; accessing memory that's physically not there)
0x10 = Prefetch abort (a data abort that happens trying to read the next 
instruction)
0x14 = IRQ  <-  these two can't really even count as exceptions!
0x18 = FIQ  <-  which makes for five...
0x1C = <-
0x20 = <- Oh, yeah, and two "reserved" fields which aren't likely to ever 
be used.

Anyway, this is a bit off-topic now.


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

