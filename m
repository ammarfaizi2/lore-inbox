Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293288AbSCOV3N>; Fri, 15 Mar 2002 16:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293306AbSCOV3D>; Fri, 15 Mar 2002 16:29:03 -0500
Received: from users.ccur.com ([208.248.32.211]:5003 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293289AbSCOV2s>;
	Fri, 15 Mar 2002 16:28:48 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200203152126.VAA27719@rudolph.ccur.com>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 15 Mar 2002 16:26:59 -0500 (EST)
Cc: joe.korty@ccur.com, marcelo@conectiva.com.br, mingo@elte.hu,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <E16lzQW-0004j4-00@the-village.bc.nu> from "Alan Cox" at Mar 15, 2002 09:39:52 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> - ksoftirqd() - change daemon nice(2) value from 19 to -19.
>> 
>>     SoftIRQ servicing was less important than the most lowly of batch
>>     tasks.  This patch makes it more important than all but the realtime
>>     tasks.
> 
> Bad idea - the right fix to this is to stop using ksoftirqd so readily
> under load. If it bales after 20 iterations life is good. As shipped life
> is bad.
> 
> Once ksoftirq triggers its because we are seriously overloaded (or without
> fixing its use slightly randomly). In that case we want other stuff to
> do work before we potentially unleash the next flood.

That certainly makes sense.  Thanks.
Joe
