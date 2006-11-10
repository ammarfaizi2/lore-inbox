Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932850AbWKJMK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbWKJMK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932851AbWKJMK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:10:59 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:2711 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932850AbWKJMK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:10:57 -0500
Date: Fri, 10 Nov 2006 13:10:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HZ: 300Hz support
In-Reply-To: <p73zmazitru.fsf@bingen.suse.de>
Message-ID: <Pine.LNX.4.61.0611101309080.6068@yvahk01.tjqt.qr>
References: <1163018557.23956.92.camel@localhost.localdomain>
 <p73zmazitru.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Fix two things. Firstly the unit is "Hz" not "HZ". Secondly it is useful
>> to have 300Hz support when doing multimedia work. 250 is fine for us in
>> Europe but the US frame rate is 30fps (29.99 blah for pedants). 300
>> gives us a tick divisible by both 25 and 30, and for interlace work 50
>> and 60. It's also giving similar performance to 250Hz.
>> 
>> I'd argue we should remove 250 and add 300, but that might be excess
>> disruption for now.
>
>If we go down that path I would like to have 256.

Before we have tons of choosable HZ possibilities, I prefer 
http://lkml.org/lkml/2006/6/18/111 where the user can input his desired 
value.

>Why? There are still lots of systems with broken Interrupt 0 routing
>and usually on those the RTC works just fine. But unfortunately RTC
>can be only programmed to power of two frequencies. 256 would fit.


	-`J'
-- 
