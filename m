Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316241AbSEKRk2>; Sat, 11 May 2002 13:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316242AbSEKRk1>; Sat, 11 May 2002 13:40:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3601 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316241AbSEKRkZ>; Sat, 11 May 2002 13:40:25 -0400
Message-Id: <200205111737.g4BHbfY02535@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Steve Kieu <haiquy@yahoo.com>
Subject: Re: OOPS 2.4.19-pre7-ac4 (Was: strange things in kernel 2.4.19-pre7-ac4 + preempt patch)
Date: Sat, 11 May 2002 20:40:45 -0200
X-Mailer: KMail [version 1.3.2]
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020510235851.2870.qmail@web10401.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 May 2002 21:58, Steve Kieu wrote:
> > You need to decode oops. Use ksymoops.
>
> Ok I just compile ksymoops and here is the result

Look into it:

eax: 01000000   ebx: c545a000   ecx: c1112254   edx: 00000000
     ^^^^^^^^
[snip]
   0:   0f b6 50 1b               movzbl 0x1b(%eax),%edx   <=====

It seems like one bit error in eax. Maybe a NULL pointer got
corrupted and now movzbl stumbles over it.

Bad RAM? Consider memtest86 run overnight.
--
vda
