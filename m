Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSK0Vmi>; Wed, 27 Nov 2002 16:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSK0Vmi>; Wed, 27 Nov 2002 16:42:38 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:38820 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S264872AbSK0Vmg>; Wed, 27 Nov 2002 16:42:36 -0500
Date: Wed, 27 Nov 2002 13:53:58 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Module alias and table support
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Message-id: <3DE53EF6.4080303@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200211272054.MAA07617@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>This is going to end up rewriting every MODULE_DEVICE_TABLE in the
>>kernel, as well as hotplug and that depmod functionality, before
>>hotplugging handles module loading again, isn't it? Somehow I'd
>>rather not see us change so many things while we're "stabilizing".
> 
> [...]
> 
> 	I already explained that this can be done by automated means,
> (and it appears that Rusty Russell has already written much of the code
> to do it):
> 
> | Initially, I would run a
> | hacked version of depmod to output appropriate string-based device_id
> | table declarations and append them to the corresponding .c files [...]

Hmm, "would" doesn't sound like "it's working now" ... and the latest
available modutils for 2.5 (version 0.7) certainly does none of this.

One of the points being that the breakage comes from changing the
format supported by modutils.  Restoring current functionality should
IMO be high on the agenda .... USB has worked poorly in normal .configs
for a while now, because of this.

- Dave



