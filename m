Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWBIQHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWBIQHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWBIQHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:07:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:6620 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932336AbWBIQHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:07:46 -0500
Date: Thu, 9 Feb 2006 17:06:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Ulrich Mueller <ulm@kph.uni-mainz.de>, Bernd Petrovitsch <bernd@firmix.at>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: RFC: add an ADVANCED_USER option
In-Reply-To: <20060207144236.GH5937@stusta.de>
Message-ID: <Pine.LNX.4.61.0602091705490.30108@yvahk01.tjqt.qr>
References: <43E3DB99.9020604@rtr.ca> <Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr>
 <1139153913.3131.42.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0602052212430.330@yvahk01.tjqt.qr>
 <1139174355.3131.50.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0602061554550.31522@yvahk01.tjqt.qr> <20060207004147.GA21620@MAIL.13thfloor.at>
 <1139305085.13091.17.camel@tara.firmix.at> <20060207121955.GD5937@stusta.de>
 <17384.43328.181493.272871@a1i15.kph.uni-mainz.de> <20060207144236.GH5937@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > config ADVANCED_USER
>> > 	bool "ask questions that require a deeper knowledge of the kernel"
>> 
>> > config EXPERIMENTAL
>> > 	bool "Prompt for development and/or incomplete code/drivers"
>> > 	depends on ADVANCED_USER
>> 
>> Shouldn't this be the other way around, i.e. ADVANCED_USER depending
>> on EXPERIMENTAL?
>
>No, if there's a dependency between the two, then in this direction.

ACK. Advanced code is not necessarily "incomplete code/drivers".

>> If you implement it as above, people will set ADVANCED_USER to "n" in
>> oldconfig and then be surprised that all experimental drivers are
>> gone.
>
>What about no dependency between ADVANCED_USER and EXPERIMENTAL?
>
Sounds good.


Jan Engelhardt
-- 
