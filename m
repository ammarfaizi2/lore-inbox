Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316955AbSEaTvT>; Fri, 31 May 2002 15:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSEaTvS>; Fri, 31 May 2002 15:51:18 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:44007 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S316955AbSEaTt6>; Fri, 31 May 2002 15:49:58 -0400
Message-Id: <200205302024.g4UKOQ002698@colombe.home.perso>
Date: Thu, 30 May 2002 22:24:23 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: [PATCH] swsusp in 2.4.19-pre8-ac5
To: pavel@ucw.cz
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020528211755.GC28189@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28 Mai, Pavel Machek a écrit :
>> > What's the point of all those PRINTS -> __prints changes? I do not
>> > like additional abstractions on the top of printk(). Are they really
>> > neccessary?
>> 
>> Actually I tried to make the process prettier using a dedicated console.
>> The PRINT are for debugging, _print for the dedicated console (can be
>> deactivated using SUSPEND_CONSOLE) and __print are always written
>> (errors messages). The PRINTS PRINTR macros were used to separate
>> suspend and resume machine. It's not necessary but isn't that nicer when
>> you suspend ?
> 
> Are not "Suspend : " and "Resume : " superfluous if you have dedicated
> console, anyway?
> 
> Why don't you use generic printk() for messages that are printed, always?

OK, ok, I'll get back to more classic printing ;-) I'll clean it this
week-end.

> 
>> What about the CONFIG_SMP restriction ? Is it still pertinent ?
> 
> Yes, I'm afraid. If someone wants to donate me SMP pentium, I might
> try to debug that ;-).

I have one but that's an operational server, no chance to have a test on
it :-(

--
Florent Chabaud
http://www.ssi.gouv.fr | http://fchabaud.free.fr

