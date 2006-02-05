Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWBEVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWBEVOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 16:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWBEVOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 16:14:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7555 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750727AbWBEVOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 16:14:18 -0500
Date: Sun, 5 Feb 2006 22:14:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Mark Lord <lkml@rtr.ca>, Ulrich Mueller <ulm@kph.uni-mainz.de>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
In-Reply-To: <1139153913.3131.42.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0602052212430.330@yvahk01.tjqt.qr>
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de>
  <Pine.LNX.4.63.0601100840400.9511@winds.org>  <20060110143931.GM3389@suse.de>
  <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> 
 <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca>  <43C403BA.1050106@pobox.com>
 <43C40803.2000106@rtr.ca>  <20060201222314.GA26081@MAIL.13thfloor.at> 
 <uhd7irpi7@a1i15.kph.uni-mainz.de>  <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
  <43E3DB99.9020604@rtr.ca>  <Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr>
 <1139153913.3131.42.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >
>> > Mmm.. bad idea.  As much as I'd like the default to be 3GB_OPT, that would
>> > be a big impact to userspace, and there's no point in breaking everyone's
>> > machines when advanced users can just reconfig/recompile to get what they want.
>> >
>> What userspace programs do depend on it?
>
>there is a lot of userspace that assumes they can do 2Gb or even close
>to 3Gb of memory allocations. Databases, java, basically anything with
>threads. Sure for most of these its a configuration option to reduce
>this, but that still doesn't mean it's a good idea to change from the
>existing behavior...
> 
Not to mention that these (almost(*)) fail anyway when you have less than 2 
GB of RAM.

(*) when finally writing to overcommitted memory

Yuck. That sounds like they depend on 64G/64bit allocations on 4G/32bit 
machines.


Jan Engelhardt
-- 
