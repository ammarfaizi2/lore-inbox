Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269257AbRHQArP>; Thu, 16 Aug 2001 20:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269254AbRHQArF>; Thu, 16 Aug 2001 20:47:05 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:25872 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S269212AbRHQAqx>; Thu, 16 Aug 2001 20:46:53 -0400
Message-Id: <200108170047.f7H0l4I83032@aslan.scsiguy.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver that does not need db library? 
In-Reply-To: Your message of "Thu, 16 Aug 2001 09:44:26 PDT."
             <200108161644.JAA02547@adam.yggdrasil.com> 
Date: Thu, 16 Aug 2001 18:47:04 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>	Currently, building Justin Gibbs's otherwise excellent
>aic7xxx driver requires the Berkeley DB library, because the
>aic7xxx assembler that is used in the build process uses db
>basically just to implement associative arrays in memory.

You don't need to use the assembler.  Compiled firmware is
provided in every distrubution I've made, including the one
in the 2.4.9 kernel.  The default is to *not* build the
firmware.  Just make sure that you don't have this option
inadvertantly turned on in your config and you should be happy.

A wise CS proff once said, "Smart programmers are lazy.  They
re-use stuff rather than write it over and over again."  In this
case, I was able to implement my symbol table in all of 5 mintues
without the need to debug the code that implements its core.  It
may seem like overkill, but it allowed me to focus on the important
things, like making the assembler useful.  The assember dates from
1995, which might explain why it uses the dbv1 interface.

"If it ain't broke, don't fix it."

--
Justin
