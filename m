Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSEYVOk>; Sat, 25 May 2002 17:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSEYVOj>; Sat, 25 May 2002 17:14:39 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:23259 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S315379AbSEYVOi>; Sat, 25 May 2002 17:14:38 -0400
Message-Id: <200205252052.g4PKqs103253@colombe.home.perso>
Date: Sat, 25 May 2002 22:52:51 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: 2.5.18, pdflush 100% cpu utilization
To: DiegoCG@teleline.es
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, pavel@ucw.cz
In-Reply-To: <20020525212512.7a14d1d9.DiegoCG@teleline.es>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25 Mai, Diego Calleja a écrit :
> I've started my kernel 2.5.18.
> I was testing software suspend, but kernel said:
> 
> Kernel Panic: pse required
> 
> Software Suspend is not posible now.
> 
> 
> But i was able to continue, now I've pdflush running on PID 6,
> and it takes 100% of idle cpu, perhaps it has nothing to see with
> Software Suspend.....

It probably has. I don't know what pdflush is but it has to be suspended
using refrigerator(PF_IOTHREAD) because otherwise signals are not
treated by this task and not resetted by suspend (hence the task has
always signal pending after resume). 


--
Florent Chabaud         ___________________________________
SGDN/DCSSI/SDS/LTI     | florent.chabaud@polytechnique.org
http://www.ssi.gouv.fr | http://fchabaud.free.fr

