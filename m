Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbTCFK0w>; Thu, 6 Mar 2003 05:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268001AbTCFK0w>; Thu, 6 Mar 2003 05:26:52 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:45574 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267980AbTCFK0v>; Thu, 6 Mar 2003 05:26:51 -0500
Message-Id: <200303061028.h26ASKu02263@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>,
       kasperd@daimi.au.dk (Kasper Dupont)
Subject: Re: emm386 hangs when booting from linux
Date: Thu, 6 Mar 2003 12:25:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: kernel@wildsau.idv.uni.linz.at, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org, herp@wildsau.idv.uni.linz.at
References: <200303021026.h22AQALn001315@wildsau.idv.uni.linz.at>
In-Reply-To: <200303021026.h22AQALn001315@wildsau.idv.uni.linz.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 March 2003 12:26, H.Rosmanith (Kernel Mailing List) wrote:
> hello again,
>
> I've still not found a solution, but at least I know what's happening
> when emm386 or similar crash the system. e.g., when starting
> "loadlin" (with no parameters!) the system will hang too. Reason is
> that loadlin will generate an int 0x13, which is the general

int 0x0d (13 decimal) is a protections fault.

In DOS, int 0x13 is a BIOS interrupt for low-level disk io.

> protection fault. I wonder *why*. Well, the int 0x13 handler I wrote
> just writes "int13" on top of the screen and does an iret, so the
> system will not crash anymore, but of course, the programs wont work.
> Another confusing thing I observed that even simply commands such as
> "copy <file1> <file2>" cause an int13!? and that DOS will become
> unusable quite soon (directories disappear and so on).

It is to be expected when you kill int 0x13 ;)

BTW, you may try linld:

http://port.imtp.ilyichevsk.odessa.ua/linux/vda/linld/

instead of loadlin. Its source is way smaller ;)
--
vda
