Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWBDLGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWBDLGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWBDLGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:06:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63158 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932323AbWBDLGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:06:13 -0500
Date: Sat, 4 Feb 2006 12:06:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ulrich Mueller <ulm@kph.uni-mainz.de>
cc: Mark Lord <lkml@rtr.ca>, Herbert Poetzl <herbert@13thfloor.at>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
In-Reply-To: <17380.32919.359949.861318@a1i15.kph.uni-mainz.de>
Message-ID: <Pine.LNX.4.61.0602041205080.30014@yvahk01.tjqt.qr>
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de>
 <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de>
 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca>
 <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com>
 <43C40803.2000106@rtr.ca> <20060201222314.GA26081@MAIL.13thfloor.at>
 <uhd7irpi7@a1i15.kph.uni-mainz.de> <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
 <43E3DB99.9020604@rtr.ca> <17380.32919.359949.861318@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> Yes, that looks like a good idea.
>
>Couldn't this still be implemented entirely in Kconfig, without
>modifying page.h? Like in the following example:
>
>	[...]
>	config VMSPLIT_1G
>		bool "1G/3G user/kernel split"
>	config VMSPLIT_X
>		bool "Manual split"
>endchoice
>
>config PAGE_OFFSET
>	hex
>	range 0x40000000 0xC0000000    
>	prompt "Memory split address (must be aligned to 4096)" if VMSPLIT_X
>	[...]
>	default 0x40000000 if VMSPLIT_1G
>	default 0xC0000000
>

Well, if kconfig is able to do that, the better.



Jan Engelhardt
-- 
